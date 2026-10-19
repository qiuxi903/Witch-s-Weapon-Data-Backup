# 重建 系统设计 / 官网公告 / 开发遗迹 / 全部文件 v3
import io, os, sys, json, csv, re
from collections import defaultdict, Counter

sys.path.insert(0, r'G:\project\其他\game\tools')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from site_lib import (R, SITE, ASSETS, IMETA, page, U, T, esc, fmt, find_image)


def build_system():
    """系统设计：Lua 脚本 + dump.cs + 热更新补丁"""
    lua = [a for a in ASSETS if a['k'] == 'code' and a['p'].lower().endswith('.lua')]
    cs = [a for a in ASSETS if a['p'].lower().endswith('.cs')]
    patches = [a for a in ASSETS
               if 'patch' in a['p'].lower() or '热更' in a['p']]
    groups = defaultdict(list)
    for a in lua:
        parts = a['p'].split('/')
        groups[parts[1] if len(parts) > 2 else '其它'].append(a)

    kpis = [
        ('{:,}'.format(len(lua)), 'Lua 脚本'),
        ('{:,}'.format(len(cs)), 'C# 文件'),
        ('{:,}'.format(len(patches)), '热更��相关'),
        ('{:,}'.format(len(groups)), 'Lua 分类'),
    ]
    kpi_html = ''.join(
        '<div class="kpi"><div class="v">%s</div><div class="k">%s</div></div>'
        % (v, k) for v, k in kpis)

    rows = []
    for g in sorted(groups, key=lambda x: -len(groups[x]))[:40]:
        items = sorted(groups[g], key=lambda y: y['p'])
        for a in items[:8]:
            rows.append(
                '<tr><td>%s</td><td class="mono">%s</td><td class="mono">%s</td></tr>'
                % (esc(g), esc(os.path.basename(a['p'])), fmt(a['b'])))

    body = ('<section class="rv"><h2 class="sec">系统设计</h2>'
            '<div class="cnt">从客户端提取的脚本与补丁</div>'
            '<div class="kpis">%s</div></section>'
            '<section class="rv"><h2 class="sec">Lua 脚本</h2>'
            '<div class="cnt">按模块分组，显示前 40 组</div>'
            '<div class="tbl-wrap"><table>'
            '<thead><tr><th>模块</th><th>文件</th><th>大小</th></tr></thead>'
            '<tbody>%s</tbody></table></div></section>'
            % (kpi_html, ''.join(rows)))
    meta = ('<b>系统设计</b>：%s 个 Lua · %s 个 C# · %s 个热更新文件'
            % ('{:,}'.format(len(lua)), '{:,}'.format(len(cs)),
               '{:,}'.format(len(patches))))
    html = page('system.html', '系统设计', "WITCH'S WEAPON / SYSTEM",
                'SYSTEM · LUA & PATCHES', meta, body)
    p = os.path.join(SITE, 'system.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  system.html  %s' % fmt(os.path.getsize(p)))


def build_news():
    """官网公告"""
    base = '02_客户端解包/网络资源/13_官网日服witchs-weapon.net/'
    docs = [a for a in ASSETS if a['k'] == 'doc' and a['p'].startswith(base)]
    news = [a for a in docs if 'news' in a['p'].lower() or 'info' in a['p'].lower()]
    src = news if news else docs
    src = sorted(src, key=lambda x: x['p'], reverse=True)
    cards = []
    for i, a in enumerate(src):
        cards.append(
            '<div class="card" style="animation-delay:%dms">'
            '<div class="body"><div class="ttl">%s</div>'
            '<div class="sub">%s</div></div></div>'
            % (min(i * 20, 600), esc(os.path.basename(a['p'])), fmt(a['b'])))
    body = ('<section class="rv"><h2 class="sec">官网公告</h2>'
            '<div class="cnt">%d 条 · 来自官网存档</div>'
            '<div class="grid g3">%s</div></section>'
            % (len(src), ''.join(cards)))
    meta = '<b>官网公告</b>：%d 条' % len(src)
    html = page('news.html', '官网公告', "WITCH'S WEAPON / NEWS",
                'NEWS · %d ITEMS' % len(src), meta, body)
    p = os.path.join(SITE, 'news.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  news.html  %s  (%d 条)' % (fmt(os.path.getsize(p)), len(src)))


def build_relics():
    """开发遗迹：未上线内容 + 废弃资源"""
    unused = [a for a in ASSETS if 'NO_USE' in a['p'] or '未上线' in a['p']
              or 'unused' in a['p'].lower()]
    groups = defaultdict(list)
    for a in unused:
        parts = a['p'].split('/')
        groups[parts[0] if parts else '其它'].append(a)
    secs = []
    for g in sorted(groups, key=lambda x: -len(groups[x]))[:20]:
        items = sorted(groups[g], key=lambda y: y['p'])
        rows = ''.join('<tr><td class="mono">%s</td><td class="mono">%s</td></tr>'
                       % (esc(a['p'][:110]), fmt(a['b'])) for a in items[:60])
        secs.append('<h3 class="sub">%s<span class="n">%d 个</span></h3>'
                    '<div class="tbl-wrap"><table><tbody>%s</tbody></table></div>'
                    % (esc(g), len(items), rows))
    body = ('<section class="rv"><h2 class="sec">开发遗迹</h2>'
            '<div class="cnt">未上线内容与废弃资源 · 共 %d 个</div>%s</section>'
            % (len(unused), ''.join(secs) if secs else
               '<div class="empty">未找到相关资源</div>'))
    meta = '<b>开发遗迹</b>：%d ��未上线/废弃资源' % len(unused)
    html = page('relics.html', '开发遗迹', "WITCH'S WEAPON / RELICS",
                'RELICS · %d FILES' % len(unused), meta, body)
    p = os.path.join(SITE, 'relics.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  relics.html  %s  (%d 个)' % (fmt(os.path.getsize(p)), len(unused)))


def build_archive():
    """全部文件索引"""
    rows = []
    for a in sorted(ASSETS, key=lambda x: x['p']):
        rows.append('<tr><td class="mono">%s</td><td class="mono">%s</td>'
                    '<td class="mono">%s</td></tr>'
                    % (esc(a['k']), esc(a['p']), fmt(a['b'])))
    kinds = Counter(a['k'] for a in ASSETS)
    kpis = [('{:,}'.format(len(ASSETS)), '文件总数'),
            (fmt(sum(a['b'] for a in ASSETS)), '总体积')]
    kpis += [('{:,}'.format(v), k) for k, v in kinds.most_common(6)]
    kpi_html = ''.join('<div class="kpi"><div class="v">%s</div>'
                       '<div class="k">%s</div></div>' % (v, k) for v, k in kpis)
    tools = ('<div class="tools"><div class="tools-in">'
             '<label class="sr-only" for="q">搜索文件</label>'
             '<input id="q" type="search" placeholder="搜索文件路径…">'
             '<button type="button" id="clr">清除</button>'
             '<span class="stat" id="stat"></span></div></div>')
    body = ('<section class="rv"><h2 class="sec">全部文件</h2>'
            '<div class="cnt">%s 个文件的完整索引</div>'
            '<div class="kpis">%s</div></section>'
            '<section class="rv"><h2 class="sec">文件列表</h2>'
            '<div class="tbl-wrap" style="max-height:70vh"><table id="tbl">'
            '<thead><tr><th>类型</th><th>路径</th><th>大小</th></tr></thead>'
            '<tbody>%s</tbody></table></div></section>'
            % ('{:,}'.format(len(ASSETS)), kpi_html, ''.join(rows)))
    meta = '<b>全部文件</b>：%s 个 · %s' % ('{:,}'.format(len(ASSETS)),
                                        fmt(sum(a['b'] for a in ASSETS)))
    html = page('archive.html', '全部文件', "WITCH'S WEAPON / ARCHIVE",
                'ALL FILES · %s' % '{:,}'.format(len(ASSETS)), meta, body, tools)
    html = html.replace('<script src="js/app.js"></script>',
                        '<script src="js/app.js"></script>\n'
                        '<script>bindTable("q","tbl","stat");'
                        'document.getElementById("clr").onclick=function(){'
                        'var i=document.getElementById("q");i.value="";'
                        'i.dispatchEvent(new Event("input"));i.focus();};</script>')
    p = os.path.join(SITE, 'archive.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  archive.html  %s' % fmt(os.path.getsize(p)))


# news / relics 已由 site-news.py / site-relics.py 专门构建，此处不再覆盖
build_system()
build_archive()
print('已写 2 页（news/relics 见专用脚本）')
