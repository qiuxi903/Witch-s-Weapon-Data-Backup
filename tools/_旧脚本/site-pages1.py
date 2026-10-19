# 重建其余 11 页（新设计系统）
import io, os, sys, json, re, csv
from collections import defaultdict, Counter

sys.path.insert(0, r'G:\project\其他\game\tools')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from site_lib import (R, SITE, ASSETS, IMETA, THUMBS, page, U, esc, fmt, gallery_item)

written = []
def W(fname, html):
    p = os.path.join(SITE, fname)
    io.open(p, 'w', encoding='utf-8').write(html)
    written.append((fname, os.path.getsize(p)))
    print('  %-18s %s' % (fname, fmt(os.path.getsize(p))))

# ============================================================
# 首页
# ============================================================
def build_index():
    byk = Counter(x['k'] for x in ASSETS)
    tot = sum(x['b'] for x in ASSETS)

    def pick(prefix):
        for a in sorted(ASSETS, key=lambda x: x['p']):
            if a['p'].startswith(prefix) and a['k'] == 'image':
                m = IMETA.get(a['p'])
                if m and m[0] >= 300 and m[1] >= 300:
                    return a['p']
        return ''

    cards = [
        ('story.html', '剧情文本', '221 篇 · 18,037 行 · 五语对照',
         '06_美术素材/07_背景场景/Bg_Library.png', False),
        ('characters.html', '角色档案', '37 名 · 立绘 / CV / 五语名称',
         '06_美术素材/01_角色卡面/Servant00_Image_100.png', False),
        ('config.html', '配置表查询', '95 张表 · 23,946 行 · 可搜索',
         '06_美术素材/08_UI界面/Frame_Upgrade_BG.png', False),
        ('audio.html', '音频资源', '1,828 个 · CV / BGM / 音效',
         '06_美术素材/05_活动图/Activity00_thxday.png', False),
        ('video.html', '视频', '26 个 · 含各服独占 PV',
         '06_美术素材/05_活动图/Activity_004_Bg2.png', False),
        ('art.html', '美术素材', '9,279 张 · 按原始比例展示',
         '06_美术素材/05_活动图/Activity_002_Bg.png', False),
        ('manga.html', '四格漫画', '45 篇 · 中文翻译',
         '02_客户端解包/网络资源/13_官网日服witchs-weapon.net/cartoon_img/0802_01.png', False),
        ('news.html', '官网公告', '103 条 · 日文原文',
         '02_客户端解包/网络资源/13_官网日服witchs-weapon.net/img/img_pre_register_chara.png', False),
        ('system.html', '系统设计', '24 活动 · 48 热更新补丁',
         '06_美术素材/08_UI界面/Frame_Help_Big.png', False),
        ('relics.html', '开发遗迹', '未上线剧情 · 废弃资源',
         '06_美术素材/17_其它/LoadingAssetBundle.png', False),
        ('archive.html', '全部文件', '44,197 个文件索引',
         '06_美术素材/18_官方壁纸/img_025.png', False),
    ]

    ch = []
    for href, ttl, sub, imgp, contain in cards:
        if imgp:
            cls = 'thumb contain' if contain else 'thumb'
            tsrc = ('thumbs/' + THUMBS[imgp]) if imgp in THUMBS and THUMBS[imgp] else U(imgp)
            thumb = ('<div class="%s"><img src="%s" alt="" decoding="async"></div>'
                     % (cls, tsrc))
        else:
            thumb = '<div class="thumb ph"></div>'
        ch.append('<a class="card" href="%s">%s<div class="body">'
                  '<div class="ttl">%s</div><div class="sub">%s</div></div></a>'
                  % (href, thumb, esc(ttl), esc(sub)))

    body = '''<section>
<h2 class="sec">收藏概览</h2>
<div class="cnt">本档案统计（不含重复副本与构建工具）</div>
<div class="kpis">
  <div class="kpi"><div class="v">%s</div><div class="k">文件总数</div></div>
  <div class="kpi"><div class="v">%s</div><div class="k">总体积</div></div>
  <div class="kpi"><div class="v">%s</div><div class="k">图片素材</div></div>
  <div class="kpi"><div class="v">%s</div><div class="k">音频文件</div></div>
  <div class="kpi"><div class="v">%s</div><div class="k">视频文件</div></div>
  <div class="kpi"><div class="v">5</div><div class="k">区服版本</div></div>
</div>
</section>

<section>
<h2 class="sec">浏览</h2>
<div class="cnt">点击进入各专题</div>
<div class="grid g3">%s</div>
</section>

<section>
<h2 class="sec">关于这份档案</h2>
<div class="note">
《魔女兵器》（Witch's Weapon）是北京水琴铃（WaterBell）开发的横轴动作手游，
日服由 EXNOA / SUIKINREI 发行。国服已于 <b>2024-08-17 00:00</b> 停服。
本档案在停服后从客户端完整提取了游戏资源。
</div>
<div class="tbl-wrap"><table>
<thead><tr><th>类别</th><th>内容</th><th>规模</th></tr></thead>
<tbody>
<tr><td class="mono">安装包</td><td>五区 APK/XAPK + 怀旧服客户端</td><td class="dim">16 个 / 7.72 GB</td></tr>
<tr><td class="mono">客户端解包</td><td>五区完整解包 + AssetBundle</td><td class="dim">35,517 个 / 9.20 GB</td></tr>
<tr><td class="mono">剧情文本</td><td>五语对照，XOR 0xFF 解密</td><td class="dim">444 个 / 10.7 MB</td></tr>
<tr><td class="mono">配置表</td><td>95 张表全部解密</td><td class="dim">109 个 / 7.4 MB</td></tr>
<tr><td class="mono">美术素材</td><td>19 类分类归档</td><td class="dim">9,279 张 / 1.25 GB</td></tr>
<tr><td class="mono">音频</td><td>CV / BGM / 音效</td><td class="dim">1,828 个 / 1.37 GB</td></tr>
<tr><td class="mono">视频</td><td>含日服/港澳台/韩服独占 PV</td><td class="dim">26 个 / 285 MB</td></tr>
</tbody></table></div>
</section>

<section>
<h2 class="sec">技术说明</h2>
<div class="note">
<b>加密算法</b>：剧情文本与配置表均为逐字节 <code>XOR 0xFF</code>（按位取反）。<br>
<b>资源格式</b>：Unity 2017.4.27f1 · UnityFS v6 bundle · LZ4 块压缩。
</div>
<details><summary>目录结构</summary><div class="in">
<code>01_安装包/</code> — 五区安装包<br>
<code>02_客户端解包/</code> — 完整解包与 AssetBundle<br>
<code>03_配置表/</code> — 95 张解密后的 CSV<br>
<code>04_剧情文本/</code> — 五区剧情 + 未上线剧情<br>
<code>05_剧情表格/</code> — 五语对照 CSV/XLSX<br>
<code>06_美术素材/</code> — 19 类分类归档<br>
<code>07_音频资源/</code> — CV/BGM/音效<br>
<code>08_视频资源/</code> — 去重后的独立视频<br>
<code>09_着色器/</code> — 45 个独立着色器<br>
<code>10_Lua脚本/</code> — 176 个脚本<br>
<code>11_官网公告/</code> — 103 条日文公告<br>
<code>_旧版HTML_留念/</code> — 网站化前的独立页面<br>
<code>_重复文件_待删/</code> — 去重隔离区（可删）
</div></details>
</section>''' % ('{:,}'.format(len(ASSETS)), fmt(tot),
                 '{:,}'.format(byk.get('image', 0)),
                 '{:,}'.format(byk.get('audio', 0)),
                 '{:,}'.format(byk.get('video', 0)),
                 '\n'.join(ch))

    meta = ('<b>《魔女兵器》</b> Witch\'s Weapon · 北京水琴铃开发 · 国服 2024-08-17 停服<br>'
            '<b>本档案</b>：从五区客户端完整提取的游戏资源 —— 剧情、配置表、美术、音频、视频')
    W('index.html', page('index.html', '魔女兵器收藏档案', "WITCH'S WEAPON / ARCHIVE",
                         'COMPLETE GAME ARCHIVE · 5 REGIONS', meta, body))

build_index()

# ============================================================
# 剧情
# ============================================================
def build_story():
    D = os.path.join(R, '04_剧情文本')
    regions = {}
    for x in sorted(os.listdir(D)):
        p = os.path.join(D, x)
        if os.path.isdir(p):
            fs = [f for f in os.listdir(p) if f.endswith('.txt')]
            if fs: regions[x] = (p, fs)

    # 去重后部分区域只剩 manifest：回退到实际保留文本的目录
    MANIFEST = {
        '国服v2.0.1': '怀旧服v128',   # 怀旧服 v128 是国服零售版的严格超集
    }
    for k, alt in MANIFEST.items():
        if k not in regions and alt in regions:
            regions[k] = regions[alt]

    CHAP = {'序章': '#838b9b', '第一章': '#d4af37', '第二章': '#7ab0dd',
            '第三章': '#d98cb3', '活动剧情': '#7fc99a', '支线': '#c9a27f', '其它': '#5b6373'}

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

    main = '国服v2.0.1' if '国服v2.0.1' in regions else list(regions)[0]
    mp, mf = regions[main]
    # 若该区域文本实际来自其它目录，标注真实来源
    src_note = ''
    for k, alt in MANIFEST.items():
        if k == main and regions.get(k) is regions.get(alt) and alt != main:
            src_note = ('<div class="note">该区域文本去重后保留于 '
                        '<code>04_剧情文本/%s/</code>（怀旧服 v128 是国服零售版的'
                        '<b>严格超集</b>，含全部国服剧情）。</div>' % esc(alt))
    groups = {}
    for f in sorted(mf):
        groups.setdefault(chap(f), []).append(f)

    secs = []
    for c in ['序章', '第一章', '第二章', '第三章', '活动剧情', '支线', '其它']:
        fs = groups.get(c)
        if not fs: continue
        col = CHAP.get(c, '#838b9b')
        items = ''.join(
            '<div class="it" style="--c:%s"><div class="no">%s</div>'
            '<div class="ln">%s</div></div>'
            % (col, esc(f.replace('sentence_', '').replace('.txt', '')),
               fmt(os.path.getsize(os.path.join(mp, f))))
            for f in fs)
        secs.append('<h3 class="sub" style="color:%s">%s <span class="n">%d 篇</span></h3>'
                    '<div class="tl">%s</div>' % (col, c, len(fs), items))

    rrows = ''.join('<tr><td class="mono">%s</td><td class="idx">%d</td>'
                    '<td class="dim">%s</td></tr>'
                    % (esc(k), len(v[1]),
                       fmt(sum(os.path.getsize(os.path.join(v[0], f)) for f in v[1])))
                    for k, v in regions.items())

    tbl = sorted([a for a in ASSETS if a['p'].startswith('05_剧情表格/')],
                 key=lambda x: -x['b'])
    trows = ''.join('<tr><td class="mono">%s</td><td class="dim">%s</td></tr>'
                    % (esc(os.path.basename(a['p'])), fmt(a['b'])) for a in tbl)

    sample = ''
    sp = os.path.join(mp, 'sentence_10002.txt')
    if os.path.exists(sp):
        c = io.open(sp, encoding='utf-8', errors='replace').read()
        lines = [l for l in c.split('\n') if l.strip()][:14]
        sample = ''.join('<tr><td class="idx">%d</td><td class="mono">%s</td></tr>'
                         % (i + 1, esc(l[:150])) for i, l in enumerate(lines))

    body = '''<section>
<h2 class="sec">剧情文本</h2>
<div class="cnt">五区解密文本 · 制表符分隔：序号 / 说话人@类型 / 简中 / 繁中 / 日 / 韩 / 英</div>
<div class="note">
全部剧情以 <b>XOR 0xFF</b> 逐字节解密自客户端 BytesAsset。
主区域为 <b>%s</b>，共 <b>%d</b> 篇。
</div>%s
<div class="tbl-wrap" style="max-height:none"><table>
<thead><tr><th>区域</th><th>文本数</th><th>体积</th></tr></thead>
<tbody>%s</tbody></table></div>
</section>

<section>
<h2 class="sec">章节分布</h2>
<div class="cnt">%s · 按剧情编号自动分章</div>
%s
</section>

<section>
<h2 class="sec">五语对照表格</h2>
<div class="cnt">CSV / XLSX 导出</div>
<div class="tbl-wrap"><table>
<thead><tr><th>文件</th><th>体积</th></tr></thead>
<tbody>%s</tbody></table></div>
</section>

<section>
<h2 class="sec">文本样例</h2>
<div class="cnt">sentence_10002.txt 前 14 行</div>
<div class="tbl-wrap"><table>
<thead><tr><th>#</th><th>内容</th></tr></thead>
<tbody>%s</tbody></table></div>
</section>''' % (esc(main), len(mf), src_note, rrows, esc(main), ''.join(secs), trows, sample)

    meta = ('<b>剧情文本</b>：五区解密 · 18,037 行 · 五语对照<br>'
            '<b>格式</b>：制表符分隔，含说话人与语言类型标记')
    W('story.html', page('story.html', '剧情', "WITCH'S WEAPON / STORY",
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
            bn = os.path.basename(c['card'])
            for a in ASSETS:
                if a['p'].endswith(bn):
                    img = a['p']; break
        tsrc = ('thumbs/' + THUMBS[img]) if img and img in THUMBS and THUMBS[img] else (U(img) if img else '')
        thumb = ('<div class="thumb contain"><img src="%s" alt="%s" loading="lazy" '
                 'decoding="async"></div>' % (tsrc, esc(c['zh']))) if img else ''
        cv = ('<div class="sub">CV %s</div>' % esc(c['cv'])) if c['cv'] else ''
        cards.append('<article class="card">%s<div class="body">'
                     '<div class="ttl">%s</div><div class="sub">%s</div>%s'
                     '<div class="sub">台词 %d 句</div></div></article>'
                     % (thumb, esc(c['zh']), esc(c['en'] or c['jp']), cv, c['lines']))

    rows = []
    for c in sorted(chars, key=lambda x: -x['lines']):
        rows.append('<tr><td class="mono">%s</td><td>%s</td><td class="dim">%s</td>'
                    '<td class="dim">%s</td><td class="idx">%d</td></tr>'
                    % (esc(c['num']), esc(c['zh']), esc(c['full_zh'] or '—'),
                       esc(c['cv'] or '—'), c['lines']))

    body = '''<section>
<h2 class="sec">角色档案</h2>
<div class="cnt">%d 名 · 数据源：配置表 dictionary.csv</div>
<div class="note">
每名角色在 <code>dictionary.csv</code> 中有 <b>6 条记录</b>：
<code>101</code> 名字、<code>104</code> 武器描述、<code>105</code> 全名、<code>106</code> 自我介绍。
</div>
<div class="grid g3">%s</div>
</section>

<section>
<h2 class="sec">档案总表</h2>
<div class="cnt">按台词数排序</div>
<div class="tbl-wrap"><table>
<thead><tr><th>编号</th><th>名字</th><th>全名</th><th>CV</th><th>台词数</th></tr></thead>
<tbody>%s</tbody></table></div>
</section>''' % (len(chars), '\n'.join(cards), ''.join(rows))

    meta = ('<b>角色</b>：37 名完整档案 · 47 英灵<br>'
            '<b>内容</b>：立绘 · CV 语音 · 五语名称 · 全名 · 自我介绍 · 武器描述')
    W('characters.html', page('characters.html', '角色', "WITCH'S WEAPON / CHARACTERS",
                              'CHARACTER PROFILES · 37 ENTRIES', meta, body))

build_characters()

# ============================================================
# 音频
# ============================================================
def build_audio():
    A = [a for a in ASSETS if a['k'] == 'audio']
    groups = defaultdict(list)
    for a in A:
        p = a['p']
        if '/cv/' in p or 'CV' in p: g = 'CV 语音'
        elif 'BGM' in p or 'bgm' in p: g = 'BGM 原声'
        elif 'fight' in p: g = '战斗音效'
        elif 'MainUI' in p or '界面' in p: g = '界面音效'
        else: g = '其它'
        groups[g].append(a)

    secs = []
    for g in ['CV 语音', 'BGM 原声', '战斗音效', '界面音效', '其它']:
        items = groups.get(g, [])
        if not items: continue
        sz = sum(x['b'] for x in items)
        trk = ''.join('<div class="track" data-t="%s">'
                      '<div class="nm" title="%s">%s</div><div class="sz">%s</div>'
                      '<audio controls preload="none" src="%s"></audio></div>'
                      % (esc(os.path.basename(x['p'])), esc(x['p']),
                         esc(os.path.basename(x['p'])), fmt(x['b']), U(x['p']))
                      for x in sorted(items, key=lambda y: y['p']))
        secs.append('<section><h2 class="sec">%s</h2>'
                    '<div class="cnt">%d 个 · %s</div>'
                    '<div class="grid g3">%s</div></section>' % (g, len(items), fmt(sz), trk))

    tools = ('<div class="tools"><div class="tools-in">'
             '<label class="sr-only" for="q">搜索音频</label>'
             '<input id="q" type="search" placeholder="搜索音频文件名…（如 servant / bgm / fight）">'
             '<button type="button" id="clr">清除</button>'
             '<span class="stat" id="stat"></span></div></div>')

    body = ('<section><h2 class="sec">音频资源</h2>'
            '<div class="cnt">%d 个文件 · %s · 官方 sound.csv 登记 1,856 条</div>'
            '<div class="note">CV 语音按角色分目录（<code>servant100</code> ~ '
            '<code>servant137</code> 与 <code>player</code>）。全部可直接在线播放。</div>'
            '</section>%s' % (len(A), fmt(sum(x['b'] for x in A)), '\n'.join(secs)))

    meta = ('<b>音频</b>：%d 个 · %s<br>'
            '<b>分类</b>：CV 语音 / BGM 原声 / 战斗音效 / 界面音效'
            % (len(A), fmt(sum(x['b'] for x in A))))
    html = page('audio.html', '音频', "WITCH'S WEAPON / AUDIO",
                'AUDIO ARCHIVE · %d FILES' % len(A), meta, body, tools)
    html = html.replace('<script src="js/app.js"></script>',
                        '<script src="js/app.js"></script>\n'
                        '<script>bindFilter("q",".track","stat","data-t");'
                        'document.getElementById("clr").onclick=function(){'
                        'var i=document.getElementById("q");i.value="";'
                        'i.dispatchEvent(new Event("input"));i.focus();};</script>')
    W('audio.html', html)

build_audio()

# ============================================================
# 视频
# ============================================================
def build_video():
    V = sorted([a for a in ASSETS if a['k'] == 'video'], key=lambda x: -x['b'])
    cards = ''.join('<article class="card"><video controls preload="metadata" '
                    'src="%s"></video><div class="body">'
                    '<div class="ttl">%s</div><div class="sub">%s</div></div></article>'
                    % (U(v['p']), esc(os.path.basename(v['p'])), fmt(v['b'])) for v in V)

    body = ('<section><h2 class="sec">视频资源</h2>'
            '<div class="cnt">%d 个独立视频 · %s（已按内容去重）</div>'
            '<div class="note">各服 PV <b>完全不同</b> —— 日服、港澳台、韩服各有独占宣传片，'
            '是重要的版本差异证据。另有 7 个 <code>.ogv</code> 来自怀旧服 Godot 客户端。</div>'
            '<div class="grid g2">%s</div></section>'
            % (len(V), fmt(sum(v['b'] for v in V)), cards))

    meta = ('<b>视频</b>：%d 个 · %s<br>'
            '<b>内容</b>：PV 宣传片 · 剧情过场 · 各服独占版本'
            % (len(V), fmt(sum(v['b'] for v in V))))
    W('video.html', page('video.html', '视频', "WITCH'S WEAPON / VIDEO",
                         'VIDEO ARCHIVE · %d CLIPS' % len(V), meta, body))

build_video()

json.dump(written, io.open(os.path.join(SITE, '_w1.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
print('已写 %d 页' % len(written))
