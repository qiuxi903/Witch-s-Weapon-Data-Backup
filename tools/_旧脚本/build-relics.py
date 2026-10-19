# 「开发遗迹」专题页：废弃资源 + 保留地图 + 未上线内容 + 版本差异
import io, os, sys, re, csv, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
CFG  = os.path.join(R, '配置表_解密版', '怀旧服v128')
OUT  = os.path.join(R, '魔女兵器_开发遗迹.html')

def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')

# ---------- 1) sound.csv 里的 !NO_USE! ----------
srows = list(csv.reader(io.open(os.path.join(CFG, 'sound.csv'), encoding='utf-8', errors='replace')))
nouse = []
for r in srows[3:]:
    if len(r) >= 2 and r[1].strip().startswith('!NO_USE!'):
        nouse.append({'id': r[0].strip(), 'path': r[1].strip(),
                      'desc': r[9].strip() if len(r) > 9 else ''})
print('!NO_USE! 废弃资源 %d 条' % len(nouse))

# ---------- 2) 保留场景清单 ----------
man = os.path.join(R, '提取资源', '怀旧服v128_导出', '保留场景清单.txt')
maps = []
if os.path.exists(man):
    for l in io.open(man, encoding='utf-8', errors='replace'):
        l = l.strip()
        if l:
            maps.append(l)
print('保留场景 %d 条' % len(maps))

# ---------- 3) 未上线剧情 ----------
newdir = os.path.join(R, '剧情文本_解密版', '怀旧服v128_未上线剧情')
neweps = []
if os.path.isdir(newdir):
    for f in sorted(os.listdir(newdir)):
        if f.endswith('.txt'):
            c = io.open(os.path.join(newdir, f), encoding='utf-8').read()
            lines = [l for l in c.split('\n') if l.strip()]
            first = ''
            for l in lines:
                p = l.split('\t')
                if len(p) >= 3 and p[2].strip():
                    first = p[2].strip(); break
            neweps.append({'file': f[:-4], 'lines': len(lines), 'chars': len(c), 'first': first})
print('未上线剧情 %d 个' % len(neweps))

# ---------- 4) 版本差异（怀旧服独有）----------
diff_file = os.path.join(R, '提取资源', '怀旧服v128_导出', 'revival_only.txt')
revival_only = []
for cand in ['revival_only.txt', '怀旧服独有.txt', 'revival_unique.txt']:
    p = os.path.join(R, '提取资源', '怀旧服v128_导出', cand)
    if os.path.exists(p):
        revival_only = [l.strip() for l in io.open(p, encoding='utf-8', errors='replace') if l.strip()]
        break
print('怀旧服独有清单 %d 条' % len(revival_only))

# ---------- 5) 配置表里的废弃/异常 ----------
drows = [l.rstrip('\n').split('\t') for l in io.open(os.path.join(CFG, 'dictionarystatic.csv'), encoding='utf-8', errors='replace')]
notes = [r for r in drows[2:] if len(r) >= 2 and r[0].strip().startswith('/*****')]
print('注释分隔 %d 条' % len(notes))

# ---------- 生成 HTML ----------
def table(rows, heads, widths=None):
    h = '<table><thead><tr>' + ''.join('<th>%s</th>' % esc(x) for x in heads) + '</tr></thead><tbody>'
    for r in rows:
        h += '<tr>' + ''.join('<td>%s</td>' % esc(x) for x in r) + '</tr>'
    return h + '</tbody></table>'

sec = []

# 未上线剧情
sec.append('<section><h2 style="border-left:4px solid #d98cb3;padding-left:12px">未上线剧情</h2>'
           '<div class="cnt">国服 lesson 目录止于 sentence_30318 · 以下 4 个来自怀旧服 v128</div>')
for e in neweps:
    sec.append('<div class="card"><div class="hd"><span class="nm">%s</span>'
               '<span class="mt">%d 行 · %s 字符</span></div>'
               '<div class="tx">%s</div></div>'
               % (esc(e['file']), e['lines'], '{:,}'.format(e['chars']), esc(e['first'][:150])))
sec.append('</section>')

# 保留场景
if maps:
    sec.append('<section><h2 style="border-left:4px solid #8fc9a0;padding-left:12px">保留场景清单</h2>'
               '<div class="cnt">preserved_stage_manifest.ab · %d 条</div>'
               '<div class="chips">' % len(maps))
    for m in maps:
        cls = 'hi' if m.endswith('!') else ('test' if 'test' in m.lower() else '')
        sec.append('<span class="chip %s">%s</span>' % (cls, esc(m)))
    sec.append('</div></section>')

# 废弃资源
if nouse:
    sec.append('<section><h2 style="border-left:4px solid #c9a27f;padding-left:12px">官方废弃资源</h2>'
               '<div class="cnt">sound.csv 中 <code>!NO_USE!</code> 前缀 · %d 条</div>'
               '<div class="scroll">' % len(nouse))
    sec.append(table([[n['id'], os.path.basename(n['path'].replace('\\','/')), n['desc']] for n in nouse],
                     ['ID', '资源名', '描述']))
    sec.append('</div></section>')

# 怀旧服独有
if revival_only:
    sec.append('<section><h2 style="border-left:4px solid #7fb3d5;padding-left:12px">怀旧服独有资源</h2>'
               '<div class="cnt">国服 0 个 · 怀旧服 %d 个</div><div class="scroll">' % len(revival_only))
    sec.append(table([[x] for x in revival_only[:600]], ['路径']))
    sec.append('</div></section>')

# 注释
if notes:
    sec.append('<section><h2 style="border-left:4px solid #6b7484;padding-left:12px">配置表注释行</h2>'
               '<div class="cnt">dictionarystatic 中 <code>/*****</code> 分隔注释 · %d 条</div>'
               '<div class="scroll">' % len(notes))
    sec.append(table([[n[0].strip(), n[1].strip()] for n in notes], ['tag', '内容']))
    sec.append('</div></section>')

html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》开发遗迹</title>
<style>
:root{--bg:#0f1116;--panel:#171a21;--line:#2a2f3a;--fg:#e6e3de;--dim:#8f96a3;--accent:#c9a227}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);line-height:1.75;
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
main{padding:32px 48px 80px;max-width:1400px}
section{margin-bottom:46px}
section>h2{font-size:21px;color:var(--fg);margin:0 0 4px;font-weight:600}
.cnt{font-size:11.5px;color:var(--dim);margin-bottom:18px;font-family:ui-monospace,monospace}
.cnt code{color:#7fb3d5}
.card{background:var(--panel);border:1px solid var(--line);border-radius:5px;
padding:12px 15px;margin-bottom:10px}
.hd{display:flex;justify-content:space-between;gap:12px;margin-bottom:6px}
.nm{font-size:13px;color:#d98cb3;font-family:ui-monospace,monospace;font-weight:600}
.mt{font-size:11px;color:#5f6674;font-family:ui-monospace,monospace}
.tx{font-size:13.5px;color:#c3c8d1}
.chips{display:flex;flex-wrap:wrap;gap:7px}
.chip{background:var(--panel);border:1px solid var(--line);border-radius:4px;
padding:4px 10px;font-size:12px;color:#b9bfc9;font-family:ui-monospace,monospace}
.chip.hi{border-color:#d98cb3;color:#e8a8c8}
.chip.test{border-color:#c9a227;color:#e0c86a}
table{border-collapse:collapse;width:100%;font-size:12.5px}
th,td{padding:6px 10px;border-bottom:1px solid var(--line);text-align:left;vertical-align:top}
th{background:#1c2029;color:#7fb3d5;font-family:ui-monospace,monospace;font-size:11.5px;
position:sticky;top:0}
tbody tr:hover{background:#1a1e27}
.scroll{max-height:460px;overflow:auto;border:1px solid var(--line);border-radius:6px}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / DEVELOPMENT RELICS</div>
<h1>《魔女兵器》开发遗迹</h1>
<div class="en">DEVELOPMENT RELICS · CUT CONTENT &amp; ARTIFACTS</div>
<div class="meta">
<b>内容</b>：未上线剧情 · 保留场景 · 官方废弃资源 · 怀旧服独有 · 配置表注释<br>
<b>来源</b>：客户端解密 + 怀旧服 v128 对比
</div></header>
<main>__BODY__</main>
<footer>
<b>《魔女兵器》开发遗迹</b><br>
配置表解密：XOR 0xFF · 游戏开发：北京水琴铃（WaterBell）<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer></body></html>'''

io.open(OUT, 'w', encoding='utf-8').write(html.replace('__BODY__', '\n'.join(sec)))
print()
print('已生成: %s (%.2f MB)' % (OUT, os.path.getsize(OUT) / 1024 / 1024))
