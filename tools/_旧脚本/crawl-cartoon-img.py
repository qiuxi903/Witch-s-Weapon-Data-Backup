# 下载官网四格漫画全部图片
import io, os, sys, re, json, time, subprocess
from collections import OrderedDict

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
BASE = os.path.join(R, '提取资源', '网络资源', '13_官网日服witchs-weapon.net')
CDIR = os.path.join(BASE, 'cartoon')
IMGD = os.path.join(BASE, 'cartoon_img')
os.makedirs(IMGD, exist_ok=True)
PROXY = 'http://127.0.0.1:7897'

# ---------- 1) 从所有页面提取漫画信息 ----------
strips = OrderedDict()
for f in sorted(os.listdir(CDIR)):
    if not f.endswith('.php'):
        continue
    c = io.open(os.path.join(CDIR, f), encoding='utf-8', errors='replace').read()
    imgs = re.findall(r'<img[^>]+src="(https://witchs-weapon\.net/wp/wp-content/uploads/[^"]+)"[^>]*alt="([^"]*)"', c)
    if not imgs:
        continue
    # 取 alt 作为标题
    title = imgs[0][1] if imgs else ''
    urls = [u for u, a in imgs]
    # 日期
    md = re.search(r'uploads/(\d{4})/(\d{2})/', urls[0]) if urls else None
    date = ('%s-%s' % (md.group(1), md.group(2))) if md else ''
    cid = int(f[:-4])
    strips[cid] = {'id': cid, 'title': title, 'date': date, 'urls': urls}

print('四格漫画 %d 篇' % len(strips))
tot_imgs = sum(len(s['urls']) for s in strips.values())
print('图片总数 %d' % tot_imgs)

# ---------- 2) 下载 ----------
def dl(url, path, timeout=30):
    if os.path.exists(path) and os.path.getsize(path) > 1000:
        return True
    try:
        r = subprocess.run(['curl.exe', '-sL', '-x', PROXY, '--max-time', str(timeout),
                            '-o', path, url], capture_output=True, timeout=timeout + 15)
        return os.path.exists(path) and os.path.getsize(path) > 1000
    except Exception:
        return False

n_ok = 0
n_fail = 0
for cid, s in strips.items():
    local = []
    for i, u in enumerate(s['urls'], 1):
        name = '%04d_%02d.png' % (cid, i)
        p = os.path.join(IMGD, name)
        if dl(u, p):
            local.append(name); n_ok += 1
        else:
            n_fail += 1
    s['local'] = local
    if n_ok % 60 == 0 and n_ok:
        print('  已下载 %d ...' % n_ok)

print()
print('下载成功 %d, 失败 %d' % (n_ok, n_fail))

# ---------- 3) 保���清单 ----------
out = [{'id': s['id'], 'title': s['title'], 'date': s['date'],
        'imgs': s.get('local', [])} for s in strips.values()]
json.dump(out, io.open(os.path.join(BASE, 'cartoon.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)

# ---------- 4) 生成画廊 ----------
def esc(x):
    return (x or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')

blocks = []
for s in out:
    if not s['imgs']:
        continue
    panels = ''.join('<img src="提取资源/网络资源/13_官网日服witchs-weapon.net/cartoon_img/%s" loading="lazy" alt="">' % esc(n)
                     for n in s['imgs'])
    blocks.append('''<article class="strip">
  <div class="hd"><span class="no">%04d</span><span class="ttl">%s</span><span class="dt">%s</span></div>
  <div class="panels">%s</div>
</article>''' % (s['id'], esc(s['title']), esc(s['date']), panels))

html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》官方四格漫画</title>
<style>
:root{--bg:#0f1116;--panel:#171a21;--line:#2a2f3a;--fg:#e6e3de;--dim:#8f96a3;--accent:#c9a227}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);line-height:1.7;
font-family:"Noto Sans SC","Microsoft YaHei",sans-serif}
header{padding:52px 48px 32px;border-bottom:1px solid var(--line);
background:linear-gradient(160deg,#1a1d26,#0f1116 70%)}
.eyebrow{font-size:11px;letter-spacing:.34em;color:var(--accent);margin-bottom:12px;
font-family:ui-monospace,monospace}
h1{font-size:36px;margin:0 0 8px;letter-spacing:.08em;font-weight:600}
.en{font-size:11.5px;letter-spacing:.3em;color:var(--dim);margin-bottom:18px;
font-family:ui-monospace,monospace}
.meta{font-size:13px;color:var(--dim);line-height:2}
.meta b{color:var(--fg)}
main{padding:32px 48px 80px;max-width:1100px}
.strip{background:var(--panel);border:1px solid var(--line);border-radius:7px;
padding:14px 16px 16px;margin-bottom:20px}
.hd{display:flex;align-items:baseline;gap:12px;margin-bottom:12px;flex-wrap:wrap}
.no{font-size:12px;color:var(--accent);font-family:ui-monospace,monospace;font-weight:600}
.ttl{font-size:16px;color:var(--fg);font-weight:600}
.dt{font-size:11px;color:#5f6674;font-family:ui-monospace,monospace;margin-left:auto}
.panels{display:grid;grid-template-columns:repeat(auto-fit,minmax(200px,1fr));gap:8px}
.panels img{width:100%;border-radius:4px;background:#0b0d11;display:block}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}.panels{grid-template-columns:repeat(2,1fr)}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / OFFICIAL 4-KOMA</div>
<h1>《魔女兵器》官方四格漫画</h1>
<div class="en">OFFICIAL 4-KOMA · __N__ STRIPS</div>
<div class="meta">
<b>篇数</b>：__N__ 篇 · __IMG__ 张图<br>
<b>来源</b>：日服官网 <code>witchs-weapon.net/cartoon/</code>（已停更，页面仍在线）<br>
<b>发行</b>：EXNOA LLC / SUIKINREI
</div></header>
<main>__BODY__</main>
<footer>
<b>《魔女兵器》官方四��漫画</b><br>
抓取自日服官网 · 游戏开发：北京水琴铃（WaterBell）· 日服发行：EXNOA LLC<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer></body></html>'''

html = (html.replace('__BODY__', '\n'.join(blocks))
            .replace('__N__', str(len([s for s in out if s['imgs']])))
            .replace('__IMG__', str(n_ok)))
io.open(os.path.join(R, '魔女兵器_官方四格漫画.html'), 'w', encoding='utf-8').write(html)
print('已生成 四格漫画页')
