# 游戏内文本全库（dictionarystatic 1,635 条 tag）
import io, os, sys, re, json
from collections import OrderedDict, Counter

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R   = r'G:\project\其他\game'
CFG = os.path.join(R, '配置表_解密版', '怀旧服v128')
OUT = os.path.join(R, '魔女兵器_游戏文本全库.html')

rows = [l.rstrip('\n').rstrip('\r').split('\t')
        for l in io.open(os.path.join(CFG, 'dictionarystatic.csv'), encoding='utf-8', errors='replace')]
items = []
for r in rows[2:]:
    if len(r) >= 6 and r[0].strip():
        items.append({'tag': r[0].strip(), 'zh': r[1], 'tw': r[2], 'jp': r[3],
                      'kr': r[4], 'en': r[5]})
print('dictionarystatic: %d 条' % len(items))

# 分类
def group(tag):
    t = tag.strip()
    if t.startswith('role'): return '角色名映射'
    if t.startswith('CE'): return '客户端文本 CE'
    if re.match(r'^E\d', t): return '错误码 E'
    if t.startswith('E'): return '文��� E'
    if t.startswith('Activity'): return '活动'
    if t.startswith('AP'): return '特别行动 AP'
    if t.startswith('GuildHelp'): return '公会帮助'
    if t.startswith('PreLoading'): return '加载提示'
    if t.startswith('RankingList'): return '排行榜'
    if t.startswith('Num_'): return '数字格式'
    if t.startswith('ClimbTower'): return '爬塔'
    if t.startswith('MapPanel'): return '地图面板'
    if t.startswith('DailyTrial'): return '日常试炼'
    if t.startswith('DailyTask'): return '日常任务'
    if t.startswith('Settlement'): return '结算'
    if t.startswith('GuaranteesRule'): return '保底规则'
    if t.startswith('Operate'): return '运营活动'
    if t.startswith('Homepage'): return '主页'
    if t.startswith('UI'): return '界面 UI'
    if t.startswith('/*****'): return '注释分隔'
    return '其它'

groups = OrderedDict()
for it in items:
    groups.setdefault(group(it['tag']), []).append(it)

print()
print('=== 分类 ===')
for k, v in sorted(groups.items(), key=lambda x: -len(x[1])):
    print('  %-14s %5d' % (k, len(v)))

# 有翻译内容的条数
trans = sum(1 for i in items if i['zh'].strip() or i['en'].strip())
print()
print('有文本内容: %d / %d' % (trans, len(items)))

def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')
def br(s):
    return esc(s).replace('\\n', '<br>').replace('\n', '<br>')

# 生成条目
blocks = []
for gname, gitems in sorted(groups.items(), key=lambda x: -len(x[1])):
    blocks.append('<section data-g="%s"><h2>%s</h2><div class="cnt">%d 条</div>'
                  % (esc(gname), esc(gname), len(gitems)))
    blocks.append('<div class="list">')
    for it in gitems:
        zh = it['zh'].strip()
        if not zh and not it['en'].strip():
            continue
        others = []
        for lbl, key in [('繁中','tw'), ('日','jp'), ('韩','kr'), ('英','en')]:
            v = it[key].strip()
            if v and v != zh:
                others.append('<div class="row"><b>%s</b> %s</div>' % (lbl, br(v)))
        more = ('<details class="more"><summary>其它语言 (%d)</summary>%s</details>'
                % (len(others), ''.join(others))) if others else ''
        blocks.append('<div class="item" data-t="%s">'
                      '<div class="tag">%s</div><div class="txt">%s</div>%s</div>'
                      % (esc((it['tag'] + ' ' + zh).lower()), esc(it['tag']), br(zh), more))
    blocks.append('</div></section>')

payload = json.dumps([{'g': k, 'n': len(v)} for k, v in groups.items()], ensure_ascii=False)

html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》游戏文本全库</title>
<style>
:root{--bg:#0f1116;--panel:#171a21;--panel2:#1e222b;--line:#2a2f3a;--fg:#e6e3de;
--dim:#8f96a3;--accent:#c9a227;--accent2:#7fb3d5}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);line-height:1.75;
font-family:"Noto Sans SC","Microsoft YaHei",sans-serif}
header{padding:52px 48px 30px;border-bottom:1px solid var(--line);
background:linear-gradient(160deg,#1a1d26,#0f1116 70%)}
.eyebrow{font-size:11px;letter-spacing:.34em;color:var(--accent);margin-bottom:12px;
font-family:ui-monospace,monospace}
h1{font-size:36px;margin:0 0 8px;letter-spacing:.08em;font-weight:600}
.en{font-size:11.5px;letter-spacing:.3em;color:var(--dim);margin-bottom:18px;
font-family:ui-monospace,monospace}
.meta{font-size:13px;color:var(--dim);line-height:2}
.meta b{color:var(--fg)}
.bar{display:flex;gap:12px;align-items:center;padding:11px 48px;border-bottom:1px solid var(--line);
background:var(--panel);position:sticky;top:0;z-index:6;flex-wrap:wrap}
.bar input{flex:1;min-width:200px;padding:8px 12px;background:var(--panel2);
border:1px solid var(--line);border-radius:4px;color:var(--fg);font-size:13px;outline:none}
.bar input:focus{border-color:var(--accent)}
.bar button{padding:6px 12px;background:var(--panel2);border:1px solid var(--line);
border-radius:4px;color:#c3c8d1;cursor:pointer;font-size:12px}
.bar button:hover{border-color:var(--accent);color:var(--fg)}
.bar .stat{font-size:11.5px;color:var(--dim);font-family:ui-monospace,monospace}
main{padding:30px 48px 80px;max-width:1400px}
section{margin-bottom:40px}
section>h2{font-size:20px;color:var(--accent);margin:0 0 3px;font-weight:600}
.cnt{font-size:11.5px;color:var(--dim);margin-bottom:14px;font-family:ui-monospace,monospace}
.list{display:grid;grid-template-columns:repeat(auto-fill,minmax(400px,1fr));gap:9px}
.item{background:var(--panel);border:1px solid var(--line);border-radius:5px;padding:10px 13px}
.item.hide{display:none}
.tag{font-size:10.5px;color:var(--accent2);font-family:ui-monospace,monospace;margin-bottom:4px}
.txt{font-size:13.5px;color:#ddd8d0}
.more{font-size:11px;color:#6b7484;font-family:ui-monospace,monospace;margin-top:6px}
.more summary{cursor:pointer;color:#7f8797;list-style:none}
.more summary::-webkit-details-marker{display:none}
.more summary:hover{color:var(--accent2)}
.more .row{margin:4px 0 0;padding-left:9px;border-left:2px solid var(--line);color:#8d94a2}
mark{background:#3a4a2a;color:#e8e6a0;border-radius:2px}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,.bar,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}.list{grid-template-columns:1fr}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / IN-GAME TEXT</div>
<h1>《魔女兵器》游戏文本全库</h1>
<div class="en">IN-GAME TEXT ARCHIVE · __N__ ENTRIES</div>
<div class="meta">
<b>来源</b>：配置表 <code>dictionarystatic.csv</code>（已解密）<br>
<b>规模</b>：__N__ 条 tag · __TRANS__ 条有文本 · 五语对照<br>
<b>内容</b>：界面文案 / 规则说明 / 帮助 / 错误码 / 活动 / 角色名映射
</div></header>
<div class="bar">
<input id="q" placeholder="搜索 tag 或文本内容（支持多关键词）...">
<button onclick="document.getElementById('q').value='';go('')">清除</button>
<span class="stat" id="stat"></span>
</div>
<main>__BODY__</main>
<footer>
<b>《魔女兵器》游戏文本全库</b><br>
配置表解密：XOR 0xFF · 游戏开发：北京水琴铃（WaterBell）<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer>
<script>
const ITEMS = [...document.querySelectorAll('.item')];
const SECS = [...document.querySelectorAll('section')];
function go(q){
  const kws = q.trim().toLowerCase().split(/\\s+/).filter(Boolean);
  let n = 0;
  ITEMS.forEach(el => {
    const t = el.getAttribute('data-t') || '';
    const ok = kws.every(k => t.includes(k));
    el.classList.toggle('hide', !ok);
    if (ok) n++;
  });
  SECS.forEach(s => {
    const vis = [...s.querySelectorAll('.item')].some(x => !x.classList.contains('hide'));
    s.style.display = vis ? '' : 'none';
  });
  document.getElementById('stat').textContent = kws.length ? ('匹配 ' + n + ' 条') : (ITEMS.length + ' 条');
}
let timer=null;
document.getElementById('q').oninput = e => {
  clearTimeout(timer);
  timer = setTimeout(() => go(e.target.value), 160);
};
go('');
</script></body></html>'''

html = (html.replace('__BODY__', '\n'.join(blocks))
            .replace('__N__', str(len(items)))
            .replace('__TRANS__', str(trans)))
io.open(OUT, 'w', encoding='utf-8').write(html)
print()
print('已生成: %s (%.2f MB)' % (OUT, os.path.getsize(OUT) / 1024 / 1024))
