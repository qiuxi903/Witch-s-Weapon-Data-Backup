# 归档 Lua 脚本 + 官网公告，并更新总目录
import io, os, sys, re, hashlib, shutil, json, csv
from collections import defaultdict, OrderedDict

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
OUTL = os.path.join(R, 'Lua脚本_整理')
OUTA = os.path.join(R, '官网公告_整理')
os.makedirs(OUTL, exist_ok=True)
os.makedirs(OUTA, exist_ok=True)

# ---------- 1) Lua 归档 ----------
h = defaultdict(list)
for dp, dn, fn in os.walk(os.path.join(R, '提取资源')):
    for f in fn:
        if f.lower().endswith('.lua'):
            p = os.path.join(dp, f)
            with open(p, 'rb') as fh:
                h[hashlib.md5(fh.read()).hexdigest()].append(p)

def modof(p):
    q = p.replace('\\', '/')
    m = re.search(r'luatemp/([^/]+)/', q)
    return m.group(1) if m else 'root'

n = 0
for d, v in h.items():
    best = v[0]
    mod = modof(best)
    dd = os.path.join(OUTL, mod)
    os.makedirs(dd, exist_ok=True)
    dst = os.path.join(dd, os.path.basename(best))
    if os.path.exists(dst):
        stem, ext = os.path.splitext(os.path.basename(best))
        dst = os.path.join(dd, '%s_%s%s' % (stem, d[:6], ext))
    try:
        shutil.copy2(best, dst); n += 1
    except Exception:
        pass
print('Lua 归档 %d 个' % n)

# ---------- 2) 官网公告归档 ----------
src = os.path.join(R, '提取资源', '网络资源', '05_文本', '官网公告')
def strip_html(c):
    c = re.sub(r'<script[\s\S]*?</script>', '', c, flags=re.I)
    c = re.sub(r'<style[\s\S]*?</style>', '', c, flags=re.I)
    c = re.sub(r'<br\s*/?>', '\n', c, flags=re.I)
    c = re.sub(r'</(p|div|h\d|li|tr)>', '\n', c, flags=re.I)
    c = re.sub(r'<[^>]+>', '', c)
    c = c.replace('&nbsp;', ' ').replace('&amp;', '&').replace('&lt;', '<').replace('&gt;', '>')
    c = re.sub(r'\n{3,}', '\n\n', c)
    return c.strip()

news = []
if os.path.isdir(src):
    for f in sorted(os.listdir(src)):
        if not f.endswith('.php'):
            continue
        c = io.open(os.path.join(src, f), encoding='utf-8', errors='replace').read()
        mt = re.search(r'<title>(.*?)</title>', c, re.S)
        title = strip_html(mt.group(1)) if mt else f
        # 日期
        md = re.search(r'(20\d{2})[年./-](\d{1,2})[月./-](\d{1,2})', c)
        date = '%s-%02d-%02d' % (md.group(1), int(md.group(2)), int(md.group(3))) if md else ''
        body = strip_html(c)
        news.append({'file': f, 'title': title, 'date': date, 'body': body})
        io.open(os.path.join(OUTA, f.replace('.php', '.txt')), 'w', encoding='utf-8').write(
            '%s\n%s\n\n%s' % (title, date, body))
print('官网公告归档 %d 条' % len(news))

json.dump([{'file': x['file'], 'title': x['title'], 'date': x['date']} for x in news],
          io.open(os.path.join(OUTA, '_index.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)

# ---------- 3) 生成公告页 ----------
def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')

items = []
for x in sorted(news, key=lambda y: y['date'] or '0000'):
    body = x['body']
    # 去掉页头页脚噪声
    body = re.sub(r'^.*?(?=NEWS|INFO|お知らせ)', '', body, flags=re.S) if len(body) > 2000 else body
    items.append('''<article class="n">
  <div class="hd"><span class="dt">%s</span><span class="ttl">%s</span></div>
  <div class="bd">%s</div>
</article>''' % (esc(x['date']), esc(x['title']), esc(body[:2600]).replace('\n', '<br>')))

html = '''<!DOCTYPE html>
<html lang="ja"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》官网公告归档</title>
<style>
:root{--bg:#0f1116;--panel:#171a21;--line:#2a2f3a;--fg:#e6e3de;--dim:#8f96a3;--accent:#c9a227}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);line-height:1.8;
font-family:"Noto Sans SC","Hiragino Sans","Yu Gothic",sans-serif}
header{padding:52px 48px 32px;border-bottom:1px solid var(--line);
background:linear-gradient(160deg,#1a1d26,#0f1116 70%)}
.eyebrow{font-size:11px;letter-spacing:.34em;color:var(--accent);margin-bottom:12px;
font-family:ui-monospace,monospace}
h1{font-size:36px;margin:0 0 8px;letter-spacing:.08em;font-weight:600}
.en{font-size:11.5px;letter-spacing:.3em;color:var(--dim);margin-bottom:18px;
font-family:ui-monospace,monospace}
.meta{font-size:13px;color:var(--dim);line-height:2}
.meta b{color:var(--fg)}
.bar{padding:11px 48px;border-bottom:1px solid var(--line);background:var(--panel);
position:sticky;top:0;z-index:5}
.bar input{width:100%;max-width:520px;padding:8px 12px;background:#1e222b;
border:1px solid var(--line);border-radius:4px;color:var(--fg);font-size:13px;outline:none}
.bar input:focus{border-color:var(--accent)}
main{padding:30px 48px 80px;max-width:1100px}
.n{background:var(--panel);border:1px solid var(--line);border-radius:6px;
padding:14px 18px;margin-bottom:14px}
.hd{display:flex;align-items:baseline;gap:12px;margin-bottom:9px;flex-wrap:wrap}
.dt{font-size:11.5px;color:var(--accent);font-family:ui-monospace,monospace}
.ttl{font-size:15px;color:var(--fg);font-weight:600}
.bd{font-size:13px;color:#b9bfc9;max-height:340px;overflow:auto}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,.bar,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / OFFICIAL NEWS</div>
<h1>《魔女兵器》官网公告归档</h1>
<div class="en">OFFICIAL NEWS ARCHIVE · __N__ POSTS</div>
<div class="meta">
<b>公告</b>：__N__ 条（日服官网 <code>witchs-weapon.net/news/info/</code>）<br>
<b>状态</b>：官网仍在线，但游戏已停服 · 大部分历史 ID 已 404<br>
<b>语言</b>：日文原文
</div></header>
<div class="bar"><input id="q" placeholder="搜索公告标题或正文..."></div>
<main>__BODY__</main>
<footer>
<b>《魔女兵器》官网公告归档</b><br>
抓取自日服官网 · 游戏开发：北京水琴铃（WaterBell）· 日服发行：EXNOA LLC<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer>
<script>
const NS = [...document.querySelectorAll('.n')];
let t=null;
document.getElementById('q').oninput = e => {
  clearTimeout(t);
  t = setTimeout(() => {
    const k = e.target.value.trim().toLowerCase();
    NS.forEach(n => {
      n.style.display = (!k || n.textContent.toLowerCase().includes(k)) ? '' : 'none';
    });
  }, 150);
};
</script></body></html>'''

html = html.replace('__BODY__', '\n'.join(items)).replace('__N__', str(len(news)))
io.open(os.path.join(R, '魔女兵器_官网公告归档.html'), 'w', encoding='utf-8').write(html)
print('已生成 官网公告归档页')
