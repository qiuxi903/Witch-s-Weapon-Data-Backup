# 重建美术页 v2 —— 大图网格（一行 3-4 张）
import io, os, sys, json
from collections import defaultdict

sys.path.insert(0, r'G:\project\其他\game\tools')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from site_lib import (R, SITE, ASSETS, IMETA, page, U, esc, fmt, gallery_item)

DESC = {
 '01_角色卡面':  '角色立绘卡面，游戏内主要展示图',
 '02_角色立绘部件':'立绘分层部件（身体 / 表情 / 装饰）',
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
 '16_光影贴图':  '光影与遮罩',
 '17_其它':      '未分类素材',
 '18_官方壁纸':  '官方壁纸',
 '19_角色图鉴_萌娘百科': '萌娘百科收录的角色图鉴',
}

def build():
    A = [a for a in ASSETS if a['k'] == 'image' and a['p'].startswith('06_美术素材/')]
    cats = defaultdict(list)
    for a in A:
        parts = a['p'].split('/')
        cats[parts[1] if len(parts) > 2 else '其它'].append(a)

    def cat_order(name):
        if name.startswith('17_'):
            return (1, name)          # 未分类放最后
        if name[:2].isdigit():
            return (0, name)          # 编号分类按序
        return (0, 'zz' + name)       # 兜底

    secs = []
    for c in sorted(cats, key=cat_order):
        items = sorted(cats[c], key=lambda y: y['p'])
        sz = sum(x['b'] for x in items)
        cells = []
        for x in items:
            m = IMETA.get(x['p'])
            tiny = bool(m and (m[0] < 96 or m[1] < 96))
            cells.append(gallery_item(x['p'], os.path.basename(x['p']), tiny))
        desc = DESC.get(c, '')
        secs.append(
            '<div class="gal-head"><h3>%s</h3>'
            '<span class="n">%d 张</span>'
            '%s'
            '<span class="sz">%s</span></div>'
            '<div class="gallery">%s</div>'
            % (esc(c), len(items),
               ('<span class="n">%s</span>' % esc(desc)) if desc else '',
               fmt(sz), ''.join(cells)))

    others = [a for a in ASSETS if a['k'] == 'image' and not a['p'].startswith('06_美术素材/')]
    ocats = defaultdict(list)
    for a in others:
        parts = a['p'].split('/')
        ocats['/'.join(parts[:2]) if len(parts) > 2 else parts[0]].append(a)
    osecs = []
    for c in sorted(ocats, key=lambda x: -len(ocats[x])):
        items = sorted(ocats[c], key=lambda y: y['p'])
        sz = sum(x['b'] for x in items)
        cells = ''.join(gallery_item(x['p'], os.path.basename(x['p'])) for x in items)
        osecs.append('<div class="gal-head"><h3>%s</h3><span class="n">%d 张</span>'
                     '<span class="sz">%s</span></div><div class="gallery">%s</div>'
                     % (esc(c), len(items), fmt(sz), cells))

    n_all = len(A) + len(others)
    sz_all = sum(x['b'] for x in A) + sum(x['b'] for x in others)

    tools = ('<div class="tools"><div class="tools-in">'
             '<label class="sr-only" for="q">搜索图片</label>'
             '<input id="q" type="search" placeholder="搜索图片文件名…（如 servant / bg / icon）">'
             '<button type="button" id="clr">清除</button>'
             '<span class="stat" id="stat"></span></div></div>')

    body = ('<section>'
            '<h2 class="sec">美术素材</h2>'
            '<div class="cnt">%d 张图片 · %s · %d 个分类</div>'
            '<div class="note">'
            '每张图按 <b>原始宽高比</b> 完整显示，不裁切、不拉伸。'
            '点击任意图片可全屏查看，支持 <code>←</code> <code>→</code> 翻页、'
            '<code>Esc</code> 关闭。'
            '</div></section>%s%s'
            % (n_all, fmt(sz_all), len(cats),
               ''.join(secs),
               ('<section><h2 class="sec">其它图片素材</h2>'
                '<div class="cnt">%d 张 · 来自客户端解包与网络资源</div>%s</section>'
                % (len(others), ''.join(osecs))) if osecs else ''))

    meta = ('<b>美术素材</b>：%d 张图片 · %s<br>'
            '<b>浏览</b>：按原始比例完整显示 · 点击全屏 · 键盘翻页'
            % (n_all, fmt(sz_all)))

    html = page('art.html', '美术', "WITCH'S WEAPON / ARTWORK",
                'ARTWORK · %d IMAGES' % n_all, meta, body, tools)
    html = html.replace('<script src="js/app.js"></script>',
                        '<script src="js/app.js"></script>\n'
                        '<script>bindFilter("q",".gal-item","stat");'
                        'document.getElementById("clr").onclick=function(){'
                        'var i=document.getElementById("q");i.value="";'
                        'i.dispatchEvent(new Event("input"));i.focus();};</script>')
    p = os.path.join(SITE, 'art.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  art.html  %s' % fmt(os.path.getsize(p)))

build()
