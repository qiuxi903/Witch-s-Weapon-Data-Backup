# 角色页 v3 —— 大立绘卡片网格（海报式）
import io, os, sys, json, re

sys.path.insert(0, r'G:\project\其他\game\tools')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from site_lib import (R, SITE, ASSETS, IMETA, page, U, T, esc, fmt,
                      chars, find_image)


def build():
    CS = chars()
    have = [c for c in CS if c['portrait']]
    miss = [c for c in CS if not c['portrait']]

    # ---- 角色海报卡 ----
    cards = []
    for i, c in enumerate(CS):
        art = c['portrait'] or c.get('avatar')
        if art:
            img = ('<img class="art" src="%s" alt="%s" loading="lazy" '
                   'decoding="async">' % (T(art), esc(c.get('zh') or c['num'])))
        else:
            img = '<div class="art" style="background:var(--surface-3)"></div>'
        cv = c.get('cv') or ''
        jp = c.get('jp') or ''
        zh = c.get('zh') or ('#' + c['num'])
        n_art = len(c.get('portraits') or [])
        cards.append(
            '<div class="pcard" style="animation-delay:%dms">'
            '%s<div class="shade"></div>'
            '<span class="num">%s</span>'
            '<span class="rarity">%d 图</span>'
            '<div class="info">'
            '<div class="nm">%s</div>'
            '%s'
            '%s'
            '</div></div>'
            % (min(i * 40, 800), img, esc(c['num']), n_art, esc(zh),
               ('<div class="jp">%s</div>' % esc(jp)) if jp else '',
               ('<div class="cv">CV · %s</div>' % esc(cv)) if cv else ''))

    # ---- 详细档案表 ----
    rows = []
    for c in CS:
        full = c.get('full_zh') or ''
        extra = ''
        if full and full != (c.get('zh') or ''):
            extra = ('<br><span style="color:var(--text-4);font-size:12.5px">%s</span>'
                     % esc(full))
        rows.append(
            '<tr>'
            '<td class="idx">%s</td>'
            '<td><b>%s</b>%s</td>'
            '<td>%s</td>'
            '<td>%s</td>'
            '<td>%s</td>'
            '<td>%s</td>'
            '<td class="mono">%s</td>'
            '</tr>'
            % (esc(c['num']),
               esc(c.get('zh') or ''),
               extra,
               esc(c.get('jp') or ''),
               esc(c.get('en') or ''),
               esc(c.get('kr') or ''),
               esc(c.get('weapon') or ''),
               esc(c.get('cv') or '')))

    # ---- 立绘总览（每个角色的全部立绘）----
    gal = []
    for c in CS:
        for p in (c.get('portraits') or []):
            gal.append(
                '<figure class="gal-item" data-full="%s">'
                '<div class="ph" style="height:300px">'
                '<img src="%s" alt="%s" loading="lazy" decoding="async"></div>'
                '<figcaption class="cap">%s · %s</figcaption></figure>'
                % (U(p), T(p), esc(c.get('zh') or ''), esc(c.get('zh') or ''),
                   esc(os.path.basename(p))))

    meta = ('<b>角色</b>：%d 名 · 立绘 %d 张<br>'
            '<b>资料</b>：五语名称 · 武器 · 声优 · 台词'
            % (len(CS), sum(len(c.get('portraits') or []) for c in CS)))

    tools = ('<div class="tools"><div class="tools-in">'
             '<label class="sr-only" for="q">搜索角色</label>'
             '<input id="q" type="search" placeholder="搜索角色名 / 日文名 / 声优…">'
             '<button type="button" id="clr">清除</button>'
             '<span class="stat" id="stat"></span></div></div>')

    body = (
        '<section class="rv">'
        '<h2 class="sec">角色立绘</h2>'
        '<div class="cnt">%d 名角色 · 点击卡片全屏查看立绘 · 支持 ← → 翻页</div>'
        '<div class="pgrid">%s</div>'
        '</section>'

        '<section class="rv">'
        '<h2 class="sec">角色档案</h2>'
        '<div class="cnt">五语名称 · 武器 · 声优</div>'
        '<div class="tbl-wrap"><table id="tbl">'
        '<thead><tr><th>编号</th><th>中文名</th><th>日文名</th>'
        '<th>英文名</th><th>韩文名</th><th>武器</th><th>声优</th></tr></thead>'
        '<tbody>%s</tbody></table></div>'
        '</section>'

        '<section class="rv">'
        '<h2 class="sec">全部立绘</h2>'
        '<div class="cnt">%d 张角色卡面，按原始比例完整显示</div>'
        '<div class="gallery">%s</div>'
        '</section>'
        % (len(CS), ''.join(cards),
           ''.join(rows),
           len(gal), ''.join(gal)))

    html = page('characters.html', '角色', "WITCH'S WEAPON / CHARACTERS",
                'CHARACTERS · %d' % len(CS), meta, body, tools)
    html = html.replace('<script src="js/app.js"></script>',
                        '<script src="js/app.js"></script>\n'
                        '<script>bindFilter("q",".pcard","stat");'
                        'document.getElementById("clr").onclick=function(){'
                        'var i=document.getElementById("q");i.value="";'
                        'i.dispatchEvent(new Event("input"));i.focus();};</script>')
    p = os.path.join(SITE, 'characters.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  characters.html  %s  (%d 名, 立绘 %d 张, 无图 %d)'
          % (fmt(os.path.getsize(p)), len(CS), len(gal), len(miss)))


build()
