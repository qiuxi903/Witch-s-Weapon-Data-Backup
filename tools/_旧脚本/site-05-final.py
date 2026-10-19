# 构建网站最后 3 页：系统设计 / 开发遗迹 / 全部文件
import io, os, sys, json, re, csv
from collections import defaultdict, OrderedDict, Counter

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
SITE = os.path.join(R, '网站')
ASSETS = json.load(io.open(os.path.join(R, 'tools', '_asset_index.json'), encoding='utf-8'))

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

# ============================================================
# 系统设计
# ============================================================
def build_system():
    LUA = os.path.join(R, '10_Lua脚本')
    scripts = {}
    for dp, dn, fn in os.walk(LUA):
        for f in fn:
            if f.endswith('.lua'):
                scripts[f] = io.open(os.path.join(dp, f), encoding='utf-8', errors='replace').read()

    # 活动类型（宽松匹配：注释可选）
    act = []
    src = scripts.get('ActivityModel.lua', '')
    if src:
        for m in re.finditer(r'(?:--\s*([^\n]+?)\s*\n\s*)?(\w+)\s*=\s*\{([^{}]*?typeid\s*=\s*(\d+)[^{}]*?)\}', src, re.S):
            note = (m.group(1) or '').strip()
            name = m.group(2)
            body = m.group(3)
            tid = m.group(4)
            mid = re.search(r'msgid\s*=\s*(\d+)', body)
            act.append((tid, note or name, name, mid.group(1) if mid else ''))
        # 去重（按 typeid）
        seen = set(); uniq = []
        for a in act:
            if a[0] in seen: continue
            seen.add(a[0]); uniq.append(a)
        act = sorted(uniq, key=lambda x: int(x[0]))

    # dump.cs 类
    DUMP = os.path.join(R, '02_客户端解包', '国服DLL', 'Il2CppDump', 'dump.cs')
    classes = []
    if os.path.exists(DUMP):
        pat = re.compile(r'^(?:public|internal|private)?\s*(?:sealed\s+|abstract\s+|static\s+)*class\s+(\w+)\s*(?::\s*([\w<>, .]+))?', re.M)
        seen = set()
        with io.open(DUMP, encoding='utf-8', errors='replace') as f:
            for line in f:
                m = pat.match(line)
                if m and m.group(1) not in seen:
                    seen.add(m.group(1))
                    classes.append((m.group(1), (m.group(2) or '').strip()))
    KEY = ['Servant', 'Weapon', 'Instance', 'Battle', 'Activity', 'Shop', 'Guild',
           'Lottery', 'Gacha', 'Item', 'Player', 'Story', 'Skill', 'Buff', 'Rank']
    keycls = [c for c in classes if any(k.lower() in c[0].lower() for k in KEY)]

    act_rows = ''.join('<tr><td class="idx">%s</td><td>%s</td><td class="mono">%s</td>'
                       '<td class="dim">%s</td></tr>' % (esc(a[0]), esc(a[1]), esc(a[2]), esc(a[3]))
                       for a in act)
    ui = sorted(f for f in scripts if f.lower().startswith('uiactivities'))
    ui_rows = ''.join('<tr><td class="mono">%s</td><td class="idx">%s</td></tr>'
                      % (esc(f[:-4]), '{:,}'.format(len(scripts[f]))) for f in ui)
    pt = sorted(f for f in scripts if f.lower().endswith('patch.lua'))
    pt_rows = ''.join('<tr><td class="mono">%s</td><td class="idx">%s</td></tr>'
                      % (esc(f[:-4]), '{:,}'.format(len(scripts[f]))) for f in pt)
    cls_rows = ''.join('<tr><td class="mono">%s</td><td class="dim">%s</td></tr>'
                       % (esc(c[0]), esc(c[1][:60])) for c in keycls[:400])

    body = '''<section>
<h2 class="bar">概览</h2>
<div class="cnt">还原自客户端 Lua 脚本 + IL2CPP 反编译</div>
<div class="kpis">
<div class="kpi"><div class="v">%d</div><div class="k">Lua 脚本</div></div>
<div class="kpi"><div class="v">%d</div><div class="k">活动类型</div></div>
<div class="kpi"><div class="v">%d</div><div class="k">UI 界面</div></div>
<div class="kpi"><div class="v">%d</div><div class="k">热更新补丁</div></div>
<div class="kpi"><div class="v">%s</div><div class="k">程序集类</div></div>
<div class="kpi"><div class="v">%s</div><div class="k">关键系统类</div></div>
</div></section>

<section>
<h2 class="bar">活动系统</h2>
<div class="cnt">ActivityModel.lua · 活动类型枚举</div>
<div class="note">游戏用 <b>typeid</b> 区分活动玩法，<b>msgid</b> 关联协议消息 ——
这是运营活动的核心分发表。</div>
<div class="scroll"><table>
<thead><tr><th>typeid</th><th>说明</th><th>枚举名</th><th>msgid</th></tr></thead>
<tbody>%s</tbody></table></div></section>

<section>
<h2 class="bar">UI 界面架构</h2>
<div class="cnt">UIActivities*.lua · %d 个界面脚本</div>
<div class="scroll"><table>
<thead><tr><th>脚本</th><th>字节数</th></tr></thead>
<tbody>%s</tbody></table></div></section>

<section>
<h2 class="bar">热更新补丁</h2>
<div class="cnt">*Patch.lua · %d 个补丁</div>
<div class="note">游戏采用 <b>Lua 热更新</b>架构 —— 线上问题通过下发 Patch 覆盖原逻辑，
无需重新发版。这些补丁记录了运营期间实际修过的 bug。</div>
<div class="scroll"><table>
<thead><tr><th>补丁</th><th>字节数</th></tr></thead>
<tbody>%s</tbody></table></div></section>

<section>
<h2 class="bar">核心系统类</h2>
<div class="cnt">dump.cs · 含 Servant/Weapon/Instance/Battle 等关键词的类（前 400）</div>
<div class="scroll"><table>
<thead><tr><th>类名</th><th>基类</th></tr></thead>
<tbody>%s</tbody></table></div></section>''' % (
        len(scripts), len(act), len(ui), len(pt),
        '{:,}'.format(len(classes)), '{:,}'.format(len(keycls)),
        act_rows, len(ui), ui_rows, len(pt), pt_rows, cls_rows)

    meta = ('<b>系统设计</b>：从 Lua 脚本 + IL2CPP dump 还原<br>'
            '<b>内容</b>：%d 活动类型 · %s 程序集类 · %d 热更新补丁'
            ) % (len(act), '{:,}'.format(len(classes)), len(pt))
    W('system.html', page('system.html', '系统设计', 'WITCH\'S WEAPON / SYSTEM DESIGN',
                          'SYSTEM DESIGN · REVERSE ENGINEERED', meta, body))

build_system()

# ============================================================
# 开发遗迹
# ============================================================
def build_relics():
    # 未上线剧情
    ND = os.path.join(R, '04_剧情文本', '怀旧服v128_未上线剧情')
    neweps = []
    if os.path.isdir(ND):
        for f in sorted(os.listdir(ND)):
            if f.endswith('.txt'):
                c = io.open(os.path.join(ND, f), encoding='utf-8', errors='replace').read()
                lines = [l for l in c.split('\n') if l.strip()]
                first = ''
                for l in lines:
                    p = l.split('\t')
                    if len(p) >= 3 and p[2].strip():
                        first = p[2].strip(); break
                neweps.append((f[:-4], len(lines), len(c), first))

    # 废弃资源
    CFG = os.path.join(R, '03_配置表', '怀旧服v128')
    nouse = []
    sp = os.path.join(CFG, 'sound.csv')
    if os.path.exists(sp):
        rows = list(csv.reader(io.open(sp, encoding='utf-8', errors='replace')))
        for r in rows[3:]:
            if len(r) >= 2 and r[1].strip().startswith('!NO_USE!'):
                nouse.append((r[0].strip(), os.path.basename(r[1].strip().replace('\\','/')),
                              r[9].strip() if len(r) > 9 else ''))

    # 保留场景
    maps = []
    for a in ASSETS:
        if 'preserved_stage' in a['p'].lower() or '保留场景' in a['p']:
            maps.append(a['p'])

    # 注释
    notes = []
    dp = os.path.join(CFG, 'dictionarystatic.csv')
    if os.path.exists(dp):
        for l in io.open(dp, encoding='utf-8', errors='replace'):
            r = l.rstrip('\n').split('\t')
            if len(r) >= 2 and r[0].strip().startswith('/*****'):
                notes.append((r[0].strip(), r[1].strip()))

    ep = ''.join('<article class="card" style="cursor:default"><div class="body">'
                 '<div class="ttl">%s</div><div class="sub">%d 行 · %s</div>'
                 '<div style="font-size:13px;color:#b9bfc9;margin-top:8px">%s</div>'
                 '</div></article>' % (esc(e[0]), e[1], fmt(e[2]), esc(e[3][:170])) for e in neweps)

    nu = ''.join('<tr><td class="idx">%s</td><td class="mono">%s</td><td class="dim">%s</td></tr>'
                 % (esc(a), esc(b), esc(c)) for a, b, c in nouse)
    nt = ''.join('<tr><td class="mono">%s</td><td>%s</td></tr>' % (esc(a), esc(b)) for a, b in notes)

    body = '''<section>
<h2 class="bar">未上线剧情</h2>
<div class="cnt">国服 lesson 目录止于 sentence_30318 · 以下来自怀旧服 v128</div>
<div class="note">这些剧情在国服正式版中<b>从未上线</b>，仅存在于怀旧服客户端。</div>
<div class="grid g2">%s</div></section>

<section>
<h2 class="bar">官方废弃资源</h2>
<div class="cnt">sound.csv 中 <code>!NO_USE!</code> 前缀 · %d 条</div>
<div class="note">开发组<b>自己标记</b>为废弃的音频资源 —— 保留了但不再使用。</div>
<div class="scroll"><table>
<thead><tr><th>ID</th><th>资源名</th><th>描述</th></tr></thead>
<tbody>%s</tbody></table></div></section>

<section>
<h2 class="bar">配置表注释行</h2>
<div class="cnt">dictionarystatic 中 <code>/*****</code> 分隔注释 · %d 条</div>
<div class="scroll"><table>
<thead><tr><th>tag</th><th>内容</th></tr></thead>
<tbody>%s</tbody></table></div></section>''' % ('\n'.join(ep), len(nouse), nu, len(notes), nt)

    meta = ('<b>开发遗迹</b>：未上线剧情 %d 个 · 废弃资源 %d 条 · 注释 %d 条<br>'
            '<b>价值</b>：记录了开发过程中被砍掉的内容') % (len(neweps), len(nouse), len(notes))
    W('relics.html', page('relics.html', '开发遗迹', 'WITCH\'S WEAPON / DEVELOPMENT RELICS',
                          'DEVELOPMENT RELICS · CUT CONTENT', meta, body))

build_relics()

json.dump(written, io.open(os.path.join(SITE, '_written4.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
print('已写 %d 页' % len(written))
