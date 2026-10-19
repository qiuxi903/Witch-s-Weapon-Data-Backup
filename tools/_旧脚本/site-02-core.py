# 构建网站其余 11 个页面
import io, os, sys, json, re, csv
from collections import defaultdict, OrderedDict, Counter

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
SITE = os.path.join(R, '网站')
ASSETS = json.load(io.open(os.path.join(R, 'tools', '_asset_index.json'), encoding='utf-8'))
BY_PATH = {a['p']: a for a in ASSETS}

def U(p):
    return '../' + p.replace('\\', '/')

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
# 剧情
# ============================================================
def build_story():
    D = os.path.join(R, '04_剧情文本')
    regions = OrderedDict()
    for x in sorted(os.listdir(D)):
        p = os.path.join(D, x)
        if os.path.isdir(p):
            fs = [f for f in os.listdir(p) if f.endswith('.txt')]
            if fs:
                regions[x] = (p, fs)

    CHAP = {'序章':'#8f96a3','第一章':'#c9a227','第二章':'#7fb3d5','第三章':'#d98cb3',
            '活动剧情':'#8fc9a0','支线':'#c9a27f','其它':'#6b7484'}
    def chap(f):
        m = re.match(r'sentence_(\d+)', f)
        if not m: return '其它'
        n = int(m.group(1))
        if n < 10000: return '序章'
        k = n // 10000
        if k == 1: return '第一章'
        if k == 2: return '第二章'
        if k == 3: return '活动剧情' if n >= 31000 else '第三章'
        if k == 4: return '支线'
        return '其它'

    # 主区域 = 国服
    main = '国服v2.0.1' if '国服v2.0.1' in regions else list(regions)[0]
    mp, mf = regions[main]
    groups = OrderedDict()
    for f in sorted(mf):
        groups.setdefault(chap(f), []).append(f)

    secs = []
    for c, fs in groups.items():
        col = CHAP.get(c, '#8f96a3')
        items = ''.join(
            '<div class="it" style="--c:%s"><div class="no">%s</div><div class="ln">%s</div></div>'
            % (col, esc(f.replace('sentence_','').replace('.txt','')),
               fmt(os.path.getsize(os.path.join(mp, f))))
            for f in fs)
        secs.append('<h3 style="color:%s">%s <span style="color:#6b7484;font-size:12px;'
                    'font-family:var(--mono)">%d 个</span></h3><div class="tl">%s</div>'
                    % (col, c, len(fs), items))

    # 区域表
    rrows = ''.join('<tr><td class="mono">%s</td><td class="idx">%d</td><td class="dim">%s</td></tr>'
                    % (esc(k), len(v[1]),
                       fmt(sum(os.path.getsize(os.path.join(v[0], f)) for f in v[1])))
                    for k, v in regions.items())

    # 表格版
    tbl = [a for a in ASSETS if a['p'].startswith('05_剧情表格/')]
    trows = ''.join('<tr><td class="mono">%s</td><td class="dim">%s</td></tr>'
                    % (esc(os.path.basename(a['p'])), fmt(a['b'])) for a in sorted(tbl, key=lambda x: -x['b']))

    # 样例
    sample = ''
    sp = os.path.join(mp, 'sentence_10002.txt')
    if os.path.exists(sp):
        c = io.open(sp, encoding='utf-8', errors='replace').read()
        lines = [l for l in c.split('\n') if l.strip()][:14]
        sample = ''.join('<tr><td class="idx">%d</td><td class="mono">%s</td></tr>'
                         % (i+1, esc(l[:150])) for i, l in enumerate(lines))

    body = '''<section>
<h2 class="bar">剧情文本</h2>
<div class="cnt">五区解密文本 · 格式：<code>序号 TAB 说话人@类型 TAB 简中 TAB 繁中 TAB 日 TAB 韩 TAB 英</code></div>
<div class="note">
全部剧情以 <b>XOR 0xFF</b> 逐字节解密自客户端 BytesAsset。
主区域为 <b>%s</b>，共 <b>%d</b> 个文本文件。
</div>
<div class="scroll"><table>
<thead><tr><th>区域</th><th>文本数</th><th>体积</th></tr></thead>
<tbody>%s</tbody></table></div>
</section>

<section>
<h2 class="bar">章节分布（%s）</h2>
<div class="cnt">按剧情编号自动分章</div>
%s
</section>

<section>
<h2 class="bar">五语对照表格</h2>
<div class="cnt">CSV / XLSX 导出</div>
<div class="scroll"><table>
<thead><tr><th>文件</th><th>体积</th></tr></thead>
<tbody>%s</tbody></table></div>
</section>

<section>
<h2 class="bar">文本样例</h2>
<div class="cnt">sentence_10002.txt 前 14 行</div>
<div class="scroll"><table>
<thead><tr><th>#</th><th>内容</th></tr></thead>
<tbody>%s</tbody></table></div>
</section>''' % (esc(main), len(mf), rrows, esc(main), '\n'.join(secs), trows, sample)

    meta = ('<b>剧情文本</b>：五区解密 · 18,037 行 · 五语对照<br>'
            '<b>格式</b>：制表符分隔，含说话人与语言类型标记')
    W('story.html', page('story.html', '剧情', 'WITCH\'S WEAPON / STORY',
                         'STORY TEXT · 5 LANGUAGES', meta, body))

build_story()

# ============================================================
# 角色
# ============================================================
def build_characters():
    chars = json.load(io.open(os.path.join(R, '角色设定集.json'), encoding='utf-8'))
    cards = []
    for c in sorted(chars, key=lambda x: -x['lines']):
        img = ''
        if c['card']:
            # 找实际路径
            for a in ASSETS:
                if a['p'].endswith(os.path.basename(c['card'])):
                    img = a['p']; break
        thumb = ('<div class="thumb"><img src="%s" loading="lazy" alt="" class="zoom"></div>' % U(img)) if img else ''
        cv = ('<div class="sub">CV %s</div>' % esc(c['cv'])) if c['cv'] else ''
        cards.append('''<article class="card" style="cursor:default">
%s<div class="body">
<div class="ttl">%s</div>
<div class="sub">%s</div>
%s
<div class="sub">台词 %d 句</div>
</div></article>''' % (thumb, esc(c['zh']), esc(c['en'] or c['jp']), cv, c['lines']))

    # 详情表
    rows = []
    for c in sorted(chars, key=lambda x: -x['lines']):
        q = (c['intro_zh'] or '').replace('\\n', ' ').replace('\n', ' ')[:110]
        rows.append('<tr><td class="mono">%s</td><td>%s</td><td class="dim">%s</td>'
                    '<td class="dim">%s</td><td class="idx">%d</td></tr>'
                    % (esc(c['num']), esc(c['zh']), esc(c['full_zh'] or '—'),
                       esc(c['cv'] or '—'), c['lines']))

    body = '''<section>
<h2 class="bar">角色档案</h2>
<div class="cnt">%d 名 · 数据源：配置表 dictionary.csv（全名 / 自我介绍 / 武器描述）</div>
<div class="note">
每名角色在 <code>dictionary.csv</code> 中有 <b>6 条记录</b>：
<code>101</code> 名字、<code>104</code> 武器描述、<code>105</code> 全名、<code>106</code> 自我介绍。
</div>
<div class="grid g3">%s</div>
</section>

<section>
<h2 class="bar">档案总表</h2>
<div class="cnt">按台词数排序</div>
<div class="scroll"><table>
<thead><tr><th>编号</th><th>名字</th><th>全名</th><th>CV</th><th>台词数</th></tr></thead>
<tbody>%s</tbody></table></div>
</section>''' % (len(chars), '\n'.join(cards), ''.join(rows))

    meta = ('<b>角色</b>：37 名完整档案 · 47 英灵<br>'
            '<b>内容</b>：立绘 · CV 语音 · 五语名称 · 全名 · 自我介绍 · 武器描述 · 台词统计')
    W('characters.html', page('characters.html', '角色', 'WITCH\'S WEAPON / CHARACTERS',
                              'CHARACTER PROFILES · 37 ENTRIES', meta, body))

build_characters()

json.dump(written, io.open(os.path.join(SITE, '_written.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
print('已写 %d 页' % len(written))
