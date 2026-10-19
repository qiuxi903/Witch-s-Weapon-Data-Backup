# 重建官网公告 / 系统设计 / 开发遗迹 / 全部文件
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

# ============================================================
# 官网公告
# ============================================================
def build_news():
    D = os.path.join(R, '11_官网公告')
    idx = json.load(io.open(os.path.join(D, '_index.json'), encoding='utf-8'))
    items = []
    for x in sorted(idx, key=lambda y: y['id'], reverse=True):
        tf = os.path.join(D, 'info_%d.txt' % x['id'])
        body = io.open(tf, encoding='utf-8', errors='replace').read() if os.path.exists(tf) else ''
        parts = body.split('\n\n', 1)
        content = parts[1] if len(parts) > 1 else body
        content = re.sub(r'\n{3,}', '\n\n', content).strip()
        items.append('''<article class="card" data-t="%s %s">
<div class="body">
  <div class="sub">#%d · %s</div>
  <div class="ttl" style="font-size:14.5px">%s</div>
  <div class="newbody">%s</div>
</div></article>''' % (esc(x['title']), esc(content[:400]), x['id'], esc(x['date']),
                       esc(x['title']), esc(content[:2400]).replace('\n', '<br>')))

    tools = ('<div class="tools"><div class="tools-in">'
             '<label class="sr-only" for="q">搜索公告</label>'
             '<input id="q" type="search" placeholder="搜索公告标题或正文…">'
             '<button type="button" id="clr">清除</button>'
             '<span class="stat" id="stat"></span></div></div>')

    body = ('<section><h2 class="sec">官网公告</h2>'
            '<div class="cnt">%d 条 · 2018-12-27 ~ 2019-11 · 日文原文</div>'
            '<div class="note">完整记录了日服从 <b>官网开张 → CBT → 正式上线</b> 的全过程。'
            '官网 ID 空间 29 ~ 2047，大部分已 404，这 %d 条是仍在线部分。</div>'
            '<div class="grid g2">%s</div></section>'
            % (len(items), len(items), '\n'.join(items)))

    extra = '''
<style>
.newbody{font-size:12.5px;color:var(--text-3);max-height:300px;overflow:auto;
  margin-top:9px;line-height:1.85;padding-right:6px}
</style>'''

    meta = ('<b>官网公告</b>：%d 条日文原文<br>'
            '<b>跨度</b>：2018-12-27 ~ 2019-11 · 记录日服从开站到上线' % len(items))
    html = page('news.html', '官网公告', "WITCH'S WEAPON / OFFICIAL NEWS",
                'OFFICIAL NEWS · %d POSTS' % len(items), meta, body, tools)
    html = html.replace('</head>', extra + '\n</head>')
    html = html.replace('<script src="js/app.js"></script>',
                        '<script src="js/app.js"></script>\n'
                        '<script>bindFilter("q",".card","stat","data-t");'
                        'document.getElementById("clr").onclick=function(){'
                        'var i=document.getElementById("q");i.value="";'
                        'i.dispatchEvent(new Event("input"));i.focus();};</script>')
    W('news.html', html)

build_news()

# ============================================================
# 系统设计
# ============================================================
def build_system():
    LUA = os.path.join(R, '10_Lua脚本')
    scripts = {}
    for dp, dn, fn in os.walk(LUA):
        for f in fn:
            if f.endswith('.lua'):
                scripts[f] = io.open(os.path.join(dp, f), encoding='utf-8',
                                      errors='replace').read()

    act = []
    src = scripts.get('ActivityModel.lua', '')
    if src:
        for m in re.finditer(
                r'(?:--\s*([^\n]+?)\s*\n\s*)?(\w+)\s*=\s*\{([^{}]*?typeid\s*=\s*(\d+)[^{}]*?)\}',
                src, re.S):
            note = (m.group(1) or '').strip()
            name, body, tid = m.group(2), m.group(3), m.group(4)
            mid = re.search(r'msgid\s*=\s*(\d+)', body)
            act.append((tid, note or name, name, mid.group(1) if mid else ''))
        seen = set(); uniq = []
        for a in act:
            if a[0] in seen: continue
            seen.add(a[0]); uniq.append(a)
        act = sorted(uniq, key=lambda x: int(x[0]))

    classes = []
    DUMP = os.path.join(R, '02_客户端解包', '国服DLL', 'Il2CppDump', 'dump.cs')
    if os.path.exists(DUMP):
        pat = re.compile(r'^(?:public|internal|private)?\s*'
                         r'(?:sealed\s+|abstract\s+|static\s+)*class\s+(\w+)'
                         r'\s*(?::\s*([\w<>, .]+))?', re.M)
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
                       '<td class="dim">%s</td></tr>'
                       % (esc(a[0]), esc(a[1]), esc(a[2]), esc(a[3])) for a in act)
    ui = sorted(f for f in scripts if f.lower().startswith('uiactivities'))
    ui_rows = ''.join('<tr><td class="mono">%s</td><td class="idx">%s</td></tr>'
                      % (esc(f[:-4]), '{:,}'.format(len(scripts[f]))) for f in ui)
    pt = sorted(f for f in scripts if f.lower().endswith('patch.lua'))
    pt_rows = ''.join('<tr><td class="mono">%s</td><td class="idx">%s</td></tr>'
                      % (esc(f[:-4]), '{:,}'.format(len(scripts[f]))) for f in pt)
    cls_rows = ''.join('<tr><td class="mono">%s</td><td class="dim">%s</td></tr>'
                       % (esc(c[0]), esc(c[1][:60])) for c in keycls[:400])

    body = '''<section>
<h2 class="sec">概览</h2>
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
<h2 class="sec">活动系统</h2>
<div class="cnt">ActivityModel.lua · 活���类型枚举</div>
<div class="note">游戏用 <b>typeid</b> 区分活动玩法，<b>msgid</b> 关联协议消息 ——
这是运营活动的核心分发表。</div>
<div class="tbl-wrap"><table>
<thead><tr><th>typeid</th><th>说明</th><th>枚举名</th><th>msgid</th></tr></thead>
<tbody>%s</tbody></table></div></section>

<section>
<h2 class="sec">UI 界面架构</h2>
<div class="cnt">UIActivities*.lua · %d 个界面脚本</div>
<div class="tbl-wrap"><table>
<thead><tr><th>脚本</th><th>字节数</th></tr></thead>
<tbody>%s</tbody></table></div></section>

<section>
<h2 class="sec">热更新补丁</h2>
<div class="cnt">*Patch.lua · %d 个补丁</div>
<div class="note">游戏采用 <b>Lua 热更新</b>架构 —— 线上问题通过下发 Patch 覆盖原逻辑，
无需重新发版。这些补丁记录了运营期间实际修过的 bug。</div>
<div class="tbl-wrap"><table>
<thead><tr><th>补丁</th><th>字节数</th></tr></thead>
<tbody>%s</tbody></table></div></section>

<section>
<h2 class="sec">核心系统类</h2>
<div class="cnt">dump.cs · 含 Servant/Weapon/Instance/Battle 等关键词的类（前 400）</div>
<div class="tbl-wrap"><table>
<thead><tr><th>类名</th><th>基类</th></tr></thead>
<tbody>%s</tbody></table></div></section>''' % (
        len(scripts), len(act), len(ui), len(pt),
        '{:,}'.format(len(classes)), '{:,}'.format(len(keycls)),
        act_rows, len(ui), ui_rows, len(pt), pt_rows, cls_rows)

    meta = ('<b>系统设计</b>：从 Lua 脚本 + IL2CPP dump 还原<br>'
            '<b>内容</b>：%d 活动类型 · %s 程序集类 · %d 热更新补丁'
            % (len(act), '{:,}'.format(len(classes)), len(pt)))
    W('system.html', page('system.html', '系统设计', "WITCH'S WEAPON / SYSTEM DESIGN",
                          'SYSTEM DESIGN · REVERSE ENGINEERED', meta, body))

build_system()

# ============================================================
# 开发遗迹
# ============================================================
def build_relics():
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

    CFG = os.path.join(R, '03_配置表', '怀旧服v128')
    nouse = []
    sp = os.path.join(CFG, 'sound.csv')
    if os.path.exists(sp):
        rows = list(csv.reader(io.open(sp, encoding='utf-8', errors='replace')))
        for r in rows[3:]:
            if len(r) >= 2 and r[1].strip().startswith('!NO_USE!'):
                nouse.append((r[0].strip(),
                              os.path.basename(r[1].strip().replace('\\', '/')),
                              r[9].strip() if len(r) > 9 else ''))

    notes = []
    dp = os.path.join(CFG, 'dictionarystatic.csv')
    if os.path.exists(dp):
        for l in io.open(dp, encoding='utf-8', errors='replace'):
            r = l.rstrip('\n').split('\t')
            if len(r) >= 2 and r[0].strip().startswith('/*****'):
                notes.append((r[0].strip(), r[1].strip()))

    ep = ''.join('<article class="card"><div class="body">'
                 '<div class="ttl">%s</div><div class="sub">%d 行 · %s</div>'
                 '<div style="font-size:13px;color:var(--text-3);margin-top:9px">%s</div>'
                 '</div></article>'
                 % (esc(e[0]), e[1], fmt(e[2]), esc(e[3][:170])) for e in neweps)

    nu = ''.join('<tr><td class="idx">%s</td><td class="mono">%s</td>'
                 '<td class="dim">%s</td></tr>' % (esc(a), esc(b), esc(c))
                 for a, b, c in nouse)
    nt = ''.join('<tr><td class="mono">%s</td><td>%s</td></tr>' % (esc(a), esc(b))
                 for a, b in notes)

    body = '''<section>
<h2 class="sec">未上线剧情</h2>
<div class="cnt">国服 lesson 目录止于 sentence_30318 · 以下来自怀旧服 v128</div>
<div class="note">这些剧情在国服正式版中<b>从未上线</b>，仅存在于怀旧服客户端。</div>
<div class="grid g2">%s</div></section>

<section>
<h2 class="sec">官方废弃资源</h2>
<div class="cnt">sound.csv 中 <code>!NO_USE!</code> 前缀 · %d 条</div>
<div class="note">开发组<b>自己标记</b>为废弃的音频资源 —— 保留了但不再使用。</div>
<div class="tbl-wrap"><table>
<thead><tr><th>ID</th><th>资源名</th><th>描述</th></tr></thead>
<tbody>%s</tbody></table></div></section>

<section>
<h2 class="sec">配置表注释行</h2>
<div class="cnt">dictionarystatic 中 <code>/*****</code> 分隔注释 · %d 条</div>
<div class="tbl-wrap"><table>
<thead><tr><th>tag</th><th>内容</th></tr></thead>
<tbody>%s</tbody></table></div></section>''' % ('\n'.join(ep), len(nouse), nu, len(notes), nt)

    meta = ('<b>开发遗迹</b>：未上线剧情 %d 个 · 废弃资源 %d 条 · 注释 %d 条<br>'
            '<b>价值</b>：记录了开发过程中被砍掉的内容'
            % (len(neweps), len(nouse), len(notes)))
    W('relics.html', page('relics.html', '开发遗迹', "WITCH'S WEAPON / DEVELOPMENT RELICS",
                          'DEVELOPMENT RELICS · CUT CONTENT', meta, body))

build_relics()

# ============================================================
# 全部文件
# ============================================================
def build_archive():
    tops = defaultdict(list)
    for a in ASSETS:
        tops[a['t']].append(a)

    TOPNAME = {
        '01_安装包': '安装包', '02_客户端解包': '客户端解包', '03_配置表': '配置表',
        '04_剧情文本': '剧情文本', '05_剧情表格': '剧情表格', '06_美术素材': '美术素材',
        '07_音频资源': '音频资源', '08_视频资源': '视频资源', '09_着色器': '着色器',
        '10_Lua脚本': 'Lua 脚本', '11_官网公告': '官网公告', 'assets': '网站素材',
        '.': '根目录文档', '音乐原声': '音乐原声',
    }
    KINDNAME = {'image': '图片', 'audio': '音频', 'video': '视频', 'doc': '文档',
                'code': '代码', 'package': '安装包', 'other': '其它'}

    rows = []
    for a in sorted(ASSETS, key=lambda x: x['p']):
        rows.append('<tr data-t="%s"><td class="mono">%s</td><td class="idx">%s</td>'
                    '<td class="idx">%s</td><td class="dim">%s</td></tr>'
                    % (esc(a['p'].lower()), esc(a['p']),
                       KINDNAME.get(a['k'], '其它'), fmt(a['b']), esc(a['t'])))

    ov = []
    for t, items in sorted(tops.items(), key=lambda x: -sum(a['b'] for a in x[1])):
        sz = sum(a['b'] for a in items)
        kc = Counter(a['k'] for a in items)
        detail = ' · '.join('%s %d' % (KINDNAME.get(k, k), v) for k, v in kc.most_common(4))
        ov.append('<tr><td class="mono">%s</td><td>%s</td><td class="idx">%d</td>'
                  '<td class="idx">%s</td><td class="dim">%s</td></tr>'
                  % (esc(t), esc(TOPNAME.get(t, t)), len(items), fmt(sz), esc(detail)))

    tools = ('<div class="tools"><div class="tools-in">'
             '<label class="sr-only" for="q">搜索文件路径</label>'
             '<input id="q" type="search" placeholder="搜索文件路径（多关键词空格分隔）…">'
             '<button type="button" id="clr">清除</button>'
             '<span class="stat" id="stat"></span></div></div>')

    body = '''<section>
<h2 class="sec">目录概览</h2>
<div class="cnt">%d 个文件 · %s</div>
<div class="tbl-wrap" style="max-height:none"><table>
<thead><tr><th>目录</th><th>说明</th><th>文件数</th><th>体积</th><th>构成</th></tr></thead>
<tbody>%s</tbody></table></div></section>

<section>
<h2 class="sec">全部文件索引</h2>
<div class="cnt">%d 个文件完整清单（不含隔离区与构建工具）</div>
<div class="note">这是本档案的<b>完整文件清单</b> —— 每一个提取出来的文件都在这里。
用上方搜索框可以按路径筛选。</div>
<div class="tbl-wrap" style="max-height:760px"><table id="tbl">
<thead><tr><th>路径</th><th>类型</th><th>大小</th><th>所属</th></tr></thead>
<tbody>%s</tbody></table></div></section>''' % (
        len(ASSETS), fmt(sum(a['b'] for a in ASSETS)), '\n'.join(ov),
        len(rows), '\n'.join(rows))

    meta = ('<b>全部文件</b>：%d 个文件 · %s<br>'
            '<b>说明</b>：本档案的完整清单，含所有提取出的资源'
            % (len(ASSETS), fmt(sum(a['b'] for a in ASSETS))))
    html = page('archive.html', '全部文件', "WITCH'S WEAPON / FILE INDEX",
                'COMPLETE FILE INDEX · %s FILES' % '{:,}'.format(len(ASSETS)),
                meta, body, tools)
    html = html.replace('<script src="js/app.js"></script>',
                        '<script src="js/app.js"></script>\n'
                        '<script>bindTable("q","tbl","stat");'
                        'document.getElementById("clr").onclick=function(){'
                        'var i=document.getElementById("q");i.value="";'
                        'i.dispatchEvent(new Event("input"));i.focus();};</script>')
    W('archive.html', html)

build_archive()

json.dump(written, io.open(os.path.join(SITE, '_w3.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
print('已写 %d 页' % len(written))
