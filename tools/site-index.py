# 首页 v3 —— 角色主导 · 海报式
import io, os, sys, json, re

sys.path.insert(0, r'G:\project\其他\game\tools')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from site_lib import (R, SITE, ASSETS, IMETA, page, U, T, esc, fmt,
                      chars, story_chapters, find_image)

# 各区服统计
REGIONS = [
    ('国服 v2.0.1',    '2024-08-17 停服'),
    ('怀旧服 v128',    '完整资源'),
    ('日服 v2.0.0',    'EXNOA 发行'),
    ('港澳台 v1.6.0',  ''),
    ('韩服 v1.0',      ''),
]


def build():
    CS = chars()
    CH = story_chapters()

    n_img = sum(1 for a in ASSETS if a['k'] == 'image')
    n_aud = sum(1 for a in ASSETS if a['k'] == 'audio')
    n_vid = sum(1 for a in ASSETS if a['k'] == 'video')
    total_b = sum(a['b'] for a in ASSETS)
    n_files = len(ASSETS)
    n_lines = sum(len(c['lines']) for c in CH)
    n_gal = sum(len(c.get('portraits') or []) for c in CS)

    kpis = [
        ('{:,}'.format(n_files), '文件总数'),
        (fmt(total_b), '总体积'),
        ('{:,}'.format(n_img), '图片素材'),
        ('{:,}'.format(n_aud), '音频文件'),
        ('{:,}'.format(n_vid), '视频文件'),
        ('{:,}'.format(len(CS)), '登场角色'),
        ('{:,}'.format(n_lines), '剧情对话'),
        ('{:,}'.format(len(CH)), '剧情章节'),
    ]
    kpi_html = ''.join(
        '<div class="kpi"><div class="v">%s</div><div class="k">%s</div></div>'
        % (v, k) for v, k in kpis)

    # ---- 首页角色墙（取有立绘的前 12 名）----
    wall = []
    for i, c in enumerate([x for x in CS if x['portrait']][:12]):
        wall.append(
            '<a class="pcard" href="characters.html" style="animation-delay:%dms">'
            '<img class="art" src="%s" alt="%s" loading="lazy" decoding="async">'
            '<div class="shade"></div>'
            '<span class="num">%s</span>'
            '<div class="info"><div class="nm">%s</div>'
            '%s</div></a>'
            % (min(i * 45, 500), T(c['portrait']), esc(c.get('zh') or ''),
               esc(c['num']), esc(c.get('zh') or ''),
               ('<div class="jp">%s</div>' % esc(c.get('jp'))) if c.get('jp') else ''))

    # ---- 章节预览（前 4 章）----
    from site_story_bg import pick_bg
    chaps = []
    for i, c in enumerate(CH[:4]):
        bg = pick_bg(c)
        chaps.append(
            '<a class="chap" href="story.html#ch%d" style="animation-delay:%dms">'
            '%s<div class="veil"></div>'
            '<div class="cin"><span class="ctag">%s</span>'
            '<div class="cttl">%s</div>'
            '<div class="cmeta"><span><b>%s</b> 条对话</span></div>'
            '</div></a>'
            % (i, min(i * 60, 400),
               ('<img class="bgimg" src="%s" alt="" loading="lazy" decoding="async">'
                % T(bg)) if bg else '',
               esc(c['name'].split('·')[0] if '·' in c['name'] else '章节'),
               esc(c['name']), '{:,}'.format(len(c['lines']))))

    # ---- 分区入口卡 ----
    cards = [
        ('characters.html', '角色',   '%d 名 · %d 张立绘 · 五语名称' % (len(CS), n_gal),
         CS[0]['portrait'] if CS and CS[0]['portrait'] else None),
        ('story.html',      '剧情',   '%d 章 · %s 条对话' % (len(CH), '{:,}'.format(n_lines)),
         pick_bg(CH[0]) if CH else None),
        ('art.html',        '美术',   '{:,} 张图片 · 按原始比例'.format(n_img),
         find_image('Activity_002_Bg')),
        ('manga.html',      '四格漫画', '45 篇 · 中文翻译',
         find_image('0802_01')),
        ('audio.html',      '音频',   '{:,} 个 · CV / BGM / 音效'.format(n_aud),
         find_image('Activity00_thxday')),
        ('video.html',      '视频',   '%d 个 · 含各服独占 PV' % n_vid,
         find_image('Activity_004_Bg2')),
        ('config.html',     '配置表', '95 张表 · 23,946 行 · 可搜索',
         find_image('Frame_Upgrade_BG')),
        ('system.html',     '系统设计', '24 活动 · 48 热更新补丁',
         find_image('Frame_Help_Big')),
        ('news.html',       '官网公告', '103 条 · 日文原文',
         find_image('img_pre_register_chara')),
        ('relics.html',     '开发遗迹', '未上线剧情 · 废弃资源',
         find_image('LoadingAssetBundle')),
        ('archive.html',    '全部文件', '{:,} 个文���索引'.format(n_files),
         find_image('img_025')),
    ]
    card_html = []
    for i, (href, ttl, sub, img) in enumerate(cards):
        th = ('<div class="thumb"><img src="%s" alt="" loading="lazy" '
              'decoding="async"></div>' % T(img)) if img else ''
        card_html.append(
            '<a class="card" href="%s" style="animation-delay:%dms">%s'
            '<div class="body"><div class="ttl">%s</div>'
            '<div class="sub">%s</div></div></a>'
            % (href, min(i * 40, 400), th, esc(ttl), esc(sub)))

    # ---- 关于表 ----
    about = [
        ('安装包',   '五区 APK/XAPK + 怀旧服客户端', '16 个 / 7.72 GB'),
        ('客户端解包', '五区完整解包 + AssetBundle', '35,517 个 / 9.20 GB'),
        ('剧情文本', '五语对照', '444 个 / 10.7 MB'),
        ('配置表',   '95 张表全部解密', '109 个 / 7.4 MB'),
        ('美术素材', '19 类分类归档', '{:,} 张 / 1.48 GB'.format(n_img)),
        ('音频',     'CV / BGM / 音效', '{:,} 个 / 1.37 GB'.format(n_aud)),
        ('视频',     '含日服/港澳台/韩服独占 PV', '%d 个 / 285 MB' % n_vid),
    ]
    about_rows = ''.join(
        '<tr><td><b>%s</b></td><td>%s</td><td class="mono">%s</td></tr>'
        % (esc(a), esc(b), esc(c)) for a, b, c in about)

    meta = ('<b>《魔女兵器》</b> Witch\'s Weapon · 北京水琴铃开发 · 国服 2024-08-17 停服<br>'
            '<b>本档案</b>：从五区客户端完整提取的游戏资源 —— 剧情、配置表、美术、音频、视频')

    body = (
        '<section class="rv">'
        '<h2 class="sec">收藏概览</h2>'
        '<div class="cnt">本档案统计（不含重复副本与构建工具）</div>'
        '<div class="kpis">%s</div>'
        '</section>'

        '<section class="rv">'
        '<h2 class="sec">角色</h2>'
        '<div class="cnt">%d 名登场角色 · 点击进入角色页查看全部立绘</div>'
        '<div class="pgrid">%s</div>'
        '</section>'

        '<section class="rv">'
        '<h2 class="sec">剧情章节</h2>'
        '<div class="cnt">%d 章 · %s 条对话 · 五语对照</div>'
        '<div class="cgrid">%s</div>'
        '</section>'

        '<section class="rv">'
        '<h2 class="sec">浏览</h2>'
        '<div class="cnt">点击进入各专题</div>'
        '<div class="grid g3">%s</div>'
        '</section>'

        '<section class="rv">'
        '<h2 class="sec">关于这份档案</h2>'
        '<div class="cnt">游戏已于 2024-08-17 停服，本档案在停服后从客户端完整提取</div>'
        '<div class="tbl-wrap"><table>'
        '<thead><tr><th>类别</th><th>内容</th><th>规模</th></tr></thead>'
        '<tbody>%s</tbody></table></div>'
        '</section>'
        % (kpi_html,
           len(CS), ''.join(wall),
           len(CH), '{:,}'.format(n_lines), ''.join(chaps),
           ''.join(card_html),
           about_rows))

    html = page('index.html', '魔女兵器收藏档案', "WITCH'S WEAPON / ARCHIVE",
                'COMPLETE GAME ARCHIVE · 5 REGIONS', meta, body)
    p = os.path.join(SITE, 'index.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  index.html  %s' % fmt(os.path.getsize(p)))


build()
