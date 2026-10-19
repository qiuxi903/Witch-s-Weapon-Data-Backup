# 剧情页 v3 —— 章节卡片 + 背景图 + 真实对话
import io, os, sys, json, re

sys.path.insert(0, r'G:\project\其他\game\tools')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from site_lib import (R, SITE, ASSETS, IMETA, page, U, T, esc, fmt,
                      story_chapters, CHAP_BG, find_image)

# 每章补充背景图：优先 story_pic 映射，其次按章节关键词找
KEYWORD_BG = {
    '序章·系统与引导':              ['BG_Ark_base', 'BG_Base_Control_Room', 'BG_BSpeak'],
    '第一章·人生的终结、命运的开始':  ['BG_City_street', 'BG_Base_Corridor', 'BG_Ark_base'],
    '第二章·想守护的她、被守护的你':  ['BG_APT_livingRoom', 'BG_City_coffeeShop', 'BG_Base_Laboratory'],
    '第三章·神魂的治愈、身体的诅咒':  ['BG_Fabiola_Church', 'BG_Base_Laboratory', 'BG_Ark_base_corridor'],
    '活动剧情':                     ['Activity_Story_001', 'BG_City_street1', 'BG_Ark_base'],
    '支线剧情':                     ['BG_City_street2', 'BG_APT_bedRoom', 'BG_Depot1'],
    '测试与其它':                   ['BG_BSpeak', 'BG_ECT', 'BG_Ark_elevator'],
}


def pick_bg(chap):
    """给章节挑一张背景图"""
    # 1) 配置表里的 story_pic
    nm = CHAP_BG.get(chap['name'])
    if nm:
        p = find_image(nm)
        if p:
            return p
    # 2) 关键词
    for kw in KEYWORD_BG.get(chap['name'], []):
        p = find_image(kw)
        if p:
            return p
    # 3) 任意背景场景
    for a in ASSETS:
        if a['k'] == 'image' and a['p'].startswith('06_美术素材/07_背景场景/'):
            return a['p']
    return None



# 剧情文本里的颜色标记：[rrggbb]文字[-]  ->  <span style="color:#rrggbb">文字</span>
import re as _re
_COL = _re.compile(r'\[([0-9a-fA-F]{6})\](.*?)\[-\]', _re.S)


def rich(s):
    """转义 + 把颜色标记渲染成真实颜色"""
    out = esc(s)
    def rep(m):
        col = m.group(1)
        return '<span style="color:#%s;font-weight:600">%s</span>' % (col, m.group(2))
    prev = None
    while prev != out:
        prev = out
        out = _COL.sub(rep, out)
    # 清掉残留的孤立标记，避免露出 [ff9900] 这种原始码
    out = _re.sub(r'\[[0-9a-fA-F]{6}\]', '', out)
    out = out.replace('[-]', '')
    return out


def build():
    CH = story_chapters()
    total_lines = sum(len(c['lines']) for c in CH)
    total_files = sum(len(c['files']) for c in CH)

    # ---- 章节卡片 ----
    cards = []
    for i, c in enumerate(CH):
        bg = pick_bg(c)
        c['bg'] = bg
        img = ('<img class="bgimg" src="%s" alt="" loading="lazy" decoding="async">'
               % T(bg)) if bg else ''
        n_sp = len(c['speakers'])
        cards.append(
            '<a class="chap" href="#ch%d" style="animation-delay:%dms">'
            '%s<div class="veil"></div>'
            '<div class="cin">'
            '<span class="ctag">%s</span>'
            '<div class="cttl">%s</div>'
            '<div class="cmeta">'
            '<span><b>%s</b> 条对话</span>'
            '<span><b>%s</b> 个场景文件</span>'
            '<span><b>%s</b> 名角色</span>'
            '</div></div></a>'
            % (i, min(i * 60, 600), img,
               esc(c['name'].split('·')[0] if '·' in c['name'] else '章节'),
               esc(c['name']),
               '{:,}'.format(len(c['lines'])),
               len(c['files']), n_sp))

    # ---- 每章正文 ----
    secs = []
    for i, c in enumerate(CH):
        bg = c.get('bg')
        head_img = ('<img class="bgimg" src="%s" alt="" loading="lazy" '
                    'decoding="async" style="opacity:.22">' % T(bg)) if bg else ''
        dlines = []
        for l in c['lines']:
            who = l['who']
            # 说话人字段可能是 "名字@显示名"
            if '@' in who:
                who = who.split('@', 1)[1]
            if who in ('N/A', ''):
                who = ''
            txt = l['zh'].replace('\\n', '\n')
            dlines.append(
                '<div class="dline">%s<div class="txt">%s</div></div>'
                % (('<div class="who">%s</div>' % esc(who)) if who else '',
                   rich(txt)))
        secs.append(
            '<section class="rv" id="ch%d" style="position:relative;'
            'border-radius:var(--r);overflow:hidden;padding:var(--s5)">'
            '%s'
            '<div style="position:relative;z-index:2">'
            '<h2 class="sec">%s</h2>'
            '<div class="cnt">%s 条对话 · %s 个场景文件 · %s 名角色</div>'
            '<details><summary>展开本章全部对话（%s 条）</summary>'
            '<div class="in dlg">%s</div></details>'
            '</div></section>'
            % (i, head_img, esc(c['name']),
               '{:,}'.format(len(c['lines'])), len(c['files']),
               len(c['speakers']),
               '{:,}'.format(len(c['lines'])), ''.join(dlines)))

    # ---- 说话人统计 ----
    from collections import Counter
    sp = Counter()
    for c in CH:
        for l in c['lines']:
            w = l['who']
            if '@' in w:
                w = w.split('@', 1)[1]
            if w and w != 'N/A':
                sp[w] += 1
    chips = ''.join('<span class="chip">%s · %s</span>' % (esc(k), v)
                    for k, v in sp.most_common(40))

    meta = ('<b>剧情</b>：%d 章 · %s 条对话 · %s 个场景文件<br>'
            '<b>语言</b>：简体中文 / 繁體中文 / 日本語 / 한국어 / English'
            % (len(CH), '{:,}'.format(total_lines), total_files))

    body = (
        '<section class="rv">'
        '<h2 class="sec">章节</h2>'
        '<div class="cnt">%d 章 · 点击跳转到该章对话</div>'
        '<div class="cgrid">%s</div>'
        '</section>'

        '<section class="rv">'
        '<h2 class="sec">出场角色</h2>'
        '<div class="cnt">按台词条数排序</div>'
        '<div class="chips">%s</div>'
        '</section>'

        '%s'
        % (len(CH), ''.join(cards), chips, ''.join(secs)))

    html = page('story.html', '剧情', "WITCH'S WEAPON / STORY",
                'STORY · %d CHAPTERS' % len(CH), meta, body)
    p = os.path.join(SITE, 'story.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  story.html  %s  (%d 章, %s 条对话, 背景图 %d 张)'
          % (fmt(os.path.getsize(p)), len(CH), '{:,}'.format(total_lines),
             sum(1 for c in CH if c.get('bg'))))


build()
