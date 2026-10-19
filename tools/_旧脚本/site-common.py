# 构建《魔女兵器》收藏网站（多页，引用全部素材）
import io, os, sys, json, re, csv, shutil
from collections import defaultdict, OrderedDict, Counter

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
SITE = os.path.join(R, '网站')
os.makedirs(SITE, exist_ok=True)
for sub in ['assets', 'css', 'js']:
    os.makedirs(os.path.join(SITE, sub), exist_ok=True)

ASSETS = json.load(io.open(os.path.join(R, 'tools', '_asset_index.json'), encoding='utf-8'))
print('资产索引 %d 条' % len(ASSETS))

def rel(p):
    """从网站目录到仓库根的相对路径"""
    return '../' + p.replace('\\', '/')

def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')

# ================= 公共 CSS =================
CSS = '''/* 《魔女兵器》收藏网站 */
:root{
  --bg:#0d0f14; --bg2:#12151c; --panel:#171a21; --panel2:#1e222b;
  --line:#2a2f3a; --line2:#353b48;
  --fg:#e8e5e0; --fg2:#c3c8d1; --dim:#8f96a3; --dim2:#6b7484;
  --gold:#c9a227; --gold2:#e0c86a; --blue:#7fb3d5; --pink:#d98cb3; --green:#8fc9a0;
  --mono:ui-monospace,"SF Mono",Consolas,monospace;
  --serif:"Noto Serif SC","Source Han Serif SC","Songti SC",serif;
  --sans:"Noto Sans SC","Microsoft YaHei",system-ui,sans-serif;
}
*{box-sizing:border-box}
html{scroll-behavior:smooth}
body{margin:0;background:var(--bg);color:var(--fg);line-height:1.75;
  font-family:var(--sans);-webkit-font-smoothing:antialiased}

/* 顶栏 */
.nav{position:sticky;top:0;z-index:50;background:rgba(13,15,20,.94);
  backdrop-filter:blur(12px);border-bottom:1px solid var(--line)}
.nav-in{max-width:1500px;margin:0 auto;padding:0 32px;display:flex;align-items:center;
  gap:6px;height:56px;overflow-x:auto}
.nav .brand{font-size:14px;font-weight:600;color:var(--gold);letter-spacing:.1em;
  margin-right:20px;white-space:nowrap;font-family:var(--mono)}
.nav a{color:var(--dim);text-decoration:none;font-size:13px;padding:6px 11px;
  border-radius:5px;white-space:nowrap;transition:.18s}
.nav a:hover{color:var(--fg);background:var(--panel2)}
.nav a.on{color:var(--gold);background:var(--panel2)}

/* 页头 */
.hero{padding:64px 32px 44px;border-bottom:1px solid var(--line);
  background:linear-gradient(165deg,#1a1d26 0%,#0d0f14 65%)}
.hero-in{max-width:1500px;margin:0 auto}
.eyebrow{font-size:11px;letter-spacing:.36em;color:var(--gold);margin-bottom:14px;
  font-family:var(--mono);text-transform:uppercase}
h1{font-size:42px;margin:0 0 10px;letter-spacing:.06em;font-weight:600;line-height:1.25}
.hero .en{font-size:11.5px;letter-spacing:.3em;color:var(--dim);margin-bottom:22px;
  font-family:var(--mono)}
.hero .meta{font-size:13.5px;color:var(--dim);line-height:2.1;max-width:900px}
.hero .meta b{color:var(--fg)}
.hero .meta code{background:var(--panel2);padding:1px 6px;border-radius:3px;
  font-family:var(--mono);font-size:12px;color:var(--blue)}

/* 主体 */
main{max-width:1500px;margin:0 auto;padding:40px 32px 100px}
section{margin-bottom:56px}
h2{font-size:24px;color:var(--gold);margin:0 0 6px;font-weight:600;letter-spacing:.04em}
h2.bar{border-left:4px solid var(--gold);padding-left:14px}
h3{font-size:17px;color:var(--fg);margin:26px 0 10px;font-weight:600}
.cnt{font-size:12px;color:var(--dim);margin-bottom:22px;font-family:var(--mono)}
p{color:var(--fg2);margin:0 0 14px}
a{color:var(--blue)}

/* 卡片网格 */
.grid{display:grid;gap:16px}
.g2{grid-template-columns:repeat(auto-fill,minmax(340px,1fr))}
.g3{grid-template-columns:repeat(auto-fill,minmax(250px,1fr))}
.g4{grid-template-columns:repeat(auto-fill,minmax(185px,1fr))}

.card{background:var(--panel);border:1px solid var(--line);border-radius:8px;
  overflow:hidden;transition:.22s;text-decoration:none;color:inherit;display:block}
.card:hover{border-color:var(--line2);transform:translateY(-2px);
  box-shadow:0 8px 28px rgba(0,0,0,.45)}
.card .thumb{background:#0a0c10;overflow:hidden;position:relative}
.card .thumb img{width:100%;display:block;transition:transform .45s}
.card:hover .thumb img{transform:scale(1.06)}
.card .body{padding:13px 15px 15px}
.card .ttl{font-size:15px;color:var(--fg);font-weight:600;margin-bottom:3px}
.card .sub{font-size:11.5px;color:var(--dim);font-family:var(--mono)}

/* KPI */
.kpis{display:grid;grid-template-columns:repeat(auto-fill,minmax(160px,1fr));gap:12px}
.kpi{background:var(--panel);border:1px solid var(--line);border-radius:8px;padding:16px 18px}
.kpi .v{font-size:28px;color:var(--gold);font-family:var(--mono);font-weight:600;line-height:1.15}
.kpi .k{font-size:11.5px;color:var(--dim);font-family:var(--mono);margin-top:2px}

/* 表格 */
table{border-collapse:collapse;width:100%;font-size:13px}
th,td{padding:7px 11px;border-bottom:1px solid var(--line);text-align:left;vertical-align:top}
th{background:#1c2029;color:var(--blue);font-family:var(--mono);font-size:11.5px;
  position:sticky;top:0;z-index:2}
tbody tr:hover{background:#1a1e27}
td.mono{font-family:var(--mono);color:var(--fg2)}
td.dim{color:var(--dim2);font-family:var(--mono);font-size:11.5px}
td.idx{color:var(--dim2);font-family:var(--mono);white-space:nowrap}
.scroll{max-height:600px;overflow:auto;border:1px solid var(--line);border-radius:8px}

/* 音频/视频 */
audio{width:100%;height:32px}
video{width:100%;display:block;background:#000}
.track{background:var(--panel);border:1px solid var(--line);border-radius:7px;
  padding:11px 13px;display:flex;flex-direction:column;gap:7px}
.track .nm{font-size:12.5px;color:var(--fg2);font-family:var(--mono);
  overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.track .sz{font-size:10.5px;color:var(--dim2);font-family:var(--mono)}

/* 提示条 */
.note{background:var(--panel);border-left:3px solid var(--gold);border-radius:6px;
  padding:13px 17px;font-size:13.5px;color:var(--fg2);margin-bottom:22px}
.note b{color:var(--fg)}

/* 搜索栏 */
.tools{display:flex;gap:11px;align-items:center;padding:12px 32px;
  border-bottom:1px solid var(--line);background:var(--panel);position:sticky;top:56px;z-index:40;
  flex-wrap:wrap}
.tools-in{max-width:1500px;margin:0 auto;width:100%;display:flex;gap:11px;align-items:center;flex-wrap:wrap}
.tools input{flex:1;min-width:200px;padding:8px 13px;background:var(--panel2);
  border:1px solid var(--line);border-radius:5px;color:var(--fg);font-size:13px;outline:none}
.tools input:focus{border-color:var(--gold)}
.tools button{padding:7px 13px;background:var(--panel2);border:1px solid var(--line);
  border-radius:5px;color:var(--fg2);cursor:pointer;font-size:12px}
.tools button:hover{border-color:var(--gold);color:var(--fg)}
.tools .stat{font-size:11.5px;color:var(--dim);font-family:var(--mono);white-space:nowrap}

/* 时间线 */
.tl{display:grid;grid-template-columns:repeat(auto-fill,minmax(215px,1fr));gap:10px}
.tl .it{background:var(--panel);border:1px solid var(--line);border-left:3px solid var(--c,var(--gold));
  border-radius:5px;padding:9px 12px;transition:.2s}
.tl .it:hover{transform:translateX(3px)}
.tl .no{font-size:12px;color:var(--c,var(--gold));font-family:var(--mono);font-weight:600}
.tl .ln{font-size:10.5px;color:var(--dim2);font-family:var(--mono)}

/* 标签 */
.chips{display:flex;flex-wrap:wrap;gap:7px}
.chip{background:var(--panel);border:1px solid var(--line);border-radius:4px;
  padding:4px 10px;font-size:12px;color:var(--fg2);font-family:var(--mono)}
.chip.hi{border-color:var(--pink);color:var(--pink)}
.chip.test{border-color:var(--gold);color:var(--gold2)}

/* 页脚 */
footer{border-top:1px solid var(--line);padding:40px 32px;color:var(--dim);font-size:12.5px;
  line-height:2}
.foot-in{max-width:1500px;margin:0 auto}
footer b{color:var(--fg)}

/* 折叠 */
details{background:var(--panel);border:1px solid var(--line);border-radius:6px;
  padding:10px 14px;margin-bottom:9px}
details summary{cursor:pointer;color:var(--fg2);font-size:13px;list-style:none;
  font-family:var(--mono)}
details summary::-webkit-details-marker{display:none}
details summary::before{content:"▸ ";color:var(--gold)}
details[open] summary::before{content:"▾ "}
details summary:hover{color:var(--fg)}
details .in{margin-top:9px;padding-left:12px;border-left:2px solid var(--line);
  font-size:13px;color:var(--fg2)}

/* 漫画 */
.strip{background:var(--panel);border:1px solid var(--line);border-radius:9px;
  padding:16px 18px 18px;margin-bottom:22px}
.strip .hd{display:flex;align-items:baseline;gap:12px;margin-bottom:6px;flex-wrap:wrap}
.strip .no{font-size:12px;color:var(--gold);font-family:var(--mono);font-weight:600}
.strip .zh{font-size:19px;color:var(--fg);font-weight:600}
.strip .jp{font-size:12px;color:var(--dim);font-family:var(--mono)}
.strip .dt{font-size:11px;color:var(--dim2);font-family:var(--mono);margin-left:auto}
.strip .note2{font-size:13px;color:#a8a196;margin-bottom:13px;padding-left:11px;
  border-left:2px solid var(--line)}
.panels{display:grid;grid-template-columns:repeat(auto-fit,minmax(210px,1fr));gap:9px}
.panels img{width:100%;border-radius:5px;background:#0b0d11;display:block}

mark{background:#3a4a2a;color:#e8e6a0;border-radius:2px;padding:0 1px}
.hide{display:none!important}

@media(max-width:760px){
  .nav-in,.hero,main,.tools,footer{padding-left:18px;padding-right:18px}
  h1{font-size:28px}
  .g2,.g3,.g4{grid-template-columns:1fr}
  .panels{grid-template-columns:repeat(2,1fr)}
}
'''
io.open(os.path.join(SITE, 'css', 'style.css'), 'w', encoding='utf-8').write(CSS)
print('CSS 已写')

# ================= 公共 JS =================
JS = '''// 通用：搜索过滤
function bindFilter(inputId, itemSel, statId, attr){
  const inp = document.getElementById(inputId);
  if (!inp) return;
  const items = [...document.querySelectorAll(itemSel)];
  let timer = null;
  const run = () => {
    const kws = inp.value.trim().toLowerCase().split(/\\s+/).filter(Boolean);
    let n = 0;
    items.forEach(el => {
      const t = (attr ? (el.getAttribute(attr) || '') : el.textContent).toLowerCase();
      const ok = kws.every(k => t.includes(k));
      el.classList.toggle('hide', !ok);
      if (ok) n++;
    });
    const st = document.getElementById(statId);
    if (st) st.textContent = kws.length ? ('匹配 ' + n + ' / ' + items.length) : (items.length + ' 项');
  };
  inp.addEventListener('input', () => { clearTimeout(timer); timer = setTimeout(run, 150); });
  run();
}

// 表格筛选
function bindTable(inputId, tableId, statId){
  const inp = document.getElementById(inputId);
  if (!inp) return;
  const tb = document.querySelector('#' + tableId + ' tbody');
  if (!tb) return;
  const rows = [...tb.rows];
  let timer = null;
  const run = () => {
    const kws = inp.value.trim().toLowerCase().split(/\\s+/).filter(Boolean);
    let n = 0;
    rows.forEach(r => {
      const t = r.textContent.toLowerCase();
      const ok = kws.every(k => t.includes(k));
      r.style.display = ok ? '' : 'none';
      if (ok) n++;
    });
    const st = document.getElementById(statId);
    if (st) st.textContent = kws.length ? ('匹配 ' + n + ' / ' + rows.length + ' 行') : (rows.length + ' 行');
  };
  inp.addEventListener('input', () => { clearTimeout(timer); timer = setTimeout(run, 150); });
  run();
}

// 图片灯箱
function initLightbox(){
  const lb = document.createElement('div');
  lb.id = 'lb';
  lb.style.cssText = 'position:fixed;inset:0;background:rgba(0,0,0,.93);display:none;'+
    'align-items:center;justify-content:center;z-index:999;cursor:zoom-out;padding:24px';
  lb.innerHTML = '<img style="max-width:100%;max-height:100%;object-fit:contain;border-radius:6px">';
  document.body.appendChild(lb);
  lb.onclick = () => lb.style.display = 'none';
  document.addEventListener('keydown', e => { if (e.key === 'Escape') lb.style.display = 'none'; });
  document.querySelectorAll('img.zoom').forEach(im => {
    im.style.cursor = 'zoom-in';
    im.onclick = () => { lb.querySelector('img').src = im.src; lb.style.display = 'flex'; };
  });
}
document.addEventListener('DOMContentLoaded', initLightbox);
'''
io.open(os.path.join(SITE, 'js', 'app.js'), 'w', encoding='utf-8').write(JS)
print('JS 已写')

# ================= 导航 =================
PAGES = [
    ('index.html',          '首页'),
    ('story.html',          '剧情'),
    ('characters.html',     '角色'),
    ('config.html',         '配置表'),
    ('audio.html',          '音频'),
    ('video.html',          '视频'),
    ('art.html',            '美术'),
    ('manga.html',          '四格漫画'),
    ('news.html',           '官网公告'),
    ('system.html',         '系统设计'),
    ('relics.html',         '开发遗迹'),
    ('archive.html',        '全部文件'),
]

def nav(cur):
    items = ''.join('<a href="%s"%s>%s</a>' % (h, ' class="on"' if h == cur else '', t)
                    for h, t in PAGES)
    return ('<nav class="nav"><div class="nav-in">'
            '<span class="brand">魔女兵器 / ARCHIVE</span>%s</div></nav>' % items)

def head(title, cur, extra=''):
    return ('<!DOCTYPE html>\n<html lang="zh-CN"><head><meta charset="UTF-8">\n'
            '<meta name="viewport" content="width=device-width, initial-scale=1">\n'
            '<title>%s · 魔女兵器收藏</title>\n'
            '<link rel="stylesheet" href="css/style.css">%s\n</head><body>\n%s\n'
            % (esc(title), extra, nav(cur)))

def foot():
    return ('''<footer><div class="foot-in">
<b>《魔女兵器》 Witch's Weapon 收藏档案</b><br>
游戏开发：北京水琴铃（WaterBell）· 日服发行：EXNOA LLC / SUIKINREI<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途，不作任何商业使用。<br>
配置表与剧情解密方式：<code>XOR 0xFF</code> · 网站构建于 2026-10-08
</div></footer>
<script src="js/app.js"></script>
</body></html>''')

print('骨架已写')
json.dump({'pages': PAGES}, io.open(os.path.join(SITE, '_pages.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
