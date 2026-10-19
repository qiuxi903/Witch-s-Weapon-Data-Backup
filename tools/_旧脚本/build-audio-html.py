# 生成音频试听页（用 sound.csv 官方清单 + 本地文件）
import io, os, sys, re, csv, json
from collections import OrderedDict

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
CFG  = os.path.join(R, '配置表_解密版', '怀旧服v128')
AUD  = os.path.join(R, '音频资源_整理')
OUT  = os.path.join(R, '魔女兵器_音频图鉴.html')

# 官方清单
rows = list(csv.reader(io.open(os.path.join(CFG, 'sound.csv'), encoding='utf-8', errors='replace')))
hdr = rows[0]
idx = {k: i for i, k in enumerate(hdr) if k}
cat = []
for r in rows[3:]:
    if len(r) < 2 or not r[0].strip():
        continue
    p = r[1].strip() if len(r) > 1 else ''
    cat.append({
        'id': r[0].strip(), 'path': p,
        'type': r[2].strip() if len(r) > 2 else '',
        'grade': r[3].strip() if len(r) > 3 else '',
        'loop': r[6].strip() if len(r) > 6 else '',
        'tag': r[7].strip() if len(r) > 7 else '',
        'desc': r[9].strip() if len(r) > 9 else '',
        'base': os.path.splitext(os.path.basename(p.replace('\\', '/')))[0].lower(),
    })
print('官方音频清单 %d 条' % len(cat))

# 本地文件索引
local = {}
for dp, dn, fn in os.walk(AUD):
    for f in fn:
        if f.lower().endswith(('.wav', '.mp3', '.ogg', '.m4a')):
            b = os.path.splitext(f)[0].lower()
            local.setdefault(b, os.path.join(dp, f))
print('本地音频 %d 个' % len(local))

# 匹配
hit = 0
for c in cat:
    p = local.get(c['base'])
    if p:
        c['local'] = os.path.relpath(p, R).replace('\\', '/'); hit += 1
    else:
        c['local'] = ''
print('匹配 %d / %d' % (hit, len(cat)))

# 分类
def catof(p):
    q = p.replace('\\', '/')
    if q.startswith('Sounds/cv'): return 'CV 语音'
    if q.startswith('Sounds/bgm'): return 'BGM 原声'
    if q.startswith('Sounds/fight'): return '战斗音效'
    if q.lower().startswith('sounds/mainui'): return '界面音效'
    if q.startswith('!NO_USE'): return '废弃资源'
    return '其它'

groups = OrderedDict()
for c in cat:
    groups.setdefault(catof(c['path']), []).append(c)

def esc(s):
    return (s or '').replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;').replace('"', '&quot;')

# CV 按角色分组
def cv_group(path):
    m = re.search(r'cv/(servant\d+|player)', path, re.I)
    return m.group(1) if m else 'other'

blocks = []
for gname, items in groups.items():
    avail = sum(1 for x in items if x['local'])
    blocks.append('<section><h2>%s</h2><div class="cnt">%d 条 · 本地已有 %d</div>'
                  % (esc(gname), len(items), avail))
    if gname == 'CV 语音':
        sub = OrderedDict()
        for x in items:
            sub.setdefault(cv_group(x['path']), []).append(x)
        for sg, sitems in sorted(sub.items()):
            blocks.append('<h3 class="sub">%s <span>%d 条</span></h3><div class="list">' % (esc(sg), len(sitems)))
            for x in sitems:
                nm = os.path.basename(x['path'].replace('\\', '/'))
                if x['local']:
                    blocks.append('<div class="row"><span class="nm">%s</span>'
                                  '<audio controls preload="none" src="%s"></audio></div>'
                                  % (esc(nm), esc(x['local'])))
                else:
                    blocks.append('<div class="row miss"><span class="nm">%s</span>'
                                  '<span class="no">未提取</span></div>' % esc(nm))
            blocks.append('</div>')
    else:
        blocks.append('<div class="list">')
        for x in items:
            nm = os.path.basename(x['path'].replace('\\', '/'))
            d = (' · %s' % esc(x['desc'])) if x['desc'] else ''
            if x['local']:
                blocks.append('<div class="row"><span class="nm">%s</span>%s'
                              '<audio controls preload="none" src="%s"></audio></div>'
                              % (esc(nm), d, esc(x['local'])))
            else:
                blocks.append('<div class="row miss"><span class="nm">%s</span>%s'
                              '<span class="no">未提取</span></div>' % (esc(nm), d))
        blocks.append('</div>')
    blocks.append('</section>')

have = sum(1 for c in cat if c['local'])
html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》音频图鉴</title>
<style>
:root{--bg:#0f1116;--panel:#171a21;--line:#2a2f3a;--fg:#e6e3de;--dim:#8f96a3;
--accent:#c9a227;--accent2:#7fb3d5}
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
main{padding:32px 48px 80px;max-width:1200px}
section{margin-bottom:44px}
section>h2{font-size:22px;color:var(--accent);margin:0 0 4px;letter-spacing:.05em;font-weight:600}
.cnt{font-size:12px;color:var(--dim);margin-bottom:18px;font-family:ui-monospace,monospace}
h3.sub{font-size:14px;color:var(--accent2);margin:22px 0 8px;font-family:ui-monospace,monospace;font-weight:600}
h3.sub span{color:var(--dim);font-weight:400}
.list{display:grid;grid-template-columns:repeat(auto-fill,minmax(330px,1fr));gap:8px}
.row{background:var(--panel);border:1px solid var(--line);border-radius:5px;
padding:9px 12px;display:flex;flex-direction:column;gap:6px}
.row.miss{opacity:.45}
.nm{font-size:12px;color:#c3c8d1;font-family:ui-monospace,monospace;
overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.row .no{font-size:11px;color:#6b7484;font-family:ui-monospace,monospace}
audio{width:100%;height:30px}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}.list{grid-template-columns:1fr}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / AUDIO</div>
<h1>《魔女兵器》音频图鉴</h1>
<div class="en">AUDIO ARCHIVE · __TOTAL__ ENTRIES</div>
<div class="meta">
<b>清单来源</b>：游戏配置表 <code>sound.csv</code>（官方音频索引，已解密）<br>
<b>音频文件</b>：客户端 AssetBundle 导出（WAV / MP3）<br>
<b>规模</b>：官方登记 __TOTAL__ 条 · 本地已有 <b>__HAVE__</b> 条<br>
<b>分类</b>：CV 语音 / BGM 原声 / 战斗音效 / 界面音效 / 废弃资源
</div></header>
<main>
__BODY__
</main>
<footer>
<b>《魔女兵器》音频图鉴</b><br>
配置表解密：XOR 0xFF · 游戏开发：北京水琴铃（WaterBell）<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer></body></html>'''

html = (html.replace('__TOTAL__', str(len(cat)))
            .replace('__HAVE__', str(have))
            .replace('__BODY__', '\n'.join(blocks)))
io.open(OUT, 'w', encoding='utf-8').write(html)
print('已生成: %s (%.2f MB)' % (OUT, os.path.getsize(OUT) / 1024 / 1024))
