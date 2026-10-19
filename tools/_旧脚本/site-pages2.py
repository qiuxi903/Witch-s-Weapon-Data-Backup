# 重建配置表 / 漫画 / 公告 / 系统 / 遗迹 / 全部文件
import io, os, sys, json, re, csv
from collections import defaultdict, Counter

sys.path.insert(0, r'G:\project\其他\game\tools')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from site_lib import (R, SITE, ASSETS, IMETA, page, U, esc, fmt, gallery_item)

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
        raw = io.open(os.path.join(CFG, f), encoding='utf-8', errors='replace').read()
        head = '\n'.join(raw.split('\n')[:3])
        sep = '\t' if head.count('\t') > head.count(',') else ','
        rows = [r for r in csv.reader(io.StringIO(raw), delimiter=sep)
                if any(x.strip() for x in r)]
        if len(rows) < 3: continue
        tables.append({'n': f[:-4], 'f': [x.strip() for x in rows[0]],
                       'l': [x.strip() for x in rows[2]] if len(rows) > 2 else [],
                       'd': rows[3:]})
    tables.sort(key=lambda x: -len(x['d']))
    total = sum(len(t['d']) for t in tables)

    payload = json.dumps([{'n': t['n'], 'f': t['f'], 'l': t['l'], 'd': t['d']}
                          for t in tables], ensure_ascii=False, separators=(',', ':'))
    toc = ''.join('<button type="button" class="titem" data-n="%s" onclick="sel(%d)">'
                  '<span class="tn">%s</span><span class="tc">%d</span></button>'
                  % (esc(t['n']), i, esc(t['n']), len(t['d']))
                  for i, t in enumerate(tables))

    body = r'''
<div class="cfg">
<aside class="cfg-side">
  <div class="cfg-side-h">__N__ 张表 · __ROWS__ 行</div>
  <label class="sr-only" for="tf">筛选表名</label>
  <input id="tf" type="search" placeholder="筛选表名…">
  <div class="cfg-list">__TOC__</div>
</aside>
<div class="cfg-main">
  <div class="cfg-bar">
    <label class="sr-only" for="q">全表搜索</label>
    <input id="q" type="search" placeholder="全表搜索（多关键词空格分隔）…">
    <button type="button" id="clr">清除</button>
    <span class="stat" id="stat"></span>
  </div>
  <h2 class="sec" id="tn">选择左侧配置表</h2>
  <div class="cnt" id="ti"></div>
  <div id="tw" class="tbl-wrap" style="max-height:calc(100vh - 290px)"></div>
</div>
</div>

<style>
.cfg{
  display:flex;gap:0;
  margin:calc(-1 * var(--s7)) calc(-1 * var(--s6)) 0;
  min-height:74vh;
}
.cfg-side{
  width:310px;flex:0 0 310px;
  border-right:1px solid var(--line);
  background:var(--surface);
  padding:var(--s5) 0;
  max-height:calc(100vh - var(--nav-h));
  overflow-y:auto;position:sticky;top:var(--nav-h);
}
.cfg-side-h{
  font-size:13px;color:var(--text-4);
  padding:0 var(--s5) var(--s4);
}
.cfg-side input{
  width:calc(100% - var(--s5) * 2);margin:0 var(--s5) var(--s4);
  padding:10px 14px;background:var(--surface-3);
  border:1px solid var(--line);border-radius:var(--r-sm);
  color:var(--text);font-size:14.5px;outline:none;
  transition:border-color var(--dur),box-shadow var(--dur);
}
.cfg-side input:focus{border-color:var(--accent);box-shadow:0 0 0 3px var(--accent-soft)}
.cfg-list{display:flex;flex-direction:column}
.titem{
  display:flex;justify-content:space-between;gap:12px;align-items:center;
  padding:10px var(--s5);cursor:pointer;
  font-size:14.5px;color:var(--text-2);
  border:0;background:none;text-align:left;width:100%;
  border-left:3px solid transparent;
  transition:all var(--dur) var(--ease);
}
.titem:hover{background:var(--surface-3);color:var(--text)}
.titem.on{
  background:var(--accent-soft);color:var(--accent);
  border-left-color:var(--accent);font-weight:650;
}
.titem .tc{color:var(--text-4);font-size:12.5px;flex:0 0 auto;font-family:var(--mono)}
.titem .tn{overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.titem.hide{display:none}
.cfg-main{flex:1;min-width:0;padding:var(--s6) var(--s6) 90px}
.cfg-bar{display:flex;gap:var(--s3);align-items:center;margin-bottom:var(--s5);flex-wrap:wrap}
.cfg-bar input{
  flex:1;min-width:220px;padding:11px 16px;
  background:var(--surface);border:1px solid var(--line-2);
  border-radius:var(--r-sm);color:var(--text);font-size:15px;outline:none;
  transition:border-color var(--dur),box-shadow var(--dur);
}
.cfg-bar input:focus{border-color:var(--accent);box-shadow:0 0 0 3px var(--accent-soft)}
.cfg-bar button{
  padding:11px 20px;background:var(--surface);border:1px solid var(--line-2);
  border-radius:var(--r-sm);color:var(--text-2);cursor:pointer;font-size:14px;
  transition:all var(--dur) var(--ease);
}
.cfg-bar button:hover{border-color:var(--line-3);color:var(--text);background:var(--surface-3)}
@media(max-width:900px){
  .cfg{flex-direction:column;margin:calc(-1 * var(--s6)) calc(-1 * var(--s4)) 0}
  .cfg-side{
    width:auto;flex:0 0 auto;position:static;max-height:260px;
    border-right:0;border-bottom:1px solid var(--line);
  }
  .cfg-main{padding:var(--s5) var(--s4) 70px}
}
</style>

<script>
const DATA = __DATA__;
let cur = 0, q = '';
function esc2(s){return (s==null?'':String(s)).replace(/&/g,'&amp;')
  .replace(/</g,'&lt;').replace(/>/g,'&gt;');}
function hl(s,kws){
  let o = esc2(s);
  kws.forEach(function(k){
    if(!k) return;
    var e = k.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
    o = o.replace(new RegExp('('+e+')','gi'),'<mark>$1</mark>');
  });
  return o;
}
function sel(i){
  cur = i; q = '';
  var qi = document.getElementById('q'); if(qi) qi.value = '';
  document.querySelectorAll('.titem').forEach(function(e,j){
    e.classList.toggle('on', j===i);
  });
  var t = DATA[i];
  document.getElementById('tn').textContent = t.n;
  document.getElementById('ti').textContent = t.f.length + ' 列 · ' +
    t.d.length.toLocaleString() + ' 行';
  render();
}
function render(){
  var t = DATA[cur];
  var kws = q.trim() ? q.trim().split(/\s+/).filter(Boolean) : [];
  var rows = t.d;
  if(kws.length){
    rows = rows.filter(function(r){
      var s = r.join('\u0001').toLowerCase();
      return kws.every(function(k){ return s.indexOf(k.toLowerCase()) !== -1; });
    });
  }
  var st = document.getElementById('stat');
  st.textContent = kws.length
    ? ('匹配 ' + rows.length.toLocaleString() + ' / ' + t.d.length.toLocaleString() + ' 行')
    : (t.d.length.toLocaleString() + ' 行');

  if(!rows.length){
    document.getElementById('tw').innerHTML = '<div class="empty">无匹配结果</div>';
    return;
  }
  var max = 300;
  var h = '<table><thead><tr><th></th>';
  t.f.forEach(function(f){ h += '<th>' + esc2(f) + '</th>'; });
  h += '</tr><tr><th></th>';
  t.l.forEach(function(l,j){
    h += '<th style="color:var(--text-4);font-weight:400;text-transform:none">' +
         esc2(l || t.f[j]) + '</th>';
  });
  h += '</tr></thead><tbody>';
  rows.slice(0, max).forEach(function(r, ri){
    h += '<tr><td class="idx">' + (ri+1) + '</td>';
    r.forEach(function(c){ h += '<td>' + hl(c, kws) + '</td>'; });
    h += '</tr>';
  });
  h += '</tbody></table>';
  if(rows.length > max){
    h += '<div class="empty">仅显示前 ' + max + ' 行（共 ' +
         rows.length.toLocaleString() + ' 行），请用搜索缩小范围</div>';
  }
  document.getElementById('tw').innerHTML = h;
}
var tm = null;
document.getElementById('q').oninput = function(e){
  clearTimeout(tm); tm = setTimeout(function(){ q = e.target.value; render(); }, 170);
};
document.getElementById('tf').oninput = function(e){
  var k = e.target.value.toLowerCase();
  document.querySelectorAll('.titem').forEach(function(el){
    el.classList.toggle('hide', el.getAttribute('data-n').toLowerCase().indexOf(k) === -1);
  });
};
document.getElementById('clr').onclick = function(){
  var i = document.getElementById('q'); i.value = ''; q = ''; render(); i.focus();
};
sel(0);
</script>'''

    body = (body.replace('__N__', str(len(tables)))
                .replace('__ROWS__', '{:,}'.format(total))
                .replace('__TOC__', toc)
                .replace('__DATA__', payload))

    meta = ('<b>配置表</b>：%d 张 · %s 行 · 全部解密<br>'
            '<b>来源</b>：客户端 <code>clientexel/*.ab</code> · XOR 0xFF'
            % (len(tables), '{:,}'.format(total)))
    W('config.html', page('config.html', '配置表', "WITCH'S WEAPON / CONFIG TABLES",
                          'CONFIG EXPLORER · %d TABLES' % len(tables), meta, body))

build_config()

# ============================================================
# 四格漫画
# ============================================================
def build_manga():
    BASE = os.path.join(R, '02_客户端解包', '网络资源', '13_官网日服witchs-weapon.net')
    d = json.load(io.open(os.path.join(BASE, 'cartoon.json'), encoding='utf-8'))
    TR = {
     1005:('主从关系','「主人」与「仆从」的日常 —— 谁才是真正说了算的那个？'),
     1039:('新来的','新人报到，但魔女兵器的「新人」从来都不太正常。'),
     1045:('过去的污点','黑历史被翻出来了 —— 某些人宁愿它永远埋着。'),
     1067:('共享记忆','英灵与兵器共享记忆，于是尴尬也一起共享了。'),
     1073:('正是这个年纪','再怎么是魔女，该有的少女心事一样不少。'),
     1079:('恶魔～','「恶魔」这个词，在魔女兵器里有别的解释。'),
     1121:('健康生活！？','为了健康而努力，但方式好像哪里不对。'),
     1136:('搭档','所谓搭档，就是互相拖后腿还嘴硬的那种。'),
     1145:('非常奇妙的故事','奇妙到不知道该从哪里吐槽起。'),
     1154:('消失了！？','东西不见了 —— 凶手就在这些人当中。'),
     1188:('不擅长的事','每个人都有弱点，魔女的弱点尤其致命。'),
     1199:('那方面的达人','在某个领域登峰造极，可惜方向有点偏。'),
     1217:('本性','伪装再久，本性总会在某个瞬间露出来。'),
     1233:('运营来信','来自运营方的信 —— 通常意味着要出事了。'),
     1240:('世界级权威','权威人士登场，然后被现实狠狠打脸。'),
     1264:('BUG ①','游戏出 bug 了，角色们自己也知道。'),
     1295:('BUG ②','bug 的后续 —— 修好了吗？显然没有。'),
     1806:('猫，之后','那只猫后来怎么样了 —— 答案是更麻烦了。'),
     1808:('续·猫，之后','猫的故事还有续集，而且更失控。'),
     1866:('监护人','谁是监护人谁是小孩，这事经常搞反。'),
     1868:('雨天发生的事 ①','下雨天总会有事发生，这次也一样。'),
     1870:('雨天发生的事 ②','雨还没停，麻烦也没停。'),
     1884:('超载','装太多了 —— 物理意义上和比喻意义上都是。'),
     1887:('误会','一场误会，然后滚成雪球。'),
     1945:('满员电车','挤电车这件事，魔女也躲不过。'),
     1954:('精神年龄','年龄是数字，精神年龄才是真相。'),
     1970:('格差社会','差距就是差距，连魔女界也一样。'),
     1982:('干劲开关','只要找到那个开关，谁都能爆发。'),
     1985:('系统的背面','游戏系统的背面 —— 玩家看不到的那一面。'),
     1992:('秘密的房间','有个房间不该进去，但总有人要进。'),
     1999:('银河的尽头','尺度突然拉大到银河级别。'),
     2008:('救赎？','这是救赎吗 —— 问号很重要。'),
     2017:('无妄之灾','什么都没做，祸从天上来。'),
     2029:('规格的正面','官方设定是这样写的 —— 正面版本。'),
     2036:('规格的背面','官方设定没写的那部分。'),
      802:('购物 ①','去买东西，然后事情开始跑偏。'),
      810:('购物 ②','购物续集 —— 这次更离谱。'),
      878:('【番外篇】来自开发组的信','开发组亲自下场 —— 通常意味着要道歉了。'),
      900:('同类相吸！？','性格相似的人凑一起，要么成为挚友要么成为灾难。'),
      919:('劈西瓜 ①','夏日定番：蒙眼劈西瓜，但参与者是魔女。'),
      938:('劈西瓜 ②','西瓜还没劈开，场面已经失控。'),
      958:('邪神？召唤','召唤仪式 —— 召唤出来的东西不太对。'),
      965:('邪神？现身','召唤物的后续：它真的来了。'),
      971:('大小姐','「大小姐」这个称呼，有人喜欢有人炸毛。'),
      979:('异世界转生！？','异世界转生题材 —— 魔女兵器也来玩一把。'),
    }
    strips = []
    for s in sorted(d, key=lambda x: x['date']):
        if not s['imgs']: continue
        zh, note = TR.get(s['id'], (s['title'], ''))
        panels = ''.join(
            '<figure style="margin:0">'
            '<img src="%s" alt="%s 第 %d 格" loading="lazy" decoding="async" '
            'style="width:100%%;border-radius:6px;background:#0b0d11">'
            '</figure>'
            % (U('02_客户端解包/网络资源/13_官网日服witchs-weapon.net/cartoon_img/' + n),
               esc(zh), k + 1)
            for k, n in enumerate(s['imgs']))
        strips.append('''<article class="strip" data-t="%s %s %s %s">
<div class="hd">
  <span class="no">%04d</span>
  <span class="zh">%s</span>
  <span class="jp">%s</span>
  <span class="dt">%s</span>
</div>
<div class="note2">%s</div>
<div class="panels">%s</div>
</article>''' % (esc(zh), esc(s['title']), esc(note), esc(s['date']),
                 s['id'], esc(zh), esc(s['title']), esc(s['date']), esc(note), panels))

    tools = ('<div class="tools"><div class="tools-in">'
             '<label class="sr-only" for="q">搜索漫画</label>'
             '<input id="q" type="search" placeholder="搜索漫画标题或简介…">'
             '<button type="button" id="clr">清除</button>'
             '<span class="stat" id="stat"></span></div></div>')

    body = ('<section><h2 class="sec">官方四格漫画</h2>'
            '<div class="cnt">%d 篇 · 220 张图 · 2019-06 ~ 2020-07</div>'
            '<div class="note">抓取自日服官网 <code>/cartoon/</code> —— 这是官网'
            '<b>唯一还在线的原创内容</b>。标题与简介为中文翻译，画面保留日文原图。</div>'
            '%s</section>' % (len(strips), '\n'.join(strips)))

    extra = '''
<style>
.strip{
  background:var(--surface);border:1px solid var(--line);
  border-radius:var(--r);padding:var(--s5);
  margin-bottom:var(--s5);box-shadow:var(--sh-sm);
  transition:box-shadow var(--dur) var(--ease);
}
.strip:hover{box-shadow:var(--sh)}
.strip .hd{display:flex;align-items:baseline;gap:var(--s3);
  margin-bottom:var(--s3);flex-wrap:wrap}
.strip .no{font-size:13px;color:var(--accent);font-family:var(--mono);font-weight:650}
.strip .zh{font-size:23px;color:var(--text);font-weight:650;letter-spacing:-.02em}
.strip .jp{font-size:14px;color:var(--text-4)}
.strip .dt{font-size:13px;color:var(--text-4);font-family:var(--mono);margin-left:auto}
.strip .note2{
  font-size:15px;color:var(--text-2);margin-bottom:var(--s5);
  padding-left:14px;border-left:3px solid var(--line-2);line-height:1.8;
}
.panels{display:grid;grid-template-columns:repeat(auto-fit,minmax(260px,1fr));gap:var(--s3)}
</style>'''

    meta = ('<b>四格漫画</b>：45 篇 · 220 张图<br>'
            '<b>来源</b>：日服官网 <code>witchs-weapon.net/cartoon/</code>')
    html = page('manga.html', '四格漫画', "WITCH'S WEAPON / 4-KOMA",
                'OFFICIAL 4-KOMA · CN TRANSLATION', meta, body, tools)
    html = html.replace('</head>', extra + '\n</head>')
    html = html.replace('<script src="js/app.js"></script>',
                        '<script src="js/app.js"></script>\n'
                        '<script>bindFilter("q",".strip","stat","data-t");'
                        'document.getElementById("clr").onclick=function(){'
                        'var i=document.getElementById("q");i.value="";'
                        'i.dispatchEvent(new Event("input"));i.focus();};</script>')
    W('manga.html', html)

build_manga()

json.dump(written, io.open(os.path.join(SITE, '_w2.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
print('已写 %d 页' % len(written))
