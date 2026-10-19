# 构建网站最后 6 页：美术 / 漫画 / 公告 / 系统 / 遗迹 / 全部文件
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
# 美术
# ============================================================
def build_art():
    A = [a for a in ASSETS if a['k'] == 'image' and a['p'].startswith('06_美术素材/')]
    cats = defaultdict(list)
    for a in A:
        parts = a['p'].split('/')
        c = parts[1] if len(parts) > 2 else '其它'
        cats[c].append(a)
    secs = []
    for c in sorted(cats, key=lambda x: -len(cats[x])):
        items = cats[c]
        sz = sum(x['b'] for x in items)
        # 全部展示（懒加载，不截断）
        show = sorted(items, key=lambda y: y['p'])
        imgs = ''.join('<a class="card" href="%s" target="_blank"><div class="thumb">'
                       '<img src="%s" loading="lazy" alt="" class="zoom"></div>'
                       '<div class="body"><div class="sub">%s</div></div></a>'
                       % (U(x['p']), U(x['p']), esc(os.path.basename(x['p'])[:34]))
                       for x in show)
        secs.append('<section><h2 class="bar">%s</h2><div class="cnt">%d 个 · %s</div>'
                    '<div class="grid g4">%s</div></section>' % (esc(c), len(items), fmt(sz), imgs))

    # 其余图片（02_客户端解包 / assets）—— 按顶层子目录分组
    others = [a for a in ASSETS if a['k'] == 'image' and not a['p'].startswith('06_美术素材/')]
    ocats = defaultdict(list)
    for a in others:
        parts = a['p'].split('/')
        key = '/'.join(parts[:2]) if len(parts) > 2 else parts[0]
        ocats[key].append(a)
    osecs = []
    for c in sorted(ocats, key=lambda x: -len(ocats[x])):
        items = ocats[c]
        sz = sum(x['b'] for x in items)
        imgs = ''.join('<a class="card" href="%s" target="_blank"><div class="thumb">'
                       '<img src="%s" loading="lazy" alt="" class="zoom"></div>'
                       '<div class="body"><div class="sub">%s</div></div></a>'
                       % (U(x['p']), U(x['p']), esc(os.path.basename(x['p'])[:34]))
                       for x in sorted(items, key=lambda y: y['p']))
        osecs.append('<section><h2 class="bar">%s</h2><div class="cnt">%d 个 · %s</div>'
                     '<div class="grid g4">%s</div></section>' % (esc(c), len(items), fmt(sz), imgs))

    body = ('<section><h2 class="bar">美术素材</h2>'
            '<div class="cnt">%d 个图片 · %s · 19 类分类归档</div>'
            '<div class="note">点击任意图片可放大查看。全部图片均已列出，采用懒加载。</div></section>%s'
            % (len(A), fmt(sum(x['b'] for x in A)), '\n'.join(secs)))
    if osecs:
        body += ('\n<section><h2 class="bar">其它图片素材</h2>'
                 '<div class="cnt">%d 个 · 来自客户端解包与网站素材</div>%s</section>'
                 % (len(others), '\n'.join(osecs)))

    meta = ('<b>美术</b>：%d 个图片 · %s<br>'
            '<b>分类</b>：角色卡面 / 立绘部件 / 武器立绘 / 加载图 / 头像 等 19 类'
            ) % (len(A) + len(others), fmt(sum(x['b'] for x in A) + sum(x['b'] for x in others)))
    W('art.html', page('art.html', '美术', 'WITCH\'S WEAPON / ARTWORK',
                       'ARTWORK · %d IMAGES' % (len(A) + len(others)), meta, body))

build_art()

# ============================================================
# 四格漫画
# ============================================================
def build_manga():
    BASE = os.path.join(R, '02_客户端解包', '网络资源', '13_官网日服witchs-weapon.net')
    d = json.load(io.open(os.path.join(BASE, 'cartoon.json'), encoding='utf-8'))
    TR = {
     1005:('主从关系','「主人」与「仆从」的日常——谁才是真正说了算的那个？'),
     1039:('新来的','新人报到，但魔女兵器的「新人」从来都不太正常。'),
     1045:('过去的污点','黑历史被翻出来了——某些人宁愿它永远埋着。'),
     1067:('共享记忆','英灵与兵器共享记忆，于是尴尬也一起共享了。'),
     1073:('正是这个年纪','再怎么是魔女，该有的少女心事一样不少。'),
     1079:('恶魔～','「恶魔」这个词，在魔女兵器里有别的解释。'),
     1121:('健康生活！？','为了健康而努力，但方式好像哪里不对。'),
     1136:('搭档','所谓搭档，就是互相拖后腿还嘴硬的那种。'),
     1145:('非常奇妙的故事','奇妙到不知道该从哪里吐槽起。'),
     1154:('消失了！？','东西不见了——凶手就在这些人当中。'),
     1188:('不擅长的事','每个人都有弱点，魔女的弱点尤其致命。'),
     1199:('那方面的达人','在某个领域登峰造极，可惜方向有点偏。'),
     1217:('本性','伪装再久，本性总会在某个瞬间露出来。'),
     1233:('运营来信','来自运营方的信——通常意味着要出事了。'),
     1240:('世界级权威','权威人士登场，然后被现实狠狠打脸。'),
     1264:('BUG ①','游戏出 bug 了，角色们自己也知道。'),
     1295:('BUG ②','bug 的后续——修好了吗？显然没有。'),
     1806:('猫，之后','那只猫后来怎么样了——答案是更麻烦了。'),
     1808:('续·猫，之后','猫的故事还有续集，而且更失控。'),
     1866:('监护人','谁是监护人谁是小孩，这事经常搞反。'),
     1868:('雨天发生的事 ①','下雨天总会有事发生，这次也一样。'),
     1870:('雨天发生的事 ②','雨还没停，麻烦也没停。'),
     1884:('超载','装太多了——物理意义上和比喻意义上都是。'),
     1887:('误会','一场误会，然后滚成雪球。'),
     1945:('满员电车','挤电车这件事，魔女也躲不过。'),
     1954:('精神年龄','年龄是数字，精神年龄才是真相。'),
     1970:('格差社会','差距就是差距，连魔女界也一样。'),
     1982:('干劲开关','只要找到那个开关，谁都能爆发。'),
     1985:('系统的背面','游戏系统的背面——玩家看不到的那一面。'),
     1992:('秘密的房间','有个房间不该进去，但总有人要进。'),
     1999:('银河的尽头','尺度突然拉大到银河级别。'),
     2008:('救赎？','这是救赎吗——��号很重要。'),
     2017:('无妄之灾','什么都没做，祸从天上来。'),
     2029:('规格的正面','官方设定是这样写的——正面版本。'),
     2036:('规格的背面','官方设定没写的那部分。'),
      802:('购物 ①','去买东西，然后事情开始跑偏。'),
      810:('购物 ②','购物续集——这次更离谱。'),
      878:('【番外篇】来自开发组的信','开发组亲自下场——通常意味着要道歉了。'),
      900:('同类相吸！？','性格相似的人凑一起，要么成为挚友要么成为灾难。'),
      919:('劈西瓜 ①','夏日定番：蒙眼劈西瓜，但参与者是魔女。'),
      938:('劈西瓜 ②','西瓜还没劈开，场面已经失控。'),
      958:('邪神？召唤','召唤仪式——召唤出来的东西不太对。'),
      965:('邪神？现身','召唤物的后续：它真的来了。'),
      971:('大小姐','「大小姐」这个称呼，有人喜欢有人炸毛。'),
      979:('异世界转生！？','异世界转生题材——魔女兵器也来玩一把。'),
    }
    strips = []
    for s in sorted(d, key=lambda x: x['date']):
        if not s['imgs']: continue
        zh, note = TR.get(s['id'], (s['title'], ''))
        panels = ''.join('<img src="%s" loading="lazy" alt="" class="zoom">'
                         % U('02_客户端解包/网络资源/13_官网日服witchs-weapon.net/cartoon_img/' + n)
                         for n in s['imgs'])
        strips.append('''<article class="strip" data-t="%s %s %s">
<div class="hd"><span class="no">%04d</span>
<span class="zh">%s</span><span class="jp">%s</span>
<span class="dt">%s</span></div>
<div class="note2">%s</div>
<div class="panels">%s</div></article>''' % (esc(zh), esc(s['title']), esc(note),
    s['id'], esc(zh), esc(s['title']), esc(s['date']), esc(note), panels))

    tools = ('<div class="tools"><div class="tools-in">'
             '<input id="q" placeholder="搜索漫画标题...">'
             '<span class="stat" id="stat"></span></div></div>')
    body = ('<section><h2 class="bar">官方四格漫画</h2>'
            '<div class="cnt">%d 篇 · 220 张图 · 2019-06 ~ 2020-07</div>'
            '<div class="note">抓取自日服官网 <code>/cartoon/</code> —— 这是官网'
            '<b>唯一还在线的原创内容</b>。标题与简介为中文翻译，画面保留日文原图。'
            '点击图片可放大。</div>%s</section>'
            % (len(strips), '\n'.join(strips)))

    meta = ('<b>四格漫画</b>：45 篇 · 220 张图<br>'
            '<b>来源</b>：日服官网 <code>witchs-weapon.net/cartoon/</code>')
    html = page('manga.html', '四格漫画', 'WITCH\'S WEAPON / 4-KOMA',
                'OFFICIAL 4-KOMA · CN TRANSLATION', meta, body, tools)
    html = html.replace('<script src="js/app.js"></script>',
                        '<script src="js/app.js"></script>\n'
                        '<script>bindFilter("q",".strip","stat","data-t");</script>')
    W('manga.html', html)

build_manga()

# ============================================================
# 官网公告
# ============================================================
def build_news():
    D = os.path.join(R, '11_官网公告')
    idx = json.load(io.open(os.path.join(D, '_index.json'), encoding='utf-8'))
    items = []
    for x in sorted(idx, key=lambda y: y['id']):
        tf = os.path.join(D, 'info_%d.txt' % x['id'])
        body = io.open(tf, encoding='utf-8', errors='replace').read() if os.path.exists(tf) else ''
        # 去掉标题/日期头
        parts = body.split('\n\n', 1)
        content = parts[1] if len(parts) > 1 else body
        content = re.sub(r'\n{3,}', '\n\n', content).strip()
        items.append('''<article class="card" style="cursor:default" data-t="%s %s">
<div class="body">
<div class="sub">#%d · %s</div>
<div class="ttl" style="font-size:14.5px">%s</div>
<div style="font-size:12.5px;color:#b9bfc9;max-height:280px;overflow:auto;margin-top:8px">%s</div>
</div></article>''' % (esc(x['title']), esc(content[:400]), x['id'], esc(x['date']),
                       esc(x['title']), esc(content[:2200]).replace('\n', '<br>')))

    tools = ('<div class="tools"><div class="tools-in">'
             '<input id="q" placeholder="搜索公告标题或正文...">'
             '<span class="stat" id="stat"></span></div></div>')
    body = ('<section><h2 class="bar">官网公告</h2>'
            '<div class="cnt">%d 条 · 2018-12-27 ~ 2019-11 · 日文原文</div>'
            '<div class="note">完整记录了日服从 <b>官网开张 → CBT → 正式上线</b> 的全过程。'
            '官网 ID 空间 29 ~ 2047，大部分已 404，这 %d 条是仍在线部分。</div>'
            '<div class="grid g2">%s</div></section>'
            % (len(items), len(items), '\n'.join(items)))

    meta = ('<b>官网公告</b>：%d 条日文原文<br>'
            '<b>跨度</b>：2018-12-27 ~ 2019-11 · 记录日服从开站到上线') % len(items)
    html = page('news.html', '官网公告', 'WITCH\'S WEAPON / OFFICIAL NEWS',
                'OFFICIAL NEWS · %d POSTS' % len(items), meta, body, tools)
    html = html.replace('<script src="js/app.js"></script>',
                        '<script src="js/app.js"></script>\n'
                        '<script>bindFilter("q",".card","stat","data-t");</script>')
    W('news.html', html)

build_news()

json.dump(written, io.open(os.path.join(SITE, '_written3.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
print('已写 %d 页' % len(written))
