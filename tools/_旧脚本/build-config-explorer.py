# 生成配置表 HTML 查询器（95 张表，可搜索浏览）
import io, os, sys, re, csv, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R   = r'G:\project\其他\game'
CFG = os.path.join(R, '配置表_解密版', '怀旧服v128')
OUT = os.path.join(R, '魔女兵器_配置表查询器.html')

def read_any(name):
    """配置表可能是逗号或制表符分隔"""
    p = os.path.join(CFG, name)
    raw = io.open(p, encoding='utf-8', errors='replace').read()
    # 判断分隔符：前 3 行里哪个出现得多
    head = '\n'.join(raw.split('\n')[:3])
    sep = '\t' if head.count('\t') > head.count(',') else ','
    rows = list(csv.reader(io.StringIO(raw), delimiter=sep))
    return rows, sep

files = sorted(f for f in os.listdir(CFG) if f.endswith('.csv'))
print('配置表 %d 张' % len(files))

tables = []
for f in files:
    name = f[:-4]
    try:
        rows, sep = read_any(f)
    except Exception as e:
        print('  跳过 %s: %s' % (name, e)); continue
    rows = [r for r in rows if any(x.strip() for x in r)]
    if len(rows) < 3:
        continue
    fields = [x.strip() for x in rows[0]]
    types  = [x.strip() for x in rows[1]]
    labels = [x.strip() for x in rows[2]]
    data   = rows[3:] if len(rows) > 3 else []
    # 去掉尾部空列
    ncol = max((len(r) for r in rows[:3]), default=0)
    while ncol > 1 and not fields[ncol-1] and not labels[ncol-1]:
        ncol -= 1
    fields = fields[:ncol]; types = types[:ncol]; labels = labels[:ncol]
    data = [r[:ncol] + [''] * (ncol - len(r)) for r in data]
    tables.append({
        'name': name, 'fields': fields, 'types': types, 'labels': labels,
        'rows': data, 'n': len(data),
    })

print('有效表 %d 张' % len(tables))
total_rows = sum(t['n'] for t in tables)
print('总数据行 %d' % total_rows)

# 表清单（按行数排序）
toc = sorted([(t['name'], t['n'], len(t['fields'])) for t in tables], key=lambda x: -x[1])

# 内嵌 JSON（压缩）
payload = json.dumps(
    [{'n': t['name'], 'f': t['fields'], 'l': t['labels'], 'd': t['rows']} for t in tables],
    ensure_ascii=False, separators=(',', ':')
)

html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》配置表查询器</title>
<style>
:root{--bg:#0f1116;--panel:#171a21;--panel2:#1e222b;--line:#2a2f3a;
--fg:#e6e3de;--dim:#8f96a3;--accent:#c9a227;--accent2:#7fb3d5;--hi:#3a4a2a}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);font-size:14px;
font-family:"Noto Sans SC","Microsoft YaHei",sans-serif;line-height:1.6}
.wrap{display:flex;min-height:100vh}
aside{width:280px;flex:0 0 280px;background:var(--panel);border-right:1px solid var(--line);
position:sticky;top:0;height:100vh;overflow-y:auto;padding:16px 0}
aside h1{font-size:15px;margin:0 16px 4px;color:var(--accent);letter-spacing:.1em;font-weight:600}
aside .sub{font-size:10.5px;color:var(--dim);margin:0 16px 12px;font-family:ui-monospace,monospace}
aside input{width:calc(100% - 32px);margin:0 16px 12px;padding:7px 10px;background:var(--panel2);
border:1px solid var(--line);border-radius:4px;color:var(--fg);font-size:12px;outline:none}
aside input:focus{border-color:var(--accent)}
.titem{display:flex;justify-content:space-between;gap:8px;padding:6px 16px;cursor:pointer;
font-size:12.5px;color:#b9bfc9;font-family:ui-monospace,monospace;border-left:2px solid transparent}
.titem:hover{background:var(--panel2);color:var(--fg)}
.titem.on{background:var(--panel2);color:var(--accent);border-left-color:var(--accent)}
.titem .c{color:#5f6674;font-size:11px}
main{flex:1;min-width:0;display:flex;flex-direction:column}
header{padding:20px 28px 14px;border-bottom:1px solid var(--line)}
header h2{margin:0 0 3px;font-size:19px;color:var(--accent);letter-spacing:.04em;font-weight:600}
header .info{font-size:11.5px;color:var(--dim);font-family:ui-monospace,monospace}
.tools{display:flex;gap:10px;align-items:center;padding:12px 28px;border-bottom:1px solid var(--line);
background:var(--panel);position:sticky;top:0;z-index:5;flex-wrap:wrap}
.tools input[type=text]{flex:1;min-width:180px;padding:7px 11px;background:var(--panel2);
border:1px solid var(--line);border-radius:4px;color:var(--fg);font-size:13px;outline:none}
.tools input[type=text]:focus{border-color:var(--accent)}
.tools button{padding:6px 12px;background:var(--panel2);border:1px solid var(--line);
border-radius:4px;color:#c3c8d1;cursor:pointer;font-size:12px}
.tools button:hover{border-color:var(--accent);color:var(--fg)}
.tools .stat{font-size:11.5px;color:var(--dim);font-family:ui-monospace,monospace}
.tablewrap{flex:1;overflow:auto;padding:0 28px 60px}
table{border-collapse:collapse;width:100%;font-size:12.5px}
th,td{padding:6px 10px;border-bottom:1px solid var(--line);text-align:left;
vertical-align:top;white-space:pre-wrap;word-break:break-word;max-width:420px}
thead th{position:sticky;top:0;background:#1c2029;color:var(--accent2);z-index:2;
font-family:ui-monospace,monospace;font-size:11.5px;font-weight:600;white-space:nowrap}
thead tr.lbl th{top:30px;color:var(--dim);font-weight:400;background:#191d25}
tbody tr:hover{background:#1a1e27}
td.idx{color:#5f6674;font-family:ui-monospace,monospace;white-space:nowrap}
mark{background:var(--hi);color:#e8e6a0;border-radius:2px;padding:0 1px}
.empty{padding:60px 28px;color:var(--dim);text-align:center}
footer{padding:20px 28px;border-top:1px solid var(--line);color:var(--dim);font-size:11.5px}
@media(max-width:800px){aside{display:none}.tablewrap,header,.tools,footer{padding-left:14px;padding-right:14px}}
</style></head><body>
<div class="wrap">
<aside>
<h1>魔女兵器</h1>
<p class="sub">CONFIG TABLES · __NT__</p>
<input id="tfilter" placeholder="筛选表名...">
<div id="toc"></div>
</aside>
<main>
<header>
<h2 id="tname">选择左侧配置表</h2>
<div class="info" id="tinfo">共 __NT__ 张表 · __NROWS__ 行数据</div>
</header>
<div class="tools">
<input type="text" id="q" placeholder="全表搜索（支持多关键词，空格分隔）...">
<button onclick="clearQ()">清除</button>
<span class="stat" id="stat"></span>
</div>
<div class="tablewrap" id="tw"><div class="empty">← 从左侧选择一张配置表</div></div>
<footer>
配置表解密：XOR 0xFF · 来源：客户端 <code>clientexel/*.ab</code><br>
游戏开发：北京水琴铃（WaterBell）· 国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer>
</main></div>
<script>
const DATA = __DATA__;
let cur = null, q = '';

// 目录
const toc = document.getElementById('toc');
function renderToc(filter){
  toc.innerHTML = '';
  DATA.forEach((t, i) => {
    if (filter && !t.n.toLowerCase().includes(filter)) return;
    const d = document.createElement('div');
    d.className = 'titem' + (cur === i ? ' on' : '');
    d.innerHTML = '<span>' + t.n + '</span><span class="c">' + t.d.length + '</span>';
    d.onclick = () => select(i);
    toc.appendChild(d);
  });
}
document.getElementById('tfilter').oninput = e => renderToc(e.target.value.toLowerCase());

function esc(s){ return (s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;'); }
function hl(s, kws){
  let out = esc(s);
  kws.forEach(k => {
    if (!k) return;
    out = out.replace(new RegExp('(' + k.replace(/[.*+?^${}()|[\\]\\\\]/g,'\\\\$&') + ')', 'gi'), '<mark>$1</mark>');
  });
  return out;
}

function select(i){
  cur = i; q = ''; document.getElementById('q').value = '';
  renderToc(document.getElementById('tfilter').value.toLowerCase());
  const t = DATA[i];
  document.getElementById('tname').textContent = t.n;
  document.getElementById('tinfo').textContent =
    t.f.length + ' 列 · ' + t.d.length + ' 行';
  render();
}

function render(){
  if (cur === null) return;
  const t = DATA[cur];
  const kws = q.trim() ? q.trim().split(/\\s+/).filter(Boolean) : [];
  let rows = t.d;
  if (kws.length){
    rows = rows.filter(r => {
      const s = r.join('\\u0001').toLowerCase();
      return kws.every(k => s.includes(k.toLowerCase()));
    });
  }
  document.getElementById('stat').textContent =
    kws.length ? ('匹配 ' + rows.length + ' / ' + t.d.length + ' 行') : (t.d.length + ' 行');

  const max = 300;
  let h = '<table><thead><tr><th></th>';
  t.f.forEach((f, j) => { h += '<th>' + esc(f) + '</th>'; });
  h += '</tr><tr class="lbl"><th></th>';
  t.l.forEach((l, j) => { h += '<th>' + esc(l || t.f[j]) + '</th>'; });
  h += '</tr></thead><tbody>';
  rows.slice(0, max).forEach((r, ri) => {
    h += '<tr><td class="idx">' + (ri+1) + '</td>';
    r.forEach(c => { h += '<td>' + hl(c, kws) + '</td>'; });
    h += '</tr>';
  });
  h += '</tbody></table>';
  if (rows.length > max) h += '<div class="empty">仅显示前 ' + max + ' 行（共 ' + rows.length + ' 行），请用搜索缩小范围</div>';
  if (!rows.length) h = '<div class="empty">无匹配结果</div>';
  document.getElementById('tw').innerHTML = h;
}

let timer = null;
document.getElementById('q').oninput = e => {
  clearTimeout(timer);
  timer = setTimeout(() => { q = e.target.value; render(); }, 180);
};
function clearQ(){ document.getElementById('q').value=''; q=''; render(); }

renderToc('');
if (DATA.length) select(0);
</script></body></html>'''

html = (html.replace('__DATA__', payload)
            .replace('__NT__', str(len(tables)))
            .replace('__NROWS__', '{:,}'.format(total_rows)))
io.open(OUT, 'w', encoding='utf-8').write(html)
print('已生成: %s (%.2f MB)' % (OUT, os.path.getsize(OUT) / 1024 / 1024))
