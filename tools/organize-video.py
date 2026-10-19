# 归档视频与着色器（去重）
import io, os, sys, re, hashlib, shutil, json
from collections import defaultdict

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
OUTV = os.path.join(R, '视频资源_整理')
OUTS = os.path.join(R, '着色器_整理')
os.makedirs(OUTV, exist_ok=True)
os.makedirs(OUTS, exist_ok=True)

REGION = [
    ('国服v2.0.1_完整解包', '国服'),
    ('怀旧服v128_完整解包', '怀旧服'),
    ('日服v2.0.0_OBB解包', '日服'),
    ('港澳台v1.6.0_OBB解包', '港澳台'),
    ('韩服v1.0_OBB解包', '韩服'),
]
def region_of(p):
    for k, v in REGION:
        if k in p: return v
    return '其它'

# ---------- 1) 视频去重归档 ----------
h = defaultdict(list)
for dp, dn, fn in os.walk(os.path.join(R, '提取资源')):
    for f in fn:
        if f.lower().endswith(('.mp4', '.ogv', '.webm')):
            p = os.path.join(dp, f)
            with open(p, 'rb') as fh:
                d = hashlib.md5(fh.read()).hexdigest()
            h[d].append(p)

print('=== 视频去重 ===')
vids = []
for d, v in h.items():
    v.sort(key=lambda x: (region_of(x) == '国服', len(x)), reverse=True)
    best = v[0]
    regs = sorted(set(region_of(x) for x in v))
    name = os.path.basename(best)
    dst = os.path.join(OUTV, name)
    if not os.path.exists(dst):
        try: shutil.copy2(best, dst)
        except Exception: continue
    vids.append({'name': name, 'bytes': os.path.getsize(best), 'regions': regs,
                 'copies': len(v), 'src': best})
    print('  %-22s %11s  x%d  %s' % (name, '{:,}'.format(os.path.getsize(best)),
                                     len(v), '/'.join(regs)))

vids.sort(key=lambda x: -x['bytes'])
print()
print('独立视频 %d 个, %.1f MB' % (len(vids), sum(v['bytes'] for v in vids) / 1024 / 1024))

# ---------- 2) 着色器归档 ----------
sh = defaultdict(list)
for dp, dn, fn in os.walk(os.path.join(R, '提取资源')):
    for f in fn:
        if f.lower().endswith('.shader'):
            p = os.path.join(dp, f)
            with open(p, 'rb') as fh:
                d = hashlib.md5(fh.read()).hexdigest()
            sh[d].append(p)
print()
print('=== 着色器去重 ===')
n = 0
for d, v in sh.items():
    best = v[0]
    name = os.path.basename(best)
    dst = os.path.join(OUTS, name)
    if os.path.exists(dst):
        stem, ext = os.path.splitext(name)
        dst = os.path.join(OUTS, '%s_%s%s' % (stem, d[:6], ext))
    try:
        shutil.copy2(best, dst); n += 1
    except Exception:
        pass
print('独立着色器 %d 个 (原 %d)' % (n, sum(len(v) for v in sh.values())))

# ---------- 3) 写清单 ----------
json.dump(vids, io.open(os.path.join(OUTV, '_index.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)

# ---------- 4) 视频页 ----------
def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')

cards = []
for i, v in enumerate(vids, 1):
    reg = ' · '.join(v['regions'])
    cards.append('''<article class="v">
  <video controls preload="metadata" src="视频资源_整理/%s"></video>
  <div class="meta">
    <div class="hd"><span class="nm">%s</span><span class="idx">%02d</span></div>
    <div class="sub">%.1f MB · %s</div>
  </div>
</article>''' % (esc(v['name']), esc(v['name']), i, v['bytes'] / 1024 / 1024, esc(reg)))

html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》视频资源</title>
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
.meta2{font-size:13px;color:var(--dim);line-height:2}
.meta2 b{color:var(--fg)}
main{padding:32px 48px 80px;max-width:1500px}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(400px,1fr));gap:18px}
.v{background:var(--panel);border:1px solid var(--line);border-radius:6px;overflow:hidden}
video{width:100%;display:block;background:#000;max-height:260px}
.meta{padding:10px 13px 13px}
.hd{display:flex;justify-content:space-between;gap:10px;margin-bottom:3px}
.nm{font-size:13px;color:#d8d3ca;font-family:ui-monospace,monospace}
.idx{font-size:11px;color:var(--accent);font-family:ui-monospace,monospace}
.sub{font-size:11px;color:#5f6674;font-family:ui-monospace,monospace}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}.grid{grid-template-columns:1fr}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / VIDEO ARCHIVE</div>
<h1>《魔女兵器》视频资源</h1>
<div class="en">VIDEO ARCHIVE · __N__ CLIPS</div>
<div class="meta2">
<b>视频</b>：__N__ 个独立文件 · __MB__ MB（已按内容去重）<br>
<b>内容</b>：PV 宣传片 · 剧情过场动画 · 各服独占版本<br>
<b>来源</b>：五区客户端 <code>assets/assetbundle/video/</code>
</div></header>
<main><div class="grid">__CARDS__</div></main>
<footer>
<b>《魔女兵器》视频资源</b><br>
游戏开发：北京水琴铃（WaterBell）· 日服发行：EXNOA LLC<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer></body></html>'''

html = (html.replace('__CARDS__', '\n'.join(cards))
            .replace('__N__', str(len(vids)))
            .replace('__MB__', '%.0f' % (sum(v['bytes'] for v in vids) / 1024 / 1024)))
io.open(os.path.join(R, '魔女兵器_视频资源.html'), 'w', encoding='utf-8').write(html)
print('已生成 视频资源页')
