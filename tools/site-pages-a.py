# 美术 / 音频 / 视频 / 漫画 v4 —— 分类折叠 + 懒加载（解决卡顿）
import io, os, sys, re
from collections import defaultdict

sys.path.insert(0, r'G:\project\其他\game\tools')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from site_lib import (R, SITE, ASSETS, IMETA, page, U, UALT, T, esc, fmt, find_image)

DESC = {
 '01_角色卡面':  '角色立绘卡面',
 '02_角色立绘部件':'立绘分层部件',
 '03_卡牌':      '卡牌插画',
 '04_加载图':    '加载界面插画',
 '05_活动图':    '运营活动宣传图',
 '06_白烛':      '白烛专属素材',
 '07_背景场景':  '战斗与剧情背景',
 '08_UI界面':    '界面控件与装饰',
 '09_特效':      '战斗特效贴图',
 '10_角色3D贴图':'角色模型贴图',
 '11_武器立绘':  '武器插画',
 '12_角色头像':  '头像与半身像',
 '13_图标':      '功能图标',
 '14_字体':      '字体资源',
 '15_地区专属':  '各服独占素材',
 '16_光影贴图':  '光影与遮���',
 '17_其它':      '未分类素材',
 '18_官方壁纸':  '官方壁纸',
 '19_角色图鉴_萌娘百科': '萌娘百科收录',
}


def gal_item(relpath, cap, tiny=False, h=280):
    """懒加载画廊项：图片先放 data-src，折叠展开后才真正请求"""
    return ('<figure class="gal-item%s" data-full="%s">'
            '<div class="ph" style="height:%dpx">'
            '<img data-src="%s" alt="%s" loading="lazy" decoding="async"></div>'
            '<figcaption class="cap" title="%s">%s</figcaption></figure>'
            % (' tiny' if tiny else '', U(relpath), h, T(relpath),
               esc(cap), esc(relpath), esc(cap)))


def fold(key, title, desc, n, size, inner, open_=False):
    """分类折叠块"""
    return ('<details class="fold" id="%s"%s>'
            '<summary><div class="fh"><h3>%s</h3>%s</div>'
            '<span class="fn">%s 项 · %s</span></summary>'
            '<div class="fb">%s</div></details>'
            % (esc(key), ' open' if open_ else '', esc(title),
               ('<div class="fd">%s</div>' % esc(desc)) if desc else '',
               '{:,}'.format(n), fmt(size), inner))


# ============================================================
#  美术
# ============================================================
def build_art():
    A = [a for a in ASSETS if a['k'] == 'image' and a['p'].startswith('06_美术素材/')]
    cats = defaultdict(list)
    for a in A:
        parts = a['p'].split('/')
        cats[parts[1] if len(parts) > 2 else '其它'].append(a)

    def cat_order(name):
        if name.startswith('17_'):
            return (1, name)
        if name[:2].isdigit():
            return (0, name)
        return (0, 'zz' + name)

    folds = []
    for i, c in enumerate(sorted(cats, key=cat_order)):
        items = sorted(cats[c], key=lambda y: y['p'])
        sz = sum(x['b'] for x in items)
        cells = []
        for x in items:
            m = IMETA.get(x['p'])
            tiny = bool(m and (m[0] < 96 or m[1] < 96))
            ratio = max(0.4, min(2.8, (m[0] / float(m[1])) if (m and m[1]) else 1.0))
            h = int(max(180, min(400, 300 / ratio)))
            cells.append(gal_item(x['p'], os.path.basename(x['p']), tiny, h))
        folds.append(fold('c' + c[:2], c, DESC.get(c, ''), len(items), sz,
                          '<div class="gallery">%s</div>' % ''.join(cells),
                          open_=(i == 0)))

    others = [a for a in ASSETS if a['k'] == 'image'
              and not a['p'].startswith('06_美术素材/')]
    oc = defaultdict(list)
    for a in others:
        parts = a['p'].split('/')
        oc['/'.join(parts[:2]) if len(parts) > 2 else parts[0]].append(a)
    ofolds = []
    for c in sorted(oc, key=lambda x: -len(oc[x])):
        items = sorted(oc[c], key=lambda y: y['p'])
        sz = sum(x['b'] for x in items)
        ofolds.append(fold('o' + str(abs(hash(c)) % 100000), c, '客户端解包 / 网络资源',
                           len(items), sz,
                           '<div class="gallery">%s</div>'
                           % ''.join(gal_item(x['p'], os.path.basename(x['p']))
                                     for x in items)))

    n_all = len(A) + len(others)
    sz_all = sum(x['b'] for x in A) + sum(x['b'] for x in others)

    tools = ('<div class="tools"><div class="tools-in">'
             '<label class="sr-only" for="q">搜索图片</label>'
             '<input id="q" type="search" placeholder="搜索图片文件名…（如 servant / bg / icon）">'
             '<button type="button" id="clr">清除</button>'
             '<span class="stat" id="stat"></span></div></div>')

    body = (
        '<section class="rv">'
        '<h2 class="sec">分类浏览</h2>'
        '<div class="cnt">共 <b>%s</b> 张图片 · <b>%s</b> · <b>%d</b> 个分类。'
        '点击分类标题展开，展开时才加载图片。</div>'
        '%s'
        '</section>'
        '<section class="rv">'
        '<h2 class="sec">其它图片素材</h2>'
        '<div class="cnt">来自客户端解包与网络资源 · <b>%s</b> 张</div>'
        '%s'
        '</section>'
        % ('{:,}'.format(n_all), fmt(sz_all), len(cats),
           ''.join(folds),
           '{:,}'.format(len(others)), ''.join(ofolds)))

    meta = ('<b>美术素材</b>：%s 张图片 · %s<br>'
            '<b>浏览</b>：按分类展开 · 图片按原始比例完整显示 · 点击全屏 · ← → 翻页'
            % ('{:,}'.format(n_all), fmt(sz_all)))
    html = page('art.html', '美术', "WITCH'S WEAPON / ARTWORK",
                'ARTWORK · %s IMAGES' % '{:,}'.format(n_all), meta, body, tools)
    html = html.replace('<script src="js/app.js"></script>',
                        '<script src="js/app.js"></script>\n'
                        '<script>bindFilter("q",".gal-item","stat");'
                        'document.getElementById("clr").onclick=function(){'
                        'var i=document.getElementById("q");i.value="";'
                        'i.dispatchEvent(new Event("input"));i.focus();};</script>')
    p = os.path.join(SITE, 'art.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  art.html  %s  (%d 分类, %s 张)'
          % (fmt(os.path.getsize(p)), len(cats), '{:,}'.format(n_all)))


# ============================================================
#  音频
# ============================================================
def build_audio():
    def player(p):
        """部署模式下同时给出 Opus 与 MP3 地址，由 JS 按浏览器支持情况挑一个。
        只暴露 data-src（保持 preload="none" 的惰性），不用 <source> 子元素。"""
        ogg = U(p)
        alt = UALT(p)
        if alt:
            return ('<audio controls preload="none" data-src="%s" data-alt="%s">'
                    '</audio>' % (ogg, alt))
        return '<audio controls preload="none" data-src="%s"></audio>' % ogg

    A = [a for a in ASSETS if a['k'] == 'audio']
    groups = defaultdict(list)
    for a in A:
        parts = a['p'].split('/')
        groups[parts[1] if len(parts) > 2 else '其它'].append(a)

    folds = []
    for i, g in enumerate(sorted(groups, key=lambda x: -len(groups[x]))):
        items = sorted(groups[g], key=lambda y: y['p'])
        sz = sum(x['b'] for x in items)
        cells = ''.join(
            '<div class="track"><div class="nm" title="%s">%s</div>'
            '<div class="sz">%s</div>%s</div>'
            % (esc(os.path.basename(x['p'])), esc(os.path.basename(x['p'])),
               fmt(x['b']), player(x['p'])) for x in items)
        folds.append(fold('a' + str(abs(hash(g)) % 100000), g, '音频分组',
                          len(items), sz,
                          '<div class="grid g3">%s</div>' % cells,
                          open_=(i == 0)))

    sz_all = sum(a['b'] for a in A)
    tools = ('<div class="tools"><div class="tools-in">'
             '<label class="sr-only" for="q">搜索音频</label>'
             '<input id="q" type="search" placeholder="搜索音频文件名…">'
             '<button type="button" id="clr">清除</button>'
             '<span class="stat" id="stat"></span></div></div>')

    body = ('<section class="rv"><h2 class="sec">音频资源</h2>'
            '<div class="cnt">共 <b>%s</b> 个 · <b>%s</b> · <b>%d</b> 个分组。'
            '展开分组后才加载播放器。</div>%s</section>'
            % ('{:,}'.format(len(A)), fmt(sz_all), len(groups), ''.join(folds)))
    meta = '<b>音频</b>：%s 个 · %s' % ('{:,}'.format(len(A)), fmt(sz_all))
    html = page('audio.html', '音频', "WITCH'S WEAPON / AUDIO",
                'AUDIO · %s FILES' % '{:,}'.format(len(A)), meta, body, tools)
    html = html.replace('<script src="js/app.js"></script>',
                        '<script src="js/app.js"></script>\n'
                        '<script>bindFilter("q",".track","stat");'
                        'document.getElementById("clr").onclick=function(){'
                        'var i=document.getElementById("q");i.value="";'
                        'i.dispatchEvent(new Event("input"));i.focus();};</script>')
    p = os.path.join(SITE, 'audio.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  audio.html  %s  (%d 分组, %s 个)'
          % (fmt(os.path.getsize(p)), len(groups), '{:,}'.format(len(A))))


# ============================================================
#  视频
# ============================================================
def build_video():
    A = [a for a in ASSETS if a['k'] == 'video']
    A.sort(key=lambda x: x['p'])
    groups = defaultdict(list)
    for a in A:
        parts = a['p'].split('/')
        groups[parts[1] if len(parts) > 2 else '其它'].append(a)

    folds = []
    for i, g in enumerate(sorted(groups, key=lambda x: -len(groups[x]))):
        items = groups[g]
        sz = sum(x['b'] for x in items)
        cells = ''.join(
            '<div class="card"><video controls preload="none" data-src="%s"></video>'
            '<div class="body"><div class="ttl">%s</div>'
            '<div class="sub">%s</div></div></div>'
            % (U(x['p']), esc(os.path.basename(x['p'])), fmt(x['b'])) for x in items)
        folds.append(fold('v' + str(abs(hash(g)) % 100000), g, '视频分组',
                          len(items), sz,
                          '<div class="grid g2">%s</div>' % cells,
                          open_=(i == 0)))

    sz = sum(a['b'] for a in A)
    body = ('<section class="rv"><h2 class="sec">视频</h2>'
            '<div class="cnt">共 <b>%d</b> 个 · <b>%s</b> · 含各服独占 PV。'
            '展开分组后才加载视频。</div>%s</section>'
            % (len(A), fmt(sz), ''.join(folds)))
    meta = '<b>视频</b>：%d 个 · %s' % (len(A), fmt(sz))
    html = page('video.html', '视频', "WITCH'S WEAPON / VIDEO",
                'VIDEO · %d FILES' % len(A), meta, body)
    p = os.path.join(SITE, 'video.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  video.html  %s  (%d 个)' % (fmt(os.path.getsize(p)), len(A)))


# ============================================================
#  四格漫画
# ============================================================
def build_manga():
    base = '02_客户端解包/网络资源/13_官网日服witchs-weapon.net/cartoon_img/'
    imgs = sorted([a for a in ASSETS if a['k'] == 'image' and a['p'].startswith(base)],
                  key=lambda x: x['p'])
    strips = defaultdict(list)
    for a in imgs:
        b = os.path.basename(a['p'])
        m = re.match(r'(\d+)_(\d+)\.png', b)
        if m:
            strips[m.group(1)].append((int(m.group(2)), a['p']))

    folds = []
    for i, sid in enumerate(sorted(strips)):
        ps = sorted(strips[sid])
        sz = sum(a['b'] for a in imgs if os.path.basename(a['p']).startswith(sid + '_'))
        panels = ''.join(
            '<figure class="gal-item" data-full="%s">'
            '<div class="ph" style="height:320px">'
            '<img data-src="%s" alt="" loading="lazy" decoding="async"></div>'
            '<figcaption class="cap">%s</figcaption></figure>'
            % (U(p), T(p), esc(os.path.basename(p))) for _, p in ps)
        folds.append(fold('m' + sid, '第 %s 篇' % sid, '四格漫画', len(ps), sz,
                          '<div class="gallery">%s</div>' % panels,
                          open_=(i == 0)))

    body = ('<section class="rv"><h2 class="sec">四格漫画</h2>'
            '<div class="cnt">共 <b>%d</b> 篇 · <b>%d</b> 格 · 官网日服原图。'
            '展开篇目后加载图片。</div>%s</section>'
            % (len(strips), len(imgs), ''.join(folds)))
    meta = '<b>四格漫画</b>：%d 篇 · %d 格' % (len(strips), len(imgs))
    html = page('manga.html', '四格漫画', "WITCH'S WEAPON / 4-KOMA",
                '4-KOMA · %d STRIPS' % len(strips), meta, body)
    p = os.path.join(SITE, 'manga.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  manga.html  %s  (%d 篇, %d 格)'
          % (fmt(os.path.getsize(p)), len(strips), len(imgs)))


build_art()
build_audio()
build_video()
build_manga()
print('已写 4 页')
