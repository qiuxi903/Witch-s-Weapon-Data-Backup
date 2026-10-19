# 从 Lua + dump.cs 还原游戏系统设计文档
import io, os, sys, re, json
from collections import OrderedDict, Counter

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
LUA  = os.path.join(R, 'Lua脚本_整理')
DUMP = os.path.join(R, '提取资源', '国服DLL', 'Il2CppDump', 'dump.cs')
OUT  = os.path.join(R, '魔女兵器_系统设计文档.html')

# ---------- 1) 读全部 Lua ----------
scripts = {}
for dp, dn, fn in os.walk(LUA):
    for f in fn:
        if f.endswith('.lua'):
            p = os.path.join(dp, f)
            scripts[f] = io.open(p, encoding='utf-8', errors='replace').read()
print('Lua 脚本 %d 个' % len(scripts))

def grab(name):
    for k, v in scripts.items():
        if k.lower() == name.lower():
            return v
    return ''

# ---------- 2) 活动类型表 ----------
act_src = grab('ActivityModel.lua')
act_types = []
if act_src:
    # 匹配 --注释 \n Name = { typeid = N, msgid = M }
    for m in re.finditer(r'--\s*([^\n]+?)\s*\n\s*(\w+)\s*=\s*\{([^}]*)\}', act_src):
        note = m.group(1).strip()
        name = m.group(2)
        body = m.group(3)
        tid = re.search(r'typeid\s*=\s*(\d+)', body)
        mid = re.search(r'msgid\s*=\s*(\d+)', body)
        act_types.append({'note': note, 'name': name,
                          'typeid': tid.group(1) if tid else '',
                          'msgid': mid.group(1) if mid else ''})
print('活动类型 %d 种' % len(act_types))

# ---------- 3) UI 界面清单 ----------
ui_files = sorted(f for f in scripts if f.lower().startswith('uiactivities'))
print('UI 界面脚本 %d 个' % len(ui_files))

# ---------- 4) 补丁清单 ----------
patches = sorted(f for f in scripts if f.lower().endswith('patch.lua'))
print('补丁脚本 %d 个' % len(patches))

# ---------- 5) 从 dump.cs 抓关键类 ----------
classes = []
if os.path.exists(DUMP):
    print('dump.cs 存在 (%.1f MB), 扫描...' % (os.path.getsize(DUMP) / 1024 / 1024))
    pat = re.compile(r'^(?:public|internal|private)?\s*(?:sealed\s+|abstract\s+|static\s+)*class\s+(\w+)\s*(?::\s*([\w<>, .]+))?', re.M)
    seen = set()
    with io.open(DUMP, encoding='utf-8', errors='replace') as f:
        for line in f:
            m = pat.match(line)
            if m and m.group(1) not in seen:
                seen.add(m.group(1))
                classes.append({'name': m.group(1), 'base': (m.group(2) or '').strip()})
    print('  类 %d 个' % len(classes))

    # 关键系统类
    KEY = ['Servant', 'Weapon', 'Instance', 'Battle', 'Activity', 'Shop', 'Guild',
           'Lottery', 'Gacha', 'Item', 'Player', 'Story', 'Skill', 'Buff', 'Rank']
    keycls = [c for c in classes if any(k.lower() in c['name'].lower() for k in KEY)]
    print('  关键系统类 %d 个' % len(keycls))
else:
    keycls = []

# ---------- 6) 统计 ----------
stat = {
    'lua': len(scripts),
    'act_types': len(act_types),
    'ui': len(ui_files),
    'patches': len(patches),
    'classes': len(classes),
    'keycls': len(keycls),
}

def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')

# 活动类型表
act_rows = ''.join('<tr><td class="idx">%s</td><td>%s</td><td class="mono">%s</td><td class="mono">%s</td></tr>'
                   % (esc(a['typeid']), esc(a['note']), esc(a['name']), esc(a['msgid']))
                   for a in act_types)

# UI 清单
ui_rows = ''.join('<tr><td class="mono">%s</td><td class="idx">%s</td></tr>'
                  % (esc(f[:-4]), '{:,}'.format(len(scripts[f]))) for f in ui_files)

# 补丁清单
pt_rows = ''.join('<tr><td class="mono">%s</td><td class="idx">%s</td></tr>'
                  % (esc(f[:-4]), '{:,}'.format(len(scripts[f]))) for f in patches)

# 关键类
cls_rows = ''.join('<tr><td class="mono">%s</td><td class="dim">%s</td></tr>'
                   % (esc(c['name']), esc(c['base'][:60])) for c in keycls[:400])

html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》系统设计文档</title>
<style>
:root{--bg:#0f1116;--panel:#171a21;--line:#2a2f3a;--fg:#e6e3de;--dim:#8f96a3;
--accent:#c9a227;--accent2:#7fb3d5;--mono:ui-monospace,Consolas,monospace}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);line-height:1.8;
font-family:"Noto Sans SC","Microsoft YaHei",sans-serif}
header{padding:52px 48px 32px;border-bottom:1px solid var(--line);
background:linear-gradient(160deg,#1a1d26,#0f1116 70%)}
.eyebrow{font-size:11px;letter-spacing:.34em;color:var(--accent);margin-bottom:12px;font-family:var(--mono)}
h1{font-size:36px;margin:0 0 8px;letter-spacing:.08em;font-weight:600}
.en{font-size:11.5px;letter-spacing:.3em;color:var(--dim);margin-bottom:18px;font-family:var(--mono)}
.meta{font-size:13px;color:var(--dim);line-height:2}
.meta b{color:var(--fg)}
main{padding:32px 48px 80px;max-width:1400px}
section{margin-bottom:48px}
h2{font-size:22px;color:var(--accent);margin:0 0 4px;font-weight:600}
.cnt{font-size:11.5px;color:var(--dim);margin-bottom:18px;font-family:var(--mono)}
.cards{display:grid;grid-template-columns:repeat(auto-fill,minmax(180px,1fr));gap:12px;margin-bottom:24px}
.kpi{background:var(--panel);border:1px solid var(--line);border-radius:6px;padding:14px 16px}
.kpi .v{font-size:26px;color:var(--accent);font-family:var(--mono);font-weight:600;line-height:1.2}
.kpi .k{font-size:11.5px;color:var(--dim);font-family:var(--mono)}
table{border-collapse:collapse;width:100%;font-size:12.5px}
th,td{padding:6px 10px;border-bottom:1px solid var(--line);text-align:left;vertical-align:top}
th{background:#1c2029;color:var(--accent2);font-family:var(--mono);font-size:11.5px;
position:sticky;top:0}
td.idx{color:#5f6674;font-family:var(--mono);white-space:nowrap}
td.mono{font-family:var(--mono);color:#c3c8d1}
td.dim{color:#6b7484;font-family:var(--mono);font-size:11.5px}
tbody tr:hover{background:#1a1e27}
.scroll{max-height:560px;overflow:auto;border:1px solid var(--line);border-radius:6px}
.note{background:var(--panel);border-left:3px solid var(--accent);border-radius:5px;
padding:12px 16px;font-size:13px;color:#b9bfc9;margin-bottom:20px}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / SYSTEM DESIGN</div>
<h1>《魔女兵器》系统设计文档</h1>
<div class="en">SYSTEM DESIGN · REVERSE ENGINEERED</div>
<div class="meta">
<b>来源</b>：客户端 Lua 脚本（__LUA__ 个）+ IL2CPP 反编译 <code>dump.cs</code><br>
<b>内容</b>：活动系统 · UI 架构 · 热更新补丁 · 核心类结构<br>
<b>说明</b>：从运行时脚本与程序集还原，非官方文档
</div></header>
<main>
<div class="cards">
  <div class="kpi"><div class="v">__LUA__</div><div class="k">Lua 脚本</div></div>
  <div class="kpi"><div class="v">__ACT__</div><div class="k">活动类型</div></div>
  <div class="kpi"><div class="v">__UI__</div><div class="k">UI 界面</div></div>
  <div class="kpi"><div class="v">__PT__</div><div class="k">热更新补丁</div></div>
  <div class="kpi"><div class="v">__CLS__</div><div class="k">程序集类</div></div>
  <div class="kpi"><div class="v">__KEY__</div><div class="k">关键系统类</div></div>
</div>

<section>
<h2>活动系统</h2>
<div class="cnt">ActivityModel.lua · 活动类型枚举（typeid / msgid）</div>
<div class="note">
游戏用 <b>typeid</b> 区分活动玩法，<b>msgid</b> 关联协议消息。这是运营活动的核心分发表 ——
每个活动类型对应一套独立逻辑。
</div>
<div class="scroll"><table>
<thead><tr><th>typeid</th><th>说明</th><th>枚举名</th><th>msgid</th></tr></thead>
<tbody>__ACTROWS__</tbody></table></div>
</section>

<section>
<h2>UI 界面架构</h2>
<div class="cnt">UIActivities*.lua · __UI__ 个界面脚本</div>
<div class="scroll"><table>
<thead><tr><th>脚本</th><th>字节数</th></tr></thead>
<tbody>__UIROWS__</tbody></table></div>
</section>

<section>
<h2>热更新补丁</h2>
<div class="cnt">*Patch.lua · __PT__ 个补丁脚本</div>
<div class="note">
游戏采用 <b>Lua 热更新</b>架构 —— 线上问题通过下发 Patch 脚本覆盖原逻辑，
无需重新发版。这些补丁记录了运营期间实际修过的 bug。
</div>
<div class="scroll"><table>
<thead><tr><th>补丁</th><th>字节数</th></tr></thead>
<tbody>__PTROWS__</tbody></table></div>
</section>

<section>
<h2>核心系统类</h2>
<div class="cnt">dump.cs · 含 Servant/Weapon/Instance/Battle/Activity 等关键词的类（前 400）</div>
<div class="scroll"><table>
<thead><tr><th>类名</th><th>基类</th></tr></thead>
<tbody>__CLSROWS__</tbody></table></div>
</section>
</main>
<footer>
<b>《魔女兵器》系统设计文档</b><br>
还原自客户端 Lua + IL2CPP dump · 游戏开发：北京水琴铃（WaterBell）<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer></body></html>'''

html = (html.replace('__ACTROWS__', act_rows)
            .replace('__UIROWS__', ui_rows)
            .replace('__PTROWS__', pt_rows)
            .replace('__CLSROWS__', cls_rows)
            .replace('__LUA__', str(stat['lua']))
            .replace('__ACT__', str(stat['act_types']))
            .replace('__UI__', str(stat['ui']))
            .replace('__PT__', str(stat['patches']))
            .replace('__CLS__', '{:,}'.format(stat['classes']))
            .replace('__KEY__', '{:,}'.format(stat['keycls'])))
io.open(OUT, 'w', encoding='utf-8').write(html)
print()
print('已生成: %s (%.1f KB)' % (OUT, os.path.getsize(OUT) / 1024))
