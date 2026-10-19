# 剧情人物共现分析与关系图
import io, os, sys, re, json, math
from collections import Counter, defaultdict

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R   = r'G:\project\其他\game'
D   = os.path.join(R, '剧情文本_解密版', '国服v2.0.1')
CFG = os.path.join(R, '配置表_解密版', '怀旧服v128')
OUT = os.path.join(R, '魔女兵器_人物关系图.html')
os.makedirs(R, exist_ok=True)

# ---------- 1) 角色名表（用于识别）----------
names = {}
for l in io.open(os.path.join(CFG, 'dictionary.csv'), encoding='utf-8', errors='replace'):
    r = l.rstrip('\n').split('\t')
    if len(r) >= 6 and r[0].strip():
        names[r[0].strip()] = {'zh': r[1].strip(), 'jp': r[3].strip(), 'en': r[5].strip()}
ZH = set(v['zh'] for v in names.values() if v['zh'])

# ---------- 2) 逐文件扫描说话人 ----------
def parse(f):
    """返回 [(行号, 说话人, 中文)]"""
    out = []
    c = io.open(os.path.join(D, f), encoding='utf-8').read()
    for ln in c.split('\n'):
        p = ln.split('\t')
        if len(p) >= 3:
            out.append((p[0].strip(), p[1].strip(), p[2].strip()))
    return out

files = sorted(f for f in os.listdir(D) if f.endswith('.txt'))
print('剧情文件 %d' % len(files))

# 归一化说话人：去掉 N/A@ 前缀
def norm(s):
    s = s.strip()
    s = re.sub(r'^N/A@', '', s)
    s = re.sub(r'^Record', '', s)
    return s.strip()

# 统计
speak = Counter()
per_file = defaultdict(Counter)   # 文件 -> 说话人计数
cooc = Counter()                  # 共现对
for f in files:
    lines = parse(f)
    local = Counter()
    for idx, spk, zh in lines:
        s = norm(spk)
        if not s or s in ('N/A', 'A_speak', 'B_speak', 'T_showPicText', 'FocusTrigger', '#C'):
            continue
        if len(s) > 20 or s.startswith('['):
            continue
        speak[s] += 1
        local[s] += 1
    for s, n in local.items():
        per_file[f][s] = n
    # 同文件共现（按文件计，权重 = min(次数)）
    ks = [k for k in local if local[k] >= 2]
    for i in range(len(ks)):
        for j in range(i + 1, len(ks)):
            a, b = sorted([ks[i], ks[j]])
            cooc[(a, b)] += min(local[ks[i]], local[ks[j]])

print('说话人 %d 种' % len(speak))
print('共现对 %d 组' % len(cooc))

# ---------- 3) 取前 N 名主要角色 ----------
TOP = 40
main = [s for s, _ in speak.most_common(TOP)]
print()
print('=== 主要角色（前 %d）===' % TOP)
for i, s in enumerate(main, 1):
    print('  %2d. %-14s %5d 句' % (i, s, speak[s]))

# ---------- 4) 关系强度 ----------
edges = []
for (a, b), w in cooc.items():
    if a in main and b in main and w >= 3:
        edges.append({'a': a, 'b': b, 'w': w})
edges.sort(key=lambda x: -x['w'])
print()
print('=== 最强关系（前 25）===')
for e in edges[:25]:
    print('  %-12s <-> %-12s  %5d' % (e['a'], e['b'], e['w']))

# ---------- 5) 出场章节 ----------
def chapter_of(f):
    m = re.match(r'sentence_(\d+)\.txt$', f)
    if not m: return '其它'
    n = int(m.group(1))
    if n < 10000: return '序章'
    k = n // 10000
    if k == 1: return '第一章'
    if k == 2: return '第二章'
    if k == 3: return '活动' if n >= 31000 else '第三章'
    if k == 4: return '支线'
    return '其它'

chap_of_char = defaultdict(Counter)
for f, cnt in per_file.items():
    ch = chapter_of(f)
    for s, n in cnt.items():
        chap_of_char[s][ch] += n

# ---------- 6) 生成 HTML ----------
def esc(s):
    return (s or '').replace('&', '&amp;').replace('<', '&lt;').replace('>', '&gt;').replace('"', '&quot;')

maxw = max((e['w'] for e in edges), default=1)
nodes = []
for i, s in enumerate(main):
    zh = s if s in ZH else ''
    nodes.append({'id': s, 'n': speak[s], 'zh': zh,
                  'ch': dict(chap_of_char[s].most_common(6))})

payload = json.dumps({'nodes': nodes, 'edges': edges[:400],
                       'maxw': maxw, 'total': len(speak)}, ensure_ascii=False,
                      separators=(',', ':'))

html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》人物关系图</title>
<style>
:root{--bg:#0f1116;--panel:#171a21;--line:#2a2f3a;--fg:#e6e3de;--dim:#8f96a3;
--accent:#c9a227;--accent2:#7fb3d5}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);line-height:1.7;
font-family:"Noto Sans SC","Microsoft YaHei",sans-serif;overflow:hidden}
header{padding:20px 28px 14px;border-bottom:1px solid var(--line);
background:linear-gradient(160deg,#1a1d26,#0f1116 70%)}
.eyebrow{font-size:10.5px;letter-spacing:.34em;color:var(--accent);margin-bottom:8px;
font-family:ui-monospace,monospace}
h1{font-size:24px;margin:0 0 4px;letter-spacing:.06em;font-weight:600}
.meta{font-size:11.5px;color:var(--dim);font-family:ui-monospace,monospace}
.meta b{color:var(--fg)}
.bar{display:flex;gap:14px;align-items:center;padding:9px 28px;border-bottom:1px solid var(--line);
background:var(--panel);font-size:11.5px;flex-wrap:wrap}
.bar label{color:var(--dim);font-family:ui-monospace,monospace}
.bar input[type=range]{width:130px;vertical-align:middle}
.bar button{padding:4px 10px;background:#1e222b;border:1px solid var(--line);border-radius:4px;
color:#c3c8d1;cursor:pointer;font-size:11.5px}
.bar button:hover{border-color:var(--accent);color:var(--fg)}
.bar .v{color:var(--accent2);font-family:ui-monospace,monospace;min-width:34px;display:inline-block}
#cv{display:block;width:100vw;height:calc(100vh - 168px);cursor:grab}
#cv:active{cursor:grabbing}
#tip{position:fixed;pointer-events:none;background:#1c2029;border:1px solid var(--accent);
border-radius:5px;padding:8px 11px;font-size:12px;display:none;z-index:9;max-width:280px;
box-shadow:0 4px 20px rgba(0,0,0,.6)}
#tip b{color:var(--accent);font-size:13px}
#tip .r{color:var(--dim);font-family:ui-monospace,monospace;font-size:11px;margin-top:3px}
footer{padding:8px 28px;border-top:1px solid var(--line);color:var(--dim);font-size:10.5px;
font-family:ui-monospace,monospace}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / CHARACTER NETWORK</div>
<h1>《魔女兵器》人物关系图</h1>
<div class="meta">说话人 <b>__TOTAL__</b> 种 · 主要角色 <b>__NODES__</b> 名 · 关系 <b>__EDGES__</b> 条 · 数据源：解密剧情 16,687 行</div>
</header>
<div class="bar">
  <label>关系强度阈值</label>
  <input type="range" id="thr" min="1" max="__MAXW__" value="__DEFTHR__">
  <span class="v" id="thrv">__DEFTHR__</span>
  <label>节点大小</label>
  <button onclick="setSize('line')">按台词数</button>
  <button onclick="setSize('even')">统一</button>
  <button onclick="reset()">重置视图</button>
  <span style="color:#5f6674">拖拽移动 · 滚轮缩放 · 悬停查看</span>
</div>
<canvas id="cv"></canvas>
<div id="tip"></div>
<footer>配置表解密：XOR 0xFF · 游戏开发：北京水琴铃（WaterBell）· 国服已于 2024-08-17 停服</footer>
<script>
const D = __DATA__;
const cv = document.getElementById('cv'), ctx = cv.getContext('2d');
const tip = document.getElementById('tip');
let W=0, H=0, scale=1, ox=0, oy=0, sizeMode='line', thr=__DEFTHR__;

function resize(){
  const r = cv.getBoundingClientRect();
  W = cv.width = r.width * devicePixelRatio;
  H = cv.height = r.height * devicePixelRatio;
  cv.style.width = r.width+'px'; cv.style.height = r.height+'px';
  draw();
}
window.addEventListener('resize', resize);

// 布局：力导向（简化版）
const N = D.nodes.map((n, i) => ({
  ...n, i,
  x: Math.cos(i / D.nodes.length * Math.PI * 2) * 300 + (Math.random()-.5)*60,
  y: Math.sin(i / D.nodes.length * Math.PI * 2) * 300 + (Math.random()-.5)*60,
  vx: 0, vy: 0,
  r: 0
}));
const idx = {}; N.forEach(n => idx[n.id] = n);

function radius(n){
  if (sizeMode === 'even') return 9;
  const mx = Math.max(...N.map(x => x.n));
  return 5 + Math.sqrt(n.n / mx) * 22;
}
function layout(){
  const E = D.edges.filter(e => e.w >= thr);
  for (let it = 0; it < 320; it++){
    // 斥力
    for (let i = 0; i < N.length; i++){
      for (let j = i+1; j < N.length; j++){
        const a = N[i], b = N[j];
        let dx = b.x-a.x, dy = b.y-a.y;
        let d2 = dx*dx + dy*dy || 1;
        if (d2 > 160000) continue;
        const f = 2600 / d2;
        const d = Math.sqrt(d2);
        dx /= d; dy /= d;
        a.vx -= dx*f; a.vy -= dy*f;
        b.vx += dx*f; b.vy += dy*f;
      }
    }
    // 引力
    E.forEach(e => {
      const a = idx[e.a], b = idx[e.b];
      if (!a || !b) return;
      let dx = b.x-a.x, dy = b.y-a.y;
      const d = Math.sqrt(dx*dx + dy*dy) || 1;
      const f = (d - 90) * 0.0022 * Math.min(3, Math.log(1+e.w));
      dx /= d; dy /= d;
      a.vx += dx*f; a.vy += dy*f;
      b.vx -= dx*f; b.vy -= dy*f;
    });
    // 向心
    N.forEach(n => {
      n.vx -= n.x * 0.0016; n.vy -= n.y * 0.0016;
      n.vx *= 0.82; n.vy *= 0.82;
      n.x += n.vx; n.y += n.vy;
    });
  }
  N.forEach(n => n.r = radius(n));
}

function draw(){
  const E = D.edges.filter(e => e.w >= thr);
  ctx.setTransform(1,0,0,1,0,0);
  ctx.clearRect(0,0,W,H);
  ctx.save();
  ctx.translate(W/2 + ox*devicePixelRatio, H/2 + oy*devicePixelRatio);
  ctx.scale(scale*devicePixelRatio, scale*devicePixelRatio);

  // 边
  const mx = D.maxw;
  E.forEach(e => {
    const a = idx[e.a], b = idx[e.b];
    if (!a || !b) return;
    const t = Math.min(1, e.w / (mx * 0.5));
    ctx.strokeStyle = 'rgba(127,179,213,' + (0.10 + t*0.55) + ')';
    ctx.lineWidth = 0.5 + t*4.5;
    ctx.beginPath(); ctx.moveTo(a.x,a.y); ctx.lineTo(b.x,b.y); ctx.stroke();
  });
  // 节点
  N.forEach(n => {
    const g = ctx.createRadialGradient(n.x,n.y,0,n.x,n.y,n.r*1.8);
    g.addColorStop(0,'#ffe9a8'); g.addColorStop(.55,'#c9a227'); g.addColorStop(1,'rgba(201,162,39,0)');
    ctx.fillStyle = g;
    ctx.beginPath(); ctx.arc(n.x,n.y,n.r*1.8,0,7); ctx.fill();
    ctx.fillStyle = '#e8d9a0';
    ctx.beginPath(); ctx.arc(n.x,n.y,n.r*0.55,0,7); ctx.fill();
    // 标签
    ctx.fillStyle = 'rgba(230,227,222,.92)';
    ctx.font = (11 + Math.min(5, n.n/900)) + 'px "Noto Sans SC",sans-serif';
    ctx.textAlign = 'center';
    ctx.fillText(n.id, n.x, n.y + n.r*1.8 + 13);
  });
  ctx.restore();
}

// 交互
let drag = false, lx = 0, ly = 0;
cv.addEventListener('mousedown', e => { drag = true; lx = e.clientX; ly = e.clientY; });
window.addEventListener('mouseup', () => drag = false);
cv.addEventListener('mousemove', e => {
  if (drag){ ox += e.clientX - lx; oy += e.clientY - ly; lx = e.clientX; ly = e.clientY; draw(); return; }
  const r = cv.getBoundingClientRect();
  const mx = (e.clientX - r.left - r.width/2 - ox) / scale;
  const my = (e.clientY - r.top - r.height/2 - oy) / scale;
  let hit = null;
  for (const n of N){
    if ((n.x-mx)**2 + (n.y-my)**2 < (n.r*1.6)**2){ hit = n; break; }
  }
  if (hit){
    const chs = Object.entries(hit.ch).map(([k,v]) => k+' '+v).join(' · ');
    tip.innerHTML = '<b>' + hit.id + '</b><div class="r">台词 ' + hit.n + ' 句</div>'
      + (chs ? '<div class="r">' + chs + '</div>' : '');
    tip.style.display = 'block';
    tip.style.left = (e.clientX + 14) + 'px';
    tip.style.top = (e.clientY + 14) + 'px';
  } else tip.style.display = 'none';
});
cv.addEventListener('wheel', e => {
  e.preventDefault();
  scale *= e.deltaY < 0 ? 1.12 : 0.89;
  scale = Math.max(0.2, Math.min(6, scale));
  draw();
}, {passive:false});

document.getElementById('thr').oninput = e => {
  thr = +e.target.value;
  document.getElementById('thrv').textContent = thr;
  draw();
};
function setSize(m){ sizeMode = m; N.forEach(n => n.r = radius(n)); draw(); }
function reset(){ scale = 1; ox = 0; oy = 0; layout(); draw(); }

layout();
resize();
</script></body></html>'''

# 默认阈值取能让图不太密的值
defthr = 8
html = (html.replace('__DATA__', payload)
            .replace('__TOTAL__', str(len(speak)))
            .replace('__NODES__', str(len(main)))
            .replace('__EDGES__', str(len(edges)))
            .replace('__MAXW__', str(maxw))
            .replace('__DEFTHR__', str(defthr)))
io.open(OUT, 'w', encoding='utf-8').write(html)
print()
print('已生成: %s (%.2f MB)' % (OUT, os.path.getsize(OUT) / 1024 / 1024))
