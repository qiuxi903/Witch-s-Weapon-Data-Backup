# 构建网站剩余页面：配置表 / 音频 / 视频 / 美术 / 漫画 / 公告 / 系统 / 遗迹 / 全部文件
import io, os, sys, json, re, csv
from collections import defaultdict, OrderedDict, Counter

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
SITE = os.path.join(R, '网站')
ASSETS = json.load(io.open(os.path.join(R, 'tools', '_asset_index.json'), encoding='utf-8'))
BY_PATH = {a['p']: a for a in ASSETS}

def U(p): return '../' + p.replace('\\', '/')
def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')
def fmt(n):
    if n >= 1024**3: return '%.2f GB' % (n / 1024**3)
    if n >= 1024**2: return '%.1f MB' % (n / 1024**2)
    if n >= 1024: return '%.0f KB' % (n / 1024)
    return '%d B' % n

PAGES = [('index.html','首页'),('story.html','剧情'),('characters.html','角色'),
         ('config.html','配置表'),('audio.html','音频'),('video.html','视频'),
         ('art.html','美术'),('manga.html','四格漫画'),('news.html','官网公告'),
         ('system.html','系统设计'),('relics.html','开发遗迹'),('archive.html','全部文件')]

def nav(cur):
    items = ''.join('<a href="%s"%s>%s</a>' % (h, ' class="on"' if h == cur else '', t)
                    for h, t in PAGES)
    return ('<nav class="nav"><div class="nav-in">'
            '<span class="brand">魔女兵器 / ARCHIVE</span>%s</div></nav>' % items)

FOOT = '''<footer><div class="foot-in">
<b>《魔女兵器》 Witch's Weapon 收藏档案</b><br>
游戏开发：北京水琴铃（WaterBell）· 日服发行：EXNOA LLC / SUIKINREI<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途，不作任何商业使用。<br>
配置表与剧情解密方式：<code>XOR 0xFF</code> · 网站构建于 2026-10-08
</div></footer>
<script src="js/app.js"></script>
</body></html>'''

def page(fname, title, eyebrow, en, meta, body, tools=''):
    return ('<!DOCTYPE html>\n<html lang="zh-CN"><head><meta charset="UTF-8">\n'
            '<meta name="viewport" content="width=device-width, initial-scale=1">\n'
            '<title>%s · 魔女兵器收藏</title>\n'
            '<link rel="stylesheet" href="css/style.css">\n</head><body>\n%s\n'
            '<header class="hero"><div class="hero-in">\n'
            '<div class="eyebrow">%s</div>\n<h1>%s</h1>\n'
            '<div class="en">%s</div>\n<div class="meta">%s</div>\n'
            '</div></header>\n%s\n<main>\n%s\n</main>\n%s'
            % (esc(title), nav(fname), esc(eyebrow), esc(title), esc(en), meta, tools, body, FOOT))

written = []
def W(fname, html):
    p = os.path.join(SITE, fname)
    io.open(p, 'w', encoding='utf-8').write(html)
    written.append((fname, os.path.getsize(p)))
    print('  %-18s %s' % (fname, fmt(os.path.getsize(p))))

CFG = os.path.join(R, '03_配置表', '怀旧服v128')

# ============================================================
# 配置表
# ============================================================
def build_config():
    files = sorted(f for f in os.listdir(CFG) if f.endswith('.csv'))
    tables = []
    for f in files:
        p = os.path.join(CFG, f)
        raw = io.open(p, encoding='utf-8', errors='replace').read()
        head = '\n'.join(raw.split('\n')[:3])
        sep = '\t' if head.count('\t') > head.count(',') else ','
        rows = [r for r in csv.reader(io.StringIO(raw), delimiter=sep) if any(x.strip() for x in r)]
        if len(rows) < 3: continue
        tables.append({'n': f[:-4], 'f': [x.strip() for x in rows[0]],
                       'l': [x.strip() for x in rows[2]] if len(rows) > 2 else [],
                       'd': rows[3:], 'b': os.path.getsize(p)})
    tables.sort(key=lambda x: -len(x['d']))
    total = sum(len(t['d']) for t in tables)

    payload = json.dumps([{'n': t['n'], 'f': t['f'], 'l': t['l'], 'd': t['d']} for t in tables],
                         ensure_ascii=False, separators=(',', ':'))

    toc = ''.join('<div class="titem" data-n="%s" onclick="sel(%d)"><span>%s</span>'
                  '<span class="c">%d</span></div>' % (esc(t['n']), i, esc(t['n']), len(t['d']))
                  for i, t in enumerate(tables))

    body = '''
<div style="display:flex;gap:0;margin:-40px -32px 0;min-height:70vh">
<aside style="width:270px;flex:0 0 270px;border-right:1px solid var(--line);
background:var(--panel);padding:14px 0;max-height:calc(100vh - 56px);overflow-y:auto;
position:sticky;top:56px">
<div style="font-size:11.5px;color:var(--dim);font-family:var(--mono);padding:0 16px 10px">
%s 张表 · __ROWS__ 行</div>
<input id="tf" placeholder="筛选表名..." style="width:calc(100%% - 32px);margin:0 16px 10px;
padding:7px 10px;background:var(--panel2);border:1px solid var(--line);border-radius:4px;
color:var(--fg);font-size:12px;outline:none">
%s
</aside>
<div style="flex:1;min-width:0;padding:20px 26px 60px">
<div style="display:flex;gap:10px;align-items:center;margin-bottom:12px;flex-wrap:wrap">
<input id="q" placeholder="全表搜索（多关键词空格分隔）..."
 style="flex:1;min-width:180px;padding:8px 12px;background:var(--panel2);
 border:1px solid var(--line);border-radius:5px;color:var(--fg);font-size:13px;outline:none">
<button onclick="document.getElementById('q').value='';go('')">清除</button>
<span class="stat" id="stat" style="font-size:11.5px;color:var(--dim);font-family:var(--mono)"></span>
</div>
<h2 id="tn" style="font-size:20px;color:var(--gold);margin:0 0 3px">选择左侧配置表</h2>
<div class="cnt" id="ti"></div>
<div id="tw" class="scroll" style="max-height:calc(100vh - 300px)"></div>
</div></div>

<style>
.titem{display:flex;justify-content:space-between;gap:8px;padding:6px 16px;cursor:pointer;
font-size:12.5px;color:#b9bfc9;font-family:var(--mono);border-left:2px solid transparent}
.titem:hover{background:var(--panel2);color:var(--fg)}
.titem.on{background:var(--panel2);color:var(--gold);border-left-color:var(--gold)}
.titem .c{color:#5f6674;font-size:11px}
.titem.hide{display:none}
</style>
<script>
const DATA = %s;
let cur = 0, q = '';
function esc2(s){return (s||'').replace(/&/g,'&amp;').replace(/</g,'&lt;').replace(/>/g,'&gt;');}
function hl(s,kws){let o=esc2(s);kws.forEach(k=>{if(!k)return;
 o=o.replace(new RegExp('('+k.replace(/[.*+?^${}()|[\\]\\\\]/g,'\\\\$&')+')','gi'),'<mark>$1</mark>');});return o;}
function sel(i){
  cur=i;q='';document.getElementById('q').value='';
  document.querySelectorAll('.titem').forEach((e,j)=>e.classList.toggle('on',j===i));
  const t=DATA[i];
  document.getElementById('tn').textContent=t.n;
  document.getElementById('ti').textContent=t.f.length+' 列 · '+t.d.length+' 行';
  render();
}
function render(){
  const t=DATA[cur];
  const kws=q.trim()?q.trim().split(/\\s+/).filter(Boolean):[];
  let rows=t.d;
  if(kws.length) rows=rows.filter(r=>{const s=r.join('\\u0001').toLowerCase();
    return kws.every(k=>s.includes(k.toLowerCase()));});
  document.getElementById('stat').textContent=kws.length?
    ('匹配 '+rows.length+' / '+t.d.length+' 行'):(t.d.length+' 行');
  const max=300;
  let h='<table><thead><tr><th></th>';
  t.f.forEach(f=>{h+='<th>'+esc2(f)+'</th>';});
  h+='</tr><tr><th></th>';
  t.l.forEach((l,j)=>{h+='<th style="color:var(--dim);font-weight:400">'+esc2(l||t.f[j])+'</th>';});
  h+='</tr></thead><tbody>';
  rows.slice(0,max).forEach((r,ri)=>{
    h+='<tr><td class="idx">'+(ri+1)+'</td>';
    r.forEach(c=>{h+='<td>'+hl(c,kws)+'</td>';});h+='</tr>';});
  h+='</tbody></table>';
  if(rows.length>max) h+='<div style="padding:30px;color:var(--dim);text-align:center">'+
    '仅显示前 '+max+' 行（共 '+rows.length+' 行），请用搜索缩小范围</div>';
  if(!rows.length) h='<div style="padding:40px;color:var(--dim);text-align:center">无匹配结果</div>';
  document.getElementById('tw').innerHTML=h;
}
let tm=null;
document.getElementById('q').oninput=e=>{clearTimeout(tm);
  tm=setTimeout(()=>{q=e.target.value;render();},180);};
document.getElementById('tf').oninput=e=>{
  const k=e.target.value.toLowerCase();
  document.querySelectorAll('.titem').forEach(el=>{
    el.classList.toggle('hide',!el.getAttribute('data-n').toLowerCase().includes(k));});
};
sel(0);
</script>'''.replace('__ROWS__', '{:,}'.format(total)) % (len(tables), toc, payload)

    meta = ('<b>配置表</b>：%d 张 · %s 行 · 全部解密<br>'
            '<b>来源</b>：客户端 <code>clientexel/*.ab</code> · XOR 0xFF') % (len(tables), '{:,}'.format(total))
    W('config.html', page('config.html', '配置表', 'WITCH\'S WEAPON / CONFIG TABLES',
                          'CONFIG EXPLORER · %d TABLES' % len(tables), meta, body))

build_config()

# ============================================================
# 音频
# ============================================================
def build_audio():
    A = [a for a in ASSETS if a['k'] == 'audio']
    groups = defaultdict(list)
    for a in A:
        p = a['p']
        if '/cv/' in p or 'CV' in p: g = 'CV 语音'
        elif 'BGM' in p or 'bgm' in p: g = 'BGM 原声'
        elif 'fight' in p: g = '战斗音效'
        elif 'MainUI' in p or '界面' in p: g = '界面音效'
        else: g = '其它'
        groups[g].append(a)

    secs = []
    for g in ['CV 语音', 'BGM 原声', '战斗音效', '界面音效', '其它']:
        items = groups.get(g, [])
        if not items: continue
        sz = sum(x['b'] for x in items)
        trk = ''.join('<div class="track"><div class="nm">%s</div>'
                      '<div class="sz">%s</div>'
                      '<audio controls preload="none" src="%s"></audio></div>'
                      % (esc(os.path.basename(x['p'])), fmt(x['b']), U(x['p']))
                      for x in sorted(items, key=lambda y: y['p']))
        secs.append('<section><h2 class="bar">%s</h2><div class="cnt">%d 个 · %s</div>'
                    '<div class="grid g3">%s</div></section>' % (g, len(items), fmt(sz), trk))

    body = ('<section><h2 class="bar">音频资源</h2>'
            '<div class="cnt">%d 个文件 · %s · 官方 sound.csv 登记 1,856 条</div>'
            '<div class="note">CV 语音按角色分目录（<code>servant100</code> ~ <code>servant137</code> + <code>player</code>）。'
            '全部可直接在线播放。</div></section>%s'
            % (len(A), fmt(sum(x['b'] for x in A)), '\n'.join(secs)))

    meta = ('<b>音频</b>：%d 个 · %s<br>'
            '<b>分类</b>：CV 语音 / BGM 原声 / 战斗音效 / 界面音效') % (len(A), fmt(sum(x['b'] for x in A)))
    W('audio.html', page('audio.html', '音频', 'WITCH\'S WEAPON / AUDIO',
                         'AUDIO ARCHIVE · %d FILES' % len(A), meta, body))

build_audio()

# ============================================================
# 视频
# ============================================================
def build_video():
    V = sorted([a for a in ASSETS if a['k'] == 'video'], key=lambda x: -x['b'])
    cards = ''.join('''<article class="card" style="cursor:default">
<video controls preload="metadata" src="%s"></video>
<div class="body"><div class="ttl">%s</div><div class="sub">%s</div></div>
</article>''' % (U(v['p']), esc(os.path.basename(v['p'])), fmt(v['b'])) for v in V)

    body = ('<section><h2 class="bar">视频资源</h2>'
            '<div class="cnt">%d 个独立视频 · %s（已按内容去重）</div>'
            '<div class="note">各服 PV <b>完全不同</b> —— 日服、港澳台、韩服各有独占宣传片，'
            '是重要的版本差异证据。另有 7 个 <code>.ogv</code> 来自怀旧服 Godot 客户端。</div>'
            '<div class="grid g2">%s</div></section>'
            % (len(V), fmt(sum(v['b'] for v in V)), cards))

    meta = ('<b>视频</b>：%d 个 · %s<br>'
            '<b>内容</b>：PV 宣传片 · 剧情过场 · 各服独占版本') % (len(V), fmt(sum(v['b'] for v in V)))
    W('video.html', page('video.html', '视频', 'WITCH\'S WEAPON / VIDEO',
                         'VIDEO ARCHIVE · %d CLIPS' % len(V), meta, body))

build_video()

json.dump(written, io.open(os.path.join(SITE, '_written2.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
print('已写 %d 页' % len(written))
