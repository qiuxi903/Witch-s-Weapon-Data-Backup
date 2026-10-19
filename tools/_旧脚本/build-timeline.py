# 剧情时间线：活动 + 关卡 + 剧情文件 关联
import io, os, sys, re, csv, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
CFG  = os.path.join(R, '配置表_解密版', '怀旧服v128')
STORY= os.path.join(R, '剧情文本_解密版', '国服v2.0.1')
OUT  = os.path.join(R, '魔女兵器_剧情时间线.html')

def load(name):
    p = os.path.join(CFG, name + '.csv')
    if not os.path.exists(p): return None, None, None, []
    raw = io.open(p, encoding='utf-8', errors='replace').read()
    head = '\n'.join(raw.split('\n')[:3])
    sep = '\t' if head.count('\t') > head.count(',') else ','
    rows = [r for r in csv.reader(io.StringIO(raw), delimiter=sep) if any(x.strip() for x in r)]
    # 找表头行：第一行含 ID
    hi = 0
    for i, r in enumerate(rows[:6]):
        if r and r[0].strip() == 'ID':
            hi = i; break
    fields = [x.strip() for x in rows[hi]]
    labels = [x.strip() for x in rows[hi + 2]] if len(rows) > hi + 2 else fields
    data = rows[hi + 3:]
    return fields, labels, sep, data

# ---------- instance ----------
f_i, l_i, _, rows_i = load('instance')
print('instance: %d 行, %d 列' % (len(rows_i), len(f_i)))
def col(fields, name):
    try: return fields.index(name)
    except ValueError: return -1

ci_name  = col(f_i, 'instance_name')
ci_desc  = col(f_i, 'instance_desc')
ci_act   = col(f_i, 'instance_activity_attached')
ci_type  = col(f_i, 'instance_type')
ci_sub   = col(f_i, 'instance_sub_type')
ci_lv    = col(f_i, 'instance_enter_level')
ci_id    = col(f_i, 'ID')

inst = {}
for r in rows_i:
    if len(r) <= max(ci_name, ci_id) or not r[ci_id].strip(): continue
    inst[r[ci_id].strip()] = {
        'name': r[ci_name].strip() if ci_name >= 0 and len(r) > ci_name else '',
        'desc': r[ci_desc].strip() if ci_desc >= 0 and len(r) > ci_desc else '',
        'act':  r[ci_act].strip() if ci_act >= 0 and len(r) > ci_act else '',
        'type': r[ci_type].strip() if ci_type >= 0 and len(r) > ci_type else '',
        'lv':   r[ci_lv].strip() if ci_lv >= 0 and len(r) > ci_lv else '',
    }
print('  有效关卡 %d' % len(inst))

# ---------- activity ----------
f_a, l_a, _, rows_a = load('activity')
print('activity: %d 行, %d 列' % (len(rows_a), len(f_a)))
ca_id   = col(f_a, 'ID')
ca_name = col(f_a, 'name')
ca_ttl  = col(f_a, 'title')
ca_type = col(f_a, 'type')
ca_desc = col(f_a, 'desc')
acts = []
for r in rows_a:
    if len(r) <= max(ca_id, ca_name) or not r[ca_id].strip(): continue
    acts.append({
        'id': r[ca_id].strip(),
        'name': r[ca_name].strip() if ca_name >= 0 and len(r) > ca_name else '',
        'title': r[ca_ttl].strip() if ca_ttl >= 0 and len(r) > ca_ttl else '',
        'type': r[ca_type].strip() if ca_type >= 0 and len(r) > ca_type else '',
        'desc': r[ca_desc].strip() if ca_desc >= 0 and len(r) > ca_desc else '',
    })
print('  活动 %d 条' % len(acts))

# ---------- 剧情文件 ----------
files = sorted(f for f in os.listdir(STORY) if f.endswith('.txt'))
def chinfo(f):
    n = int(re.match(r'sentence_(\d+)', f).group(1))
    if n < 10000: return ('序章', 0, n)
    k = n // 10000
    if k == 1: return ('第一章', 1, n)
    if k == 2: return ('第二章', 2, n)
    if k == 3: return ('活动剧情' if n >= 31000 else '第三章', 3, n)
    if k == 4: return ('支线', 4, n)
    return ('其它', 9, n)

eps = []
for f in files:
    c = io.open(os.path.join(STORY, f), encoding='utf-8').read()
    lines = [l for l in c.split('\n') if l.strip()]
    n = len(lines)
    zh = 0
    for l in lines:
        p = l.split('\t')
        if len(p) >= 3 and p[2].strip(): zh += 1
    name, ck, num = chinfo(f)
    eps.append({'file': f[:-4], 'num': num, 'chapter': name, 'ck': ck,
                'lines': n, 'zh': zh, 'chars': len(c)})

print('  剧情 %d 个' % len(eps))

# ---------- 组装时间线（按章节 + 编号） ----------
eps.sort(key=lambda x: (x['ck'], x['num']))

# 统计
from collections import Counter, OrderedDict
bychap = OrderedDict()
for e in eps:
    bychap.setdefault(e['chapter'], []).append(e)

print()
print('=== 章节分布 ===')
for k, v in bychap.items():
    print('  %-8s %3d 个  %6d 行  %8d 字符' % (k, len(v), sum(x['lines'] for x in v), sum(x['chars'] for x in v)))

# 活动名映射（用 instance 的 activity 字段）
act_by_id = {a['id']: a for a in acts}

# ---------- HTML ----------
def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')

CHAP_COLOR = {'序章':'#8f96a3','第一章':'#c9a227','第二章':'#7fb3d5','第三章':'#d98cb3',
              '活动剧情':'#8fc9a0','支线':'#c9a27f','其它':'#6b7484'}

blocks = []
for chap, items in bychap.items():
    color = CHAP_COLOR.get(chap, '#8f96a3')
    blocks.append('<section><h2 style="border-left:4px solid %s;padding-left:12px">%s</h2>'
                  '<div class="cnt">%d 个剧情 · %d 行 · %s 字符</div>'
                  % (color, esc(chap), len(items),
                     sum(x['lines'] for x in items),
                     '{:,}'.format(sum(x['chars'] for x in items))))
    blocks.append('<div class="tl">')
    for e in items:
        blocks.append(
            '<div class="item" style="--c:%s">'
            '<div class="dot"></div>'
            '<div class="card">'
            '<div class="hd"><span class="num">%s</span>'
            '<span class="lines">%d 行</span></div>'
            '<div class="nm">%s</div>'
            '</div></div>' % (color, esc(e['file'].replace('sentence_', '')), e['lines'], esc(e['file'])))
    blocks.append('</div></section>')

# 活动表
act_rows = []
for a in acts[:400]:
    if not a['name'] and not a['title']:
        continue
    act_rows.append('<tr><td class="idx">%s</td><td>%s</td><td>%s</td><td>%s</td></tr>'
                    % (esc(a['id']), esc(a['name']), esc(a['title']), esc(a['desc'])[:120]))

html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》剧情时间线</title>
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
main{padding:32px 48px 80px;max-width:1400px}
section{margin-bottom:46px}
section>h2{font-size:22px;color:var(--fg);margin:0 0 4px;font-weight:600}
.cnt{font-size:12px;color:var(--dim);margin-bottom:20px;font-family:ui-monospace,monospace}
.tl{display:grid;grid-template-columns:repeat(auto-fill,minmax(210px,1fr));gap:10px}
.item{position:relative}
.card{background:var(--panel);border:1px solid var(--line);border-left:3px solid var(--c);
border-radius:5px;padding:9px 12px;transition:transform .2s,border-color .2s}
.card:hover{transform:translateX(3px);border-color:var(--c)}
.hd{display:flex;justify-content:space-between;gap:8px;margin-bottom:3px}
.num{font-size:12px;color:var(--c);font-family:ui-monospace,monospace;font-weight:600}
.lines{font-size:10.5px;color:#5f6674;font-family:ui-monospace,monospace}
.nm{font-size:11px;color:#8d94a2;font-family:ui-monospace,monospace;
overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.acts{margin-top:14px}
table{border-collapse:collapse;width:100%;font-size:12.5px}
th,td{padding:6px 10px;border-bottom:1px solid var(--line);text-align:left;vertical-align:top}
th{background:#1c2029;color:#7fb3d5;font-family:ui-monospace,monospace;font-size:11.5px;
position:sticky;top:0}
td.idx{color:#5f6674;font-family:ui-monospace,monospace;white-space:nowrap}
tbody tr:hover{background:#1a1e27}
.scroll{max-height:520px;overflow:auto;border:1px solid var(--line);border-radius:6px}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}.tl{grid-template-columns:1fr}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / STORY TIMELINE</div>
<h1>《魔女兵器》剧情时间线</h1>
<div class="en">STORY TIMELINE · __NEPS__ EPISODES</div>
<div class="meta">
<b>剧情</b>：__NEPS__ 个文本 · __NLINES__ 行 · __NCHARS__ 字符（解密自客户端）<br>
<b>关卡</b>：__NINST__ 条（<code>instance.csv</code>）· <b>活动</b>：__NACT__ 条（<code>activity.csv</code>）<br>
<b>排序</b>：按章节 + 剧情编号
</div></header>
<main>
__BODY__
<section>
<h2 style="border-left:4px solid #7fb3d5;padding-left:12px">活动一览</h2>
<div class="cnt">activity.csv · 显示前 400 条</div>
<div class="scroll"><table>
<thead><tr><th>ID</th><th>活动名称</th><th>活动标题</th><th>描述</th></tr></thead>
<tbody>__ACTS__</tbody>
</table></div>
</section>
</main>
<footer>
<b>《魔女兵器》剧情时间线</b><br>
数据源：解密剧情 + 配置表（XOR 0xFF）· 游戏开发：北京水琴铃（WaterBell）<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer></body></html>'''

html = (html.replace('__BODY__', '\n'.join(blocks))
            .replace('__ACTS__', '\n'.join(act_rows))
            .replace('__NEPS__', str(len(eps)))
            .replace('__NLINES__', '{:,}'.format(sum(x['lines'] for x in eps)))
            .replace('__NCHARS__', '{:,}'.format(sum(x['chars'] for x in eps)))
            .replace('__NINST__', '{:,}'.format(len(inst)))
            .replace('__NACT__', '{:,}'.format(len(acts))))
io.open(OUT, 'w', encoding='utf-8').write(html)
print()
print('已生成: %s (%.2f MB)' % (OUT, os.path.getsize(OUT) / 1024 / 1024))
