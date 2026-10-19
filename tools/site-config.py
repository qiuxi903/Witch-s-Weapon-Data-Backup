# 配置表浏览器（多区服版）
#   · 每个区服的数据单独写成 网站/data/cfg-<slug>.js，点开才加载
#   · config.html 只含外壳 + 版本选择器
import io, os, sys, json, csv, zipfile

sys.path.insert(0, r'G:\project\其他\game\tools')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from site_lib import R, SITE, page, fmt

# slug, 显示名, 版本, 类型, 备注, 03_配置表 目录名
VERSIONS = [
    ('huijiu',  '怀旧服', 'v128',   'community',
     '社区服测试构建（witchweapon.wiki）· 含 19 处解锁等级改动', '怀旧服v128'),
    ('guofu',   '国服',   'v2.0.1', 'official',
     '官方 · 国服停服版本（2024-08-17）', '国服v2.0.1'),
    ('rifu',    '日服',   'v2.0.0', 'official',
     '官方 · 日服（EXNOA / SUIKINREI）', '日服v2.0.0'),
    ('gangtai', '港澳台', 'v1.6.0', 'official',
     '官方 · 港澳台（LTgames）', '港澳台v1.6.0'),
    ('hanfu',   '韩服',   'v1.0',   'official',
     '官方 · 韩服（Google Play）', '韩服v1.0'),
]

DATA_DIR = os.path.join(SITE, 'data')

# 策划表的前置行类型：字段名 / 类型 / 中文标签，长度并不固定（3~6 行都有）
TYPE_WORDS = {'string', 'int', 'long', 'float', 'double', 'bool', 'boolean',
              'bytes', 'byte', 'short', 'uint', 'ulong', 'decimal', 'datetime',
              'object', 'vector3', 'color'}
# 中文标签行的首格常常写成 ID（如 dictionarystatic 表头是 tag，标签行首格却是 ID）
LABEL_WORDS = {'id'}


def detect_delim(t):
    """dictionary / dictionarystatic 是制表符分隔，其余是逗号"""
    first = t.split('\n')[0]
    return '\t' if first.count('\t') > first.count(',') else ','


def _has_cjk(s):
    return any('\u4e00' <= ch <= '\u9fff' for ch in s)


def _is_label_row(cells, h0):
    """判断是否为前置说明行（字段名/类型/中文标签/空行），不是数据行"""
    c0 = (cells[0].strip() if cells else '')
    if not c0:                                   # 空行
        return True
    if c0.lower() == h0.strip().lower():         # 重复表头
        return True
    if c0.lower() in TYPE_WORDS:                 # 类型行
        return True
    if c0.lower() in LABEL_WORDS:                # ID 标签行
        return True
    if _has_cjk(c0):                             # 中文标签行
        return True
    return False


def find_data_start(rows):
    """数据起始行：跳过前置说明行。真实数据的首列是数字或 ASCII 标识符。"""
    h0 = rows[0][0] if rows and rows[0] else ''
    for i in range(1, min(len(rows), 20)):
        if not _is_label_row(rows[i], h0):
            return i
    return len(rows)                             # 全是说明行 → 无数据


def read_tables(dirname):
    d = os.path.join(R, '03_配置表', dirname)
    tables = []
    if not os.path.isdir(d):
        return tables
    for f in sorted(os.listdir(d)):
        if not f.endswith('.csv'):
            continue
        try:
            txt = io.open(os.path.join(d, f), encoding='utf-8',
                          errors='replace').read()
            rows = list(csv.reader(io.StringIO(txt), delimiter=detect_delim(txt)))
        except Exception:
            continue
        if len(rows) < 2:
            continue
        hdr = [h.lstrip('\ufeff') for h in rows[0]]
        start = find_data_start(rows)
        # 丢掉全空行（部分表整表只有表头）
        body = [r for r in rows[start:] if any(c.strip() for c in r)]
        # 列宽统一：取表头与数据行的最大宽度，两侧都补齐
        width = max([len(hdr)] + [len(r) for r in body]) if body else len(hdr)
        hdr = hdr + [''] * (width - len(hdr))
        body = [r + [''] * (width - len(r)) for r in body]
        tables.append({'n': f[:-4], 'f': hdr, 'd': body})
    return tables


def table_csv(t):
    """把一张表序列化成 CSV 文本（行尾 CRLF，开头带 UTF-8 BOM，方便 Excel 打开）"""
    buf = io.StringIO()
    w = csv.writer(buf, lineterminator='\r\n')
    w.writerow(t['f'])
    for r in t['d']:
        w.writerow(r)
    return '\ufeff' + buf.getvalue()


def write_zip(slug, name, ver, tables):
    """整个区服打包成一个 ZIP，供页面直接下载"""
    zdir = os.path.join(DATA_DIR, 'zip')
    os.makedirs(zdir, exist_ok=True)
    p = os.path.join(zdir, slug + '.zip')
    readme = (
        '《魔女兵器》配置表 · %s %s\r\n'
        '%s\r\n'
        '\r\n'
        '共 %d 张表，全部由客户端 assetbundle 解密得到。\r\n'
        '每张表一个 CSV，行尾 CRLF、开头带 BOM，可直接用 Excel 打开。\r\n'
        '空行、字段名行、类型行、中文标签行已剔除，只保留真实数据。\r\n'
        '\r\n'
        '本档案仅供研究与保存用途，游戏版权归北京水琴铃（WaterBell）及各发行方所有。\r\n'
        % (name, ver, [v[4] for v in VERSIONS if v[0] == slug][0], len(tables))
    )
    with zipfile.ZipFile(p, 'w', zipfile.ZIP_DEFLATED, compresslevel=9) as z:
        z.writestr('_说明.txt', readme)
        for t in tables:
            z.writestr('%s.csv' % t['n'], table_csv(t))
    return p


def build():
    os.makedirs(DATA_DIR, exist_ok=True)
    meta = []
    for slug, name, ver, kind, note, dirname in VERSIONS:
        tables = read_tables(dirname)
        if not tables:
            print('  [跳过] %s（无数据）' % name)
            continue
        rows = sum(len(t['d']) for t in tables)
        js = ('window.__CFG__=window.__CFG__||{};window.__CFG__[%s]=%s;'
              % (json.dumps(slug), json.dumps(tables, ensure_ascii=False,
                                              separators=(',', ':'))))
        p = os.path.join(DATA_DIR, 'cfg-%s.js' % slug)
        io.open(p, 'w', encoding='utf-8').write(js)
        zp = write_zip(slug, name, ver, tables)
        meta.append({'slug': slug, 'name': name, 'ver': ver, 'kind': kind,
                     'note': note, 'tables': len(tables), 'rows': rows,
                     'zip': os.path.getsize(zp)})
        print('  data/cfg-%-8s %8s  %3d 表  %9s 行   zip %8s'
              % (slug + '.js', fmt(os.path.getsize(p)), len(tables),
                 '{:,}'.format(rows), fmt(os.path.getsize(zp))))

    total_t = sum(m['tables'] for m in meta)
    total_r = sum(m['rows'] for m in meta)

    tools = ''   # 本页自带搜索条，不用站点的通用工具条（否则 id 重复）

    body = '''<div class="cfg">
<div class="cfg-top">
  <div class="ver-bar" id="vbar" role="tablist" aria-label="选择区服版本"></div>
  <div class="cfg-bar">
    <label class="sr-only" for="q">搜索当前表</label>
    <input id="q" type="search" placeholder="在当前表中搜索…">
    <button type="button" id="clr">清除</button>
    <span class="stat" id="stat"></span>
  </div>
  <div class="ver-note" id="vnote"></div>
</div>
<div class="cfg-body">
  <div class="cfg-side">
    <div class="cfg-side-h" id="sh">—</div>
    <label class="sr-only" for="tq">筛选表名</label>
    <input id="tq" type="search" placeholder="筛选表名…">
    <div class="cfg-list" id="tl"></div>
  </div>
  <div class="cfg-main">
    <div class="cfg-head">
      <div>
        <h2 class="sec" id="tn">选择左侧配置表</h2>
        <div class="cnt" id="ti"></div>
      </div>
      <div class="dl" id="dl" hidden>
        <button type="button" id="dlcsv" title="把当前显示的行导出为 CSV"></button>
        <button type="button" id="dljson" title="导出为 JSON（含字段名）">JSON</button>
      </div>
    </div>
    <div id="tw" class="tbl-wrap" style="max-height:calc(100vh - 200px)"></div>
  </div>
</div>
</div>

<style>
.cfg{margin:calc(-1 * var(--s7)) calc(-1 * var(--s6)) 0}
.cfg-top{border-bottom:1px solid var(--line);background:var(--surface);
  padding:var(--s4) var(--s5) var(--s3);position:sticky;top:var(--nav-h);z-index:6}
.ver-bar{display:flex;gap:8px;flex-wrap:wrap}
.vtab{display:flex;align-items:center;gap:8px;padding:9px 15px;cursor:pointer;
  background:var(--surface-2);border:1px solid var(--line);border-radius:var(--r-sm);
  color:var(--text-2);font-size:14.5px;font-family:inherit;
  transition:all var(--dur) var(--ease)}
.vtab:hover{border-color:var(--line-2);color:var(--text);transform:translateY(-1px)}
.vtab.on{background:var(--red-soft);border-color:var(--red);color:var(--text);font-weight:700}
.vtab .vv{font-family:var(--mono);font-size:12.5px;color:var(--text-4)}
.vtab.on .vv{color:var(--red-2)}
.vtab .vk{font-size:11px;padding:2px 7px;border-radius:999px;letter-spacing:.04em}
.vtab .k-official{background:rgba(31,111,120,.14);color:var(--cyan)}
.vtab .k-community{background:var(--red-soft);color:var(--red-2)}
html[data-theme="light"] .vtab .k-official{background:rgba(31,111,120,.12)}
.vtab .vt{font-family:var(--mono);font-size:12px;color:var(--text-4)}
.ver-note{margin-top:10px;font-size:13px;color:var(--text-4);line-height:1.6;
  display:flex;gap:14px;flex-wrap:wrap;align-items:center}
.ver-note b{color:var(--text-2);font-weight:600}
.ver-note .warn{color:var(--red-2)}
.ver-note .zip{margin-left:auto;display:inline-flex;align-items:center;gap:7px;
  padding:8px 16px;border:1px solid var(--line-2);border-radius:var(--r-sm);
  color:var(--text-2);text-decoration:none;font-size:13px;white-space:nowrap;
  transition:all var(--dur) var(--ease-2)}
.ver-note .zip:hover{border-color:var(--red);color:var(--red-2);
  background:var(--red-soft);transform:translateY(-1px)}
.cfg-head{display:flex;justify-content:space-between;align-items:flex-start;
  gap:var(--s4);flex-wrap:wrap}
.cfg-head .cnt{margin-bottom:var(--s4)}
.dl{display:flex;gap:8px;flex-shrink:0}
.dl button{padding:9px 16px;background:var(--surface);border:1px solid var(--line-2);
  border-radius:var(--r-sm);color:var(--text-2);cursor:pointer;font-size:13.5px;
  font-family:inherit;transition:all var(--dur) var(--ease-2);white-space:nowrap}
.dl button:hover{border-color:var(--red);color:var(--red-2);background:var(--red-soft)}
.dl button:disabled{opacity:.5;cursor:default}
.prog{padding:14px var(--s5);font-size:13px;color:var(--text-4);
  font-family:var(--mono);border-top:1px solid var(--line)}
.cfg-body{display:flex;gap:0;min-height:74vh}
.cfg-side{width:310px;flex:0 0 310px;border-right:1px solid var(--line);
  background:var(--surface);padding:var(--s5) 0;
  max-height:calc(100vh - 260px);overflow-y:auto}
.cfg-side-h{font-size:13px;color:var(--text-4);padding:0 var(--s5) var(--s4)}
.cfg-side input{width:calc(100% - var(--s5) * 2);margin:0 var(--s5) var(--s4);
  padding:10px 14px;background:var(--surface-2);border:1px solid var(--line);
  border-radius:var(--r-sm);color:var(--text);font-size:14.5px;outline:none;
  transition:border-color var(--dur),box-shadow var(--dur)}
.cfg-side input:focus{border-color:var(--red);box-shadow:0 0 0 3px var(--red-soft)}
.cfg-list{display:flex;flex-direction:column}
.titem{display:flex;justify-content:space-between;gap:12px;align-items:center;
  padding:10px var(--s5);cursor:pointer;font-size:14.5px;color:var(--text-2);
  border:0;background:none;text-align:left;width:100%;border-left:3px solid transparent;
  transition:all var(--dur) var(--ease);font-family:inherit}
.titem:hover{background:var(--surface-2);color:var(--text)}
.titem.on{background:var(--red-soft);color:var(--red-2);
  border-left-color:var(--red);font-weight:700}
.titem .tc{color:var(--text-4);font-size:12.5px;flex:0 0 auto;font-family:var(--mono)}
.titem .tn{overflow:hidden;text-overflow:ellipsis;white-space:nowrap}
.titem.hide{display:none}
.cfg-main{flex:1;min-width:0;padding:var(--s5) var(--s6) 90px}
.cfg-bar{display:flex;gap:var(--s3);align-items:center;margin-top:var(--s4);flex-wrap:wrap}
.cfg-bar input{flex:1;min-width:220px;padding:12px 18px;background:var(--surface);
  border:1px solid var(--line-2);border-radius:var(--r-sm);color:var(--text);
  font-size:15px;outline:none;transition:border-color var(--dur),box-shadow var(--dur)}
.cfg-bar input:focus{border-color:var(--red);box-shadow:0 0 0 3px var(--red-soft)}
.cfg-bar button{padding:12px 22px;background:var(--surface);border:1px solid var(--line-2);
  border-radius:var(--r-sm);color:var(--text-2);cursor:pointer;font-size:14px;
  transition:all var(--dur) var(--ease-2);font-family:inherit}
.cfg-bar button:hover{border-color:var(--red);color:var(--text);background:var(--surface-2)}
.cfg-load{padding:80px 20px;text-align:center;color:var(--text-4);font-size:15px}
.cfg-load .sp{display:inline-block;width:26px;height:26px;margin-bottom:16px;
  border:2px solid var(--line-2);border-top-color:var(--red);border-radius:50%;
  animation:spin .8s linear infinite}
@keyframes spin{to{transform:rotate(360deg)}}
@media(prefers-reduced-motion:reduce){.cfg-load .sp{animation:none}}
@media(max-width:900px){
  .cfg{margin:calc(-1 * var(--s6)) calc(-1 * var(--s4)) 0}
  .cfg-top{position:static;padding:var(--s4)}
  .cfg-body{flex-direction:column}
  .cfg-side{width:auto;flex:0 0 auto;position:static;max-height:240px;
    border-right:0;border-bottom:1px solid var(--line)}
  .cfg-main{padding:var(--s5) var(--s4) 70px}
  .vtab{padding:8px 12px;font-size:13.5px}
}
</style>

<script>
var META = __META__;
var CUR = null, DATA = null, cur = 0, q = '';
function esc2(s){return (s==null?'':String(s)).replace(/&/g,'&amp;')
  .replace(/</g,'&lt;').replace(/>/g,'&gt;');}
function hl(s,kws){
  var o = esc2(s);
  kws.forEach(function(k){
    if(!k) return;
    var e = k.replace(/[.*+?^${}()|[\\]\\\\]/g, "\\\\$&");
    o = o.replace(new RegExp('('+e+')','gi'),'<mark>$1</mark>');
  });
  return o;
}
function paintBar(){
  var h = '';
  META.forEach(function(m){
    var k = m.kind === 'official' ? 'k-official' : 'k-community';
    var kt = m.kind === 'official' ? '官方' : '社区';
    h += '<button class="vtab' + (m.slug === CUR ? ' on' : '') + '" role="tab" '
      + 'aria-selected="' + (m.slug === CUR) + '" data-v="' + m.slug + '">'
      + '<span class="vn">' + esc2(m.name) + '</span>'
      + '<span class="vv">' + esc2(m.ver) + '</span>'
      + '<span class="vk ' + k + '">' + kt + '</span></button>';
  });
  document.getElementById('vbar').innerHTML = h;
  document.querySelectorAll('.vtab').forEach(function(b){
    b.onclick = function(){ pick(b.getAttribute('data-v')); };
  });
  var m = META.filter(function(x){ return x.slug === CUR; })[0];
  if(m){
    document.getElementById('vnote').innerHTML =
      '<span><b>' + esc2(m.name + ' ' + m.ver) + '</b> · '
      + m.tables + ' 张表 · ' + m.rows.toLocaleString() + ' 行</span>'
      + '<span class="' + (m.kind === 'official' ? '' : 'warn') + '">'
      + esc2(m.note) + '</span>'
      + '<a class="zip" href="data/zip/' + m.slug + '.zip" download>'
      + '⤓ 整个区服打包下载 ZIP · ' + (m.zip / 1048576).toFixed(1) + ' MB</a>';
  }
}
function pick(slug){
  if(slug === CUR && DATA) return;
  CUR = slug;
  paintBar();
  DATA = null; cur = 0; q = '';
  var qi = document.getElementById('q'); if(qi) qi.value = '';
  document.getElementById('tl').innerHTML = '';
  document.getElementById('tn').textContent = '载入中…';
  document.getElementById('ti').textContent = '';
  document.getElementById('sh').textContent = '—';
  document.getElementById('tw').innerHTML =
    '<div class="cfg-load"><div class="sp"></div><div>正在载入配置表…</div></div>';
  load(slug);
}
function load(slug){
  if(window.__CFG__ && window.__CFG__[slug]){ ready(window.__CFG__[slug]); return; }
  var s = document.createElement('script');
  s.src = 'data/cfg-' + slug + '.js';
  s.onload = function(){
    if(window.__CFG__ && window.__CFG__[slug]) ready(window.__CFG__[slug]);
    else fail('数据文件为空');
  };
  s.onerror = function(){ fail('数据文件载入失败'); };
  document.head.appendChild(s);
}
function fail(msg){
  document.getElementById('tw').innerHTML =
    '<div class="cfg-load">' + esc2(msg) + '</div>';
  document.getElementById('tn').textContent = '载入失败';
}
function ready(d){
  DATA = d;
  var toc = '';
  DATA.forEach(function(t, i){
    toc += '<button class="titem" data-i="' + i + '">'
      + '<span class="tn">' + esc2(t.n) + '</span>'
      + '<span class="tc">' + t.d.length.toLocaleString() + '</span></button>';
  });
  document.getElementById('tl').innerHTML = toc;
  document.getElementById('sh').textContent = '共 ' + DATA.length + ' 张表';
  document.querySelectorAll('.titem').forEach(function(e){
    e.onclick = function(){ sel(parseInt(e.getAttribute('data-i'), 10)); };
  });
  var tq = document.getElementById('tq');
  tq.value = '';
  tq.oninput = function(){
    var k = tq.value.trim().toLowerCase();
    document.querySelectorAll('.titem').forEach(function(e){
      var t = e.querySelector('.tn').textContent.toLowerCase();
      e.classList.toggle('hide', !!k && t.indexOf(k) === -1);
    });
  };
  sel(0);
}
function sel(i){
  cur = i; q = '';
  var qi = document.getElementById('q'); if(qi) qi.value = '';
  document.querySelectorAll('.titem').forEach(function(e,j){
    e.classList.toggle('on', j === i);
  });
  var t = DATA[i];
  document.getElementById('tn').textContent = t.n;
  document.getElementById('ti').textContent = t.f.length + ' 列 · '
    + t.d.length.toLocaleString() + ' 行';
  render();
}
var VIEW = null, seq = 0;
function render(){
  var t = DATA[cur];
  var kws = q.trim() ? q.trim().split(/\\s+/).filter(Boolean) : [];
  var rows = t.d;
  if(kws.length){
    rows = rows.filter(function(r){
      var s = r.join('\\u0001').toLowerCase();
      return kws.every(function(k){ return s.indexOf(k.toLowerCase()) !== -1; });
    });
  }
  VIEW = {t: t, rows: rows, kws: kws};
  document.getElementById('stat').textContent = kws.length
    ? ('匹配 ' + rows.length.toLocaleString() + ' / '
       + t.d.length.toLocaleString() + ' 行')
    : (rows.length.toLocaleString() + ' 行');
  document.getElementById('dl').hidden = !rows.length;
  document.getElementById('dlcsv').textContent =
    '⤓ CSV' + (kws.length ? '（筛选后 ' + rows.length.toLocaleString() + ' 行）' : '');
  var wrap = document.getElementById('tw');
  var head = '<table><thead><tr><th>#</th>';
  t.f.forEach(function(c){ head += '<th>' + esc2(c) + '</th>'; });
  head += '</tr></thead>';
  if(!rows.length){
    wrap.innerHTML = head + '</table><div class="empty">' + (kws.length
      ? '没有匹配的行，试试别的关键词'
      : '这张表在客户端里只有表头，没有数据') + '</div>';
    return;
  }
  wrap.innerHTML = head + '<tbody id="tb"></tbody></table>'
    + '<div class="prog" id="prog" hidden></div>';
  var tb = document.getElementById('tb'), prog = document.getElementById('prog');
  var CH = 500, i = 0, mine = ++seq;
  (function chunk(){
    if(mine !== seq) return;                       // 已被新的渲染取代
    var end = Math.min(i + CH, rows.length), buf = [];
    for(; i < end; i++){
      var r = rows[i];
      buf.push('<tr><td class="idx">' + (i + 1) + '</td>');
      for(var j = 0; j < t.f.length; j++){
        buf.push('<td>' + hl(r[j], kws) + '</td>');
      }
      buf.push('</tr>');
    }
    tb.insertAdjacentHTML('beforeend', buf.join(''));
    if(i < rows.length){
      prog.hidden = false;
      prog.textContent = '正在渲染 ' + i.toLocaleString() + ' / '
        + rows.length.toLocaleString() + ' 行…';
      requestAnimationFrame(chunk);
    } else {
      prog.hidden = true;
    }
  })();
}
function curName(){
  var m = META.filter(function(x){ return x.slug === CUR; })[0];
  return m ? (m.name + m.ver) : CUR;
}
function dlFile(name, text, mime){
  var blob = new Blob([text], {type: mime});
  var u = URL.createObjectURL(blob);
  var a = document.createElement('a');
  a.href = u; a.download = name; a.style.display = 'none';
  document.body.appendChild(a); a.click();
  setTimeout(function(){
    URL.revokeObjectURL(u);
    if(a.parentNode) a.parentNode.removeChild(a);
  }, 1500);
}
function csvCell(c){
  c = (c == null ? '' : String(c));
  return /[",\\r\\n]/.test(c) ? '"' + c.replace(/"/g, '""') + '"' : c;
}
function doCSV(){
  if(!VIEW) return;
  var t = VIEW.t, out = [t.f].concat(VIEW.rows), s = [];
  for(var i = 0; i < out.length; i++){
    var r = out[i], line = [];
    for(var j = 0; j < t.f.length; j++){ line.push(csvCell(r[j])); }
    s.push(line.join(','));
  }
  dlFile(curName() + '_' + t.n + '.csv',
         '\\ufeff' + s.join('\\r\\n') + '\\r\\n', 'text/csv;charset=utf-8');
}
function doJSON(){
  if(!VIEW) return;
  var t = VIEW.t;
  var objs = VIEW.rows.map(function(r){
    var o = {};
    t.f.forEach(function(k, j){ o[k || ('col' + (j + 1))] = r[j]; });
    return o;
  });
  dlFile(curName() + '_' + t.n + '.json',
         JSON.stringify({区服: curName(), 表: t.n, 列: t.f,
                         行数: objs.length, 数据: objs}, null, 2),
         'application/json;charset=utf-8');
}
(function(){
  var qi = document.getElementById('q');
  qi.addEventListener('input', function(){
    q = qi.value;
    clearTimeout(window._t);
    window._t = setTimeout(render, 160);
  });
  document.getElementById('clr').onclick = function(){
    qi.value = ''; q = ''; render(); qi.focus();
  };
  document.getElementById('dlcsv').onclick = doCSV;
  document.getElementById('dljson').onclick = doJSON;
  pick(META[0].slug);
})();
</script>
'''

    body = body.replace('__META__', json.dumps(meta, ensure_ascii=False,
                                               separators=(',', ':')))

    meta_html = ('<b>配置表</b>：%d 个区服 · 共 %d 张表 · %s 行 · 全部由客户端解密<br>'
                 '<b>用法</b>：顶部切换区服 · 左侧选表 · 右侧搜索（支持多关键词）· '
                 '表内可导出 CSV / JSON · 版本栏可打包下载整个区服'
                 % (len(meta), total_t, '{:,}'.format(total_r)))
    html = page('config.html', '配置表', "WITCH'S WEAPON / CONFIG",
                'CONFIG · %d REGIONS · %d TABLES' % (len(meta), total_t),
                meta_html, body, tools)
    p = os.path.join(SITE, 'config.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  config.html  %s  (%d 区服, %d 表, %s 行)'
          % (fmt(os.path.getsize(p)), len(meta), total_t, '{:,}'.format(total_r)))


build()
