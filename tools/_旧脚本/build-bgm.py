# BGM 播放列表（带立绘封面）+ 开发遗迹专题页
import io, os, sys, re, csv, json, shutil
from collections import OrderedDict

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
CFG  = os.path.join(R, '配置表_解密版', '怀旧服v128')
AUD  = os.path.join(R, '音频资源_整理')
ART  = os.path.join(R, '美术素材_分类')
IMGD = os.path.join(R, 'assets', 'chara')
os.makedirs(IMGD, exist_ok=True)

# ============ 1) BGM 列表 ============
bgm_dir = os.path.join(AUD, 'BGM原声')
bgms = []
if os.path.isdir(bgm_dir):
    for dp, dn, fn in os.walk(bgm_dir):
        for f in sorted(fn):
            if f.lower().endswith(('.wav', '.mp3', '.ogg', '.m4a')):
                p = os.path.join(dp, f)
                bgms.append({'name': os.path.splitext(f)[0], 'file': p,
                             'rel': os.path.relpath(p, R).replace('\\', '/'),
                             'bytes': os.path.getsize(p)})
bgms.sort(key=lambda x: x['name'])
print('BGM %d 首' % len(bgms))

# 官方 bgm 清单
srows = list(csv.reader(io.open(os.path.join(CFG, 'sound.csv'), encoding='utf-8', errors='replace')))
official = []
for r in srows[3:]:
    if len(r) >= 2 and r[1].strip().lower().startswith('sounds/bgm'):
        official.append({'path': r[1].strip(), 'id': r[0].strip(),
                          'desc': r[9].strip() if len(r) > 9 else '',
                          'loop': r[6].strip() if len(r) > 6 else ''})
print('官方 BGM 登记 %d 首' % len(official))

# 用立绘做封面
def scan(sub):
    d = os.path.join(ART, sub); out = []
    if os.path.isdir(d):
        for dp, dn, fn in os.walk(d):
            for f in fn:
                if f.lower().endswith(('.png','.jpg','.jpeg')): out.append(os.path.join(dp, f))
    return sorted(out)
cards = scan('01_角色卡面')
def stage(src, name):
    ext = os.path.splitext(src)[1].lower()
    dst = os.path.join(IMGD, name + ext)
    if not os.path.exists(dst):
        try: shutil.copy2(src, dst)
        except Exception: return ''
    return 'assets/chara/' + os.path.basename(dst)

covers = []
for i, p in enumerate(cards):
    b = os.path.basename(p)
    if '_bg' in b: continue
    r = stage(p, 'bgmcover_%02d' % len(covers))
    if r: covers.append(r)
    if len(covers) >= 24: break
print('封面 %d 张' % len(covers))

def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')

cards_html = []
for i, b in enumerate(bgms):
    cov = covers[i % len(covers)] if covers else ''
    img = ('<img src="%s" loading="lazy" alt="">' % cov) if cov else '<div class="noimg">♪</div>'
    mb = b['bytes'] / 1024 / 1024
    cards_html.append('''<article class="trk">
  <div class="cov">%s<div class="idx">%02d</div></div>
  <div class="meta">
    <div class="nm">%s</div>
    <div class="sz">%.1f MB</div>
    <audio controls preload="none" src="%s"></audio>
  </div>
</article>''' % (img, i + 1, esc(b['name']), mb, esc(b['rel'])))

off_rows = ''.join('<tr><td class="idx">%s</td><td>%s</td><td>%s</td></tr>'
                   % (esc(o['id']), esc(os.path.basename(o['path'])), esc(o['desc']))
                   for o in official[:120])

total_mb = sum(b['bytes'] for b in bgms) / 1024 / 1024
html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》BGM 原声集</title>
<style>
:root{--bg:#0f1116;--panel:#171a21;--panel2:#1e222b;--line:#2a2f3a;--fg:#e6e3de;
--dim:#8f96a3;--accent:#c9a227;--accent2:#7fb3d5}
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
main{padding:32px 48px 80px;max-width:1500px}
h2{font-size:21px;color:var(--accent);margin:0 0 4px;font-weight:600}
.cnt{font-size:11.5px;color:var(--dim);margin-bottom:18px;font-family:ui-monospace,monospace}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(260px,1fr));gap:14px}
.trk{background:var(--panel);border:1px solid var(--line);border-radius:6px;overflow:hidden}
.cov{position:relative;height:150px;background:#0b0d11;overflow:hidden}
.cov img{width:100%;height:100%;object-fit:cover;filter:brightness(.8);transition:transform .4s,filter .4s}
.trk:hover .cov img{transform:scale(1.07);filter:brightness(1)}
.idx{position:absolute;top:8px;left:8px;background:rgba(15,17,22,.85);border:1px solid var(--line);
border-radius:3px;padding:1px 7px;font-size:11px;color:var(--accent);font-family:ui-monospace,monospace}
.noimg{display:flex;align-items:center;justify-content:center;height:100%;color:#3a4150;font-size:34px}
.meta{padding:10px 12px 12px}
.nm{font-size:12.5px;color:#d8d3ca;font-family:ui-monospace,monospace;
overflow:hidden;text-overflow:ellipsis;white-space:nowrap;margin-bottom:2px}
.sz{font-size:10.5px;color:#5f6674;font-family:ui-monospace,monospace;margin-bottom:7px}
audio{width:100%;height:30px}
table{border-collapse:collapse;width:100%;font-size:12.5px;margin-top:8px}
th,td{padding:6px 10px;border-bottom:1px solid var(--line);text-align:left}
th{background:#1c2029;color:#7fb3d5;font-family:ui-monospace,monospace;font-size:11.5px}
td.idx{color:#5f6674;font-family:ui-monospace,monospace;white-space:nowrap}
.scroll{max-height:420px;overflow:auto;border:1px solid var(--line);border-radius:6px}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}.grid{grid-template-columns:1fr}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / ORIGINAL SOUNDTRACK</div>
<h1>《魔女兵器》BGM 原声集</h1>
<div class="en">ORIGINAL SOUNDTRACK · __N__ TRACKS</div>
<div class="meta">
<b>曲目</b>：__N__ 首 · __MB__ MB（客户端 AssetBundle 导出）<br>
<b>官方登记</b>：<code>sound.csv</code> 中 <code>Sounds/bgm</code> 共 __OFF__ 条<br>
<b>封面</b>：角色卡面自动配图
</div></header>
<main>
<h2>曲目</h2><div class="cnt">点击播放 · 封面为角色卡面</div>
<div class="grid">__CARDS__</div>
<h2 style="margin-top:44px">官方 BGM 登记表</h2>
<div class="cnt">sound.csv · 显示前 120 条</div>
<div class="scroll"><table>
<thead><tr><th>ID</th><th>文件名</th><th>描述</th></tr></thead>
<tbody>__OFFROWS__</tbody></table></div>
</main>
<footer>
<b>《魔女兵器》BGM 原声集</b><br>
配置表解密：XOR 0xFF · 游戏开发：北京水琴铃（WaterBell）<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer></body></html>'''

html = (html.replace('__CARDS__', '\n'.join(cards_html))
            .replace('__OFFROWS__', off_rows)
            .replace('__N__', str(len(bgms)))
            .replace('__MB__', '%.0f' % total_mb)
            .replace('__OFF__', str(len(official))))
io.open(os.path.join(R, '魔女兵器_BGM原声集.html'), 'w', encoding='utf-8').write(html)
print('已生成 BGM 原声集 (%.2f MB)' % (os.path.getsize(os.path.join(R, '魔女兵器_BGM原声集.html')) / 1024 / 1024))
