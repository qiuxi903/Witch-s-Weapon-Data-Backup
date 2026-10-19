# 构建网站全部页面
import io, os, sys, json, re, csv, shutil
from collections import defaultdict, OrderedDict, Counter

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
SITE = os.path.join(R, '网站')
ASSETS = json.load(io.open(os.path.join(R, 'tools', '_asset_index.json'), encoding='utf-8'))

def U(p):
    """网站 -> 仓库根的相对 URL"""
    return '../' + p.replace('\\', '/')

def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')

def fmt(n):
    if n >= 1024**3: return '%.2f GB' % (n / 1024**3)
    if n >= 1024**2: return '%.1f MB' % (n / 1024**2)
    if n >= 1024: return '%.0f KB' % (n / 1024)
    return '%d B' % n

PAGES = [
    ('index.html',      '首页'),
    ('story.html',      '剧情'),
    ('characters.html', '角色'),
    ('config.html',     '配置表'),
    ('audio.html',      '音频'),
    ('video.html',      '视频'),
    ('art.html',        '美术'),
    ('manga.html',      '四格漫画'),
    ('news.html',       '官网公告'),
    ('system.html',     '系统设计'),
    ('relics.html',     '开发遗迹'),
    ('archive.html',    '全部文件'),
]

def nav(cur):
    items = ''.join('<a href="%s"%s>%s</a>' % (h, ' class="on"' if h == cur else '', t)
                    for h, t in PAGES)
    return ('<nav class="nav"><div class="nav-in">'
            '<span class="brand">魔女兵器 / ARCHIVE</span>%s</div></nav>' % items)

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

FOOT = '''<footer><div class="foot-in">
<b>《魔女兵器》 Witch's Weapon 收藏档案</b><br>
游戏开发：北京水琴铃（WaterBell）· 日服发行：EXNOA LLC / SUIKINREI<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途，不作任何商业使用。<br>
配置表与剧情解密方式：<code>XOR 0xFF</code> · 网站构建于 2026-10-08
</div></footer>
<script src="js/app.js"></script>
</body></html>'''

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
    n_audio = byk.get('audio', 0)
    n_img = byk.get('image', 0)
    n_vid = byk.get('video', 0)

    # 章节卡片
    cards = [
        ('story.html', '剧情', '221 个文本 · 18,037 行 · 五语对照',
         '04_剧情文本/国服v2.0.1/sentence_10001.txt', ''),
        ('characters.html', '角色', '37 名完整档案 · 47 英灵 · 立绘 + CV',
         '06_美术素材/01_角色卡面/', 'dir'),
        ('config.html', '配置表', '95 张表 · 23,946 行 · 可搜索',
         '', ''),
        ('audio.html', '音频', '1,828 个 · CV / BGM / 音效',
         '', ''),
        ('video.html', '视频', '26 个独立视频 · 含各服独占 PV',
         '08_视频资源/', 'dir'),
        ('art.html', '美术', '5,808 个 · 19 类分类归档',
         '06_美术素材/', 'dir'),
        ('manga.html', '四格漫画', '45 篇中文翻译 · 220 张图',
         '02_客户端解包/网络资源/13_官网日服witchs-weapon.net/cartoon_img/0802_01.png', ''),
        ('news.html', '官网公告', '103 条日文原文 · 2018-12 ~ 2019-11',
         '', ''),
        ('system.html', '系统设计', '36 活动类型 · 8,425 类 · Lua 还原',
         '', ''),
        ('relics.html', '开发遗迹', '未上线剧情 · 保留场景 · 废弃资源',
         '', ''),
        ('archive.html', '全部文件', '44,197 个文件完整索引',
         '', ''),
    ]

    # 给卡片找配图
    def pick_img(path, isdir):
        if not path: return ''
        if isdir:
            for a in ASSETS:
                if a['p'].startswith(path) and a['k'] == 'image':
                    return a['p']
            return ''
        return path if os.path.exists(os.path.join(R, path)) else ''

    ch = []
    for href, ttl, sub, imgp, kind in cards:
        ip = pick_img(imgp, kind == 'dir')
        thumb = ('<div class="thumb"><img src="%s" loading="lazy" alt="" class="zoom"></div>' % U(ip)) if ip else ''
        ch.append('<a class="card" href="%s">%s<div class="body">'
                  '<div class="ttl">%s</div><div class="sub">%s</div></div></a>'
                  % (href, thumb, esc(ttl), esc(sub)))

    body = '''<section>
<h2 class="bar">收藏概览</h2>
<div class="cnt">数据统计（不含重复副本与工具）</div>
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
<h2 class="bar">浏览</h2>
<div class="cnt">点击进入各专题</div>
<div class="grid g2">%s</div>
</section>

<section>
<h2 class="bar">关于这份档案</h2>
<div class="note">
《魔女兵器》（Witch's Weapon）是北京水琴铃（WaterBell）开发的横版动作手游，
日服由 EXNOA / SUIKINREI 发行。国服已于 <b>2024-08-17 00:00</b> 停服。
</div>
<p>本档案在停服后从客户端完整提取了游戏资源，包括：</p>
<table>
<thead><tr><th>类别</th><th>内容</th><th>规模</th></tr></thead>
<tbody>
<tr><td class="mono">安装包</td><td>五区 APK/XAPK + 怀旧服客户端</td><td class="dim">16 个 / 7.72 GB</td></tr>
<tr><td class="mono">客户端解包</td><td>五区完整解包 + 33,169 个 AssetBundle</td><td class="dim">35,517 个 / 9.20 GB</td></tr>
<tr><td class="mono">剧情文本</td><td>五语对照，XOR 0xFF 解密</td><td class="dim">444 个 / 10.7 MB</td></tr>
<tr><td class="mono">配置表</td><td>95 张表全部解密</td><td class="dim">109 个 / 7.4 MB</td></tr>
<tr><td class="mono">美术素材</td><td>19 类分类归档</td><td class="dim">5,808 个 / 1.25 GB</td></tr>
<tr><td class="mono">音频</td><td>CV / BGM / 音效</td><td class="dim">1,828 个 / 1.37 GB</td></tr>
<tr><td class="mono">视频</td><td>含日服/港澳台/韩服独占 PV</td><td class="dim">26 个 / 285 MB</td></tr>
</tbody>
</table>
</section>

<section>
<h2 class="bar">技术说明</h2>
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
                 '{:,}'.format(n_img), '{:,}'.format(n_audio), '{:,}'.format(n_vid),
                 '\n'.join(ch))

    meta = ('<b>《魔女兵器》</b>（Witch\'s Weapon）· 北京水琴铃开发 · 国服 2024-08-17 停服<br>'
            '<b>本档案</b>：从五区客户端完整提取的游戏资源，含剧情、配置表、美术、音频、视频')
    W('index.html', page('index.html', '魔女兵器收藏档案', 'WITCH\'S WEAPON / ARCHIVE',
                         'COMPLETE GAME ARCHIVE · 5 REGIONS', meta, body))

build_index()
print('首页完成')
json.dump(written, io.open(os.path.join(SITE, '_written.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
