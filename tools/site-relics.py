# 开发遗迹页 v3 —— debug/test/old 文件 + 着色器 + Lua
import io, os, sys, re
from collections import defaultdict, Counter

sys.path.insert(0, r'G:\project\其他\game\tools')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from site_lib import (R, SITE, ASSETS, page, U, T, esc, fmt, find_image)


def build():
    # 遗迹类：debug / test / old / backup 等
    PATS = ['debug', 'test', 'old', 'backup', 'temp', 'tmp', 'dummy']
    relics = []
    for a in ASSETS:
        low = a['p'].lower()
        for p in PATS:
            if p in low:
                relics.append((p, a))
                break

    by_kind = defaultdict(list)
    for p, a in relics:
        by_kind[p].append(a)

    # 着色器
    shaders = [a for a in ASSETS if a['p'].startswith('09_着色器/')]
    lua = [a for a in ASSETS if a['p'].startswith('10_Lua脚本/')]

    kpis = [
        ('{:,}'.format(len(relics)), '遗迹文件'),
        ('{:,}'.format(len(shaders)), '着色器'),
        ('{:,}'.format(len(lua)), 'Lua 脚本'),
        ('{:,}'.format(len(by_kind)), '遗迹类型'),
    ]
    kpi_html = ''.join(
        '<div class="kpi"><div class="v">%s</div><div class="k">%s</div></div>'
        % (v, k) for v, k in kpis)

    # 遗迹分组表
    secs = []
    for k in sorted(by_kind, key=lambda x: -len(by_kind[x])):
        items = sorted(by_kind[k], key=lambda y: y['p'])
        rows = ''.join(
            '<tr><td class="mono">%s</td><td class="mono">%s</td><td class="mono">%s</td></tr>'
            % (esc(a['k']), esc(a['p'][:110]), fmt(a['b']))
            for a in items[:80])
        secs.append(
            '<h3 class="sub">%s<span class="n">%d 个</span></h3>'
            '<div class="tbl-wrap" style="max-height:400px"><table>'
            '<thead><tr><th>类型</th><th>路径</th><th>大小</th></tr></thead>'
            '<tbody>%s</tbody></table></div>' % (esc(k), len(items), rows))

    # 着色器列表
    sh_rows = ''.join(
        '<tr><td class="mono">%s</td><td class="mono">%s</td></tr>'
        % (esc(os.path.basename(a['p'])), fmt(a['b'])) for a in sorted(shaders, key=lambda x: x['p']))

    body = ('<section class="rv"><h2 class="sec">开发遗迹</h2>'
            '<div class="cnt">调试、测试、旧版本残留文件 —— 这些内容未在正式游戏中出现</div>'
            '<div class="kpis">%s</div></section>'
            '<section class="rv"><h2 class="sec">遗迹文件</h2>'
            '<div class="cnt">按关键词分类，每类显示前 80 个</div>%s</section>'
            '<section class="rv"><h2 class="sec">着色器</h2>'
            '<div class="cnt">%d 个 Shader 文件</div>'
            '<div class="tbl-wrap" style="max-height:400px"><table>'
            '<thead><tr><th>文件</th><th>大小</th></tr></thead>'
            '<tbody>%s</tbody></table></div></section>'
            % (kpi_html, ''.join(secs) if secs else '<div class="empty">无</div>',
               len(shaders), sh_rows))

    meta = ('<b>开发遗迹</b>：%s 个调试/测试/旧版文件<br>'
            '<b>着色器</b>：%s 个' % ('{:,}'.format(len(relics)),
                                    '{:,}'.format(len(shaders))))
    html = page('relics.html', '开发遗迹', "WITCH'S WEAPON / RELICS",
                'RELICS · %d FILES' % len(relics), meta, body)
    p = os.path.join(SITE, 'relics.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  relics.html  %s  (%d 遗迹, %d 着色器)'
          % (fmt(os.path.getsize(p)), len(relics), len(shaders)))


build()
