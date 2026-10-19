# 重新提取官网公告（正确解析 h1 + .entrybody）
import io, os, sys, re, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
SRC  = os.path.join(R, '提取资源', '网络资源', '05_文本', '官网公告')
OUTA = os.path.join(R, '官网公告_整理')
os.makedirs(OUTA, exist_ok=True)

def txt(s):
    s = re.sub(r'<script[\s\S]*?</script>', '', s, flags=re.I)
    s = re.sub(r'<style[\s\S]*?</style>', '', s, flags=re.I)
    s = re.sub(r'<br\s*/?>', '\n', s, flags=re.I)
    s = re.sub(r'</(p|div|h\d|li|tr|td)>', '\n', s, flags=re.I)
    s = re.sub(r'<[^>]+>', '', s)
    for a, b in [('&nbsp;',' '),('&amp;','&'),('&lt;','<'),('&gt;','>'),
                 ('&quot;','"'),('&#39;',"'"),('&rsquo;','’'),('&ldquo;','“'),('&rdquo;','”')]:
        s = s.replace(a, b)
    s = re.sub(r'[ \t]+', ' ', s)
    s = re.sub(r'\n\s*\n\s*\n+', '\n\n', s)
    return s.strip()

news = []
for f in sorted(os.listdir(SRC)):
    if not f.endswith('.php'):
        continue
    c = io.open(os.path.join(SRC, f), encoding='utf-8', errors='replace').read()

    # 标题：h1 里非 "NEWS" 的那个
    title = ''
    for m in re.findall(r'<h1[^>]*>([\s\S]*?)</h1>', c):
        t = txt(m)
        if t and t.upper() != 'NEWS':
            title = t; break
    if not title:
        m = re.search(r'<title>(.*?)</title>', c, re.S)
        title = txt(m.group(1)) if m else f

    # 日期
    date = ''
    m = re.search(r'(20\d{2})\s*[年./-]\s*(\d{1,2})\s*[月./-]\s*(\d{1,2})', c)
    if m:
        date = '%s-%02d-%02d' % (m.group(1), int(m.group(2)), int(m.group(3)))

    # 正文
    body = ''
    m = re.search(r'<div[^>]*class="[^"]*entrybody[^"]*"[^>]*>([\s\S]*?)</div>\s*(?:</div>|<div[^>]*class="[^"]*(?:scroll|footer))', c)
    if not m:
        m = re.search(r'<div[^>]*class="[^"]*entrybody[^"]*"[^>]*>([\s\S]{0,6000})', c)
    if m:
        body = txt(m.group(1))
    if not body:
        m = re.search(r'<div[^>]*class="[^"]*details[^"]*"[^>]*>([\s\S]*?)</div>\s*</div>', c)
        if m: body = txt(m.group(1))

    cid = int(re.search(r'(\d+)', f).group(1))
    news.append({'id': cid, 'file': f, 'title': title, 'date': date, 'body': body})

news.sort(key=lambda x: x['id'])
print('公告 %d 条' % len(news))
print('  有标题 %d, 有日期 %d, 有正文 %d' % (
    sum(1 for x in news if x['title'] and 'Witch' not in x['title']),
    sum(1 for x in news if x['date']),
    sum(1 for x in news if len(x['body']) > 50)))

# 保存文本
for x in news:
    io.open(os.path.join(OUTA, 'info_%d.txt' % x['id']), 'w', encoding='utf-8').write(
        '%s\n%s\n\n%s' % (x['title'], x['date'], x['body']))

json.dump([{k: v for k, v in x.items() if k != 'body'} for x in news],
          io.open(os.path.join(OUTA, '_index.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)

print()
print('=== 样例 ===')
for x in news[:12]:
    print('  %-10s %s' % (x['date'] or '?', x['title'][:64]))

def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')

items = []
for x in news:
    b = x['body'] if len(x['body']) > 40 else '（正文未抓取到，页面可能已下线）'
    items.append('''<article class="n">
  <div class="hd"><span class="no">#%d</span><span class="dt">%s</span><span class="ttl">%s</span></div>
  <div class="bd">%s</div>
</article>''' % (x['id'], esc(x['date']), esc(x['title']), esc(b[:3000]).replace('\n', '<br>')))

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
.no{font-size:11px;color:#5f6674;font-family:ui-monospace,monospace}
.dt{font-size:11.5px;color:var(--accent);font-family:ui-monospace,monospace}
.ttl{font-size:15px;color:var(--fg);font-weight:600}
.bd{font-size:13px;color:#b9bfc9;max-height:320px;overflow:auto}
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
<b>时间跨度</b>：__D1__ ~ __D2__<br>
<b>语言</b>：日文原文 · 官网仍在线但大部分历史 ID 已 404
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
    NS.forEach(n => { n.style.display = (!k || n.textContent.toLowerCase().includes(k)) ? '' : 'none'; });
  }, 150);
};
</script></body></html>'''

ds = sorted(x['date'] for x in news if x['date'])
html = (html.replace('__BODY__', '\n'.join(items))
            .replace('__N__', str(len(news)))
            .replace('__D1__', ds[0] if ds else '?')
            .replace('__D2__', ds[-1] if ds else '?'))
io.open(os.path.join(R, '魔女兵器_官网公告归档.html'), 'w', encoding='utf-8').write(html)
print()
print('已生成 官网公告归档页')
