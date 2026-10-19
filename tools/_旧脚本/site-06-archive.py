# 构建「全部文件」页 —— 引用索引里的每一个文件
import io, os, sys, json, re
from collections import defaultdict, Counter

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

# 按顶层目录分组
tops = defaultdict(list)
for a in ASSETS:
    tops[a['t']].append(a)

TOPNAME = {
 '01_安装包': '安装包', '02_客户端解包': '客户端解包', '03_配置表': '配置表',
 '04_剧情文本': '剧情文本', '05_剧情表格': '剧情表格', '06_美术素材': '美术素材',
 '07_音频资源': '音频资源', '08_视频资源': '视频资源', '09_着色器': '着色器',
 '10_Lua脚本': 'Lua 脚本', '11_官网公告': '官网公告', 'assets': '网站素材',
 '.': '根目录文档', '音乐原声': '音乐原声',
}

KINDNAME = {'image':'图片','audio':'音频','video':'视频','doc':'文档',
            'code':'代码','package':'安装包','other':'其它'}

# 生成表格行（全部文件）
rows = []
for a in sorted(ASSETS, key=lambda x: x['p']):
    k = KINDNAME.get(a['k'], '其它')
    rows.append('<tr data-t="%s"><td class="mono">%s</td><td class="idx">%s</td>'
                '<td class="idx">%s</td><td class="dim">%s</td></tr>'
                % (esc(a['p'].lower()), esc(a['p']), k, fmt(a['b']), esc(a['t'])))

# 目录概览
ov = []
for t, items in sorted(tops.items(), key=lambda x: -sum(a['b'] for a in x[1])):
    sz = sum(a['b'] for a in items)
    kc = Counter(a['k'] for a in items)
    detail = ' · '.join('%s %d' % (KINDNAME.get(k, k), v) for k, v in kc.most_common(4))
    ov.append('<tr><td class="mono">%s</td><td>%s</td><td class="idx">%d</td>'
              '<td class="idx">%s</td><td class="dim">%s</td></tr>'
              % (esc(t), esc(TOPNAME.get(t, t)), len(items), fmt(sz), esc(detail)))

tools = ('<div class="tools"><div class="tools-in">'
         '<input id="q" placeholder="搜索文件路径（多关键词空格分隔）...">'
         '<button onclick="document.getElementById(\'q\').value=\'\';'
         'bindTable(\'q\',\'tbl\',\'stat\')">清除</button>'
         '<span class="stat" id="stat"></span></div></div>')

body = '''<section>
<h2 class="bar">目录概览</h2>
<div class="cnt">%d 个文件 · %s</div>
<div class="scroll" style="max-height:none"><table>
<thead><tr><th>目录</th><th>说明</th><th>文件数</th><th>体积</th><th>构成</th></tr></thead>
<tbody>%s</tbody></table></div></section>

<section>
<h2 class="bar">全部文件索引</h2>
<div class="cnt">%d 个文件完整清单（不含隔离区与工具）</div>
<div class="note">这是本档案的<b>完整文件清单</b> —— 每一个提取出来的文件都在这里。
用上方搜索框可以按路径筛选。</div>
<div class="scroll" style="max-height:720px"><table id="tbl">
<thead><tr><th>路径</th><th>类型</th><th>大小</th><th>所属</th></tr></thead>
<tbody>%s</tbody></table></div></section>''' % (
    len(ASSETS), fmt(sum(a['b'] for a in ASSETS)), '\n'.join(ov),
    len(rows), '\n'.join(rows))

meta = ('<b>全部文件</b>：%d 个文件 · %s<br>'
        '<b>说明</b>：本档案的完整清单，含所有提取出的资源'
        ) % (len(ASSETS), fmt(sum(a['b'] for a in ASSETS)))

html = ('<!DOCTYPE html>\n<html lang="zh-CN"><head><meta charset="UTF-8">\n'
        '<meta name="viewport" content="width=device-width, initial-scale=1">\n'
        '<title>全部文件 · 魔女兵器收藏</title>\n'
        '<link rel="stylesheet" href="css/style.css">\n</head><body>\n%s\n'
        '<header class="hero"><div class="hero-in">\n'
        '<div class="eyebrow">WITCH\'S WEAPON / FILE INDEX</div>\n'
        '<h1>全部文件</h1>\n'
        '<div class="en">COMPLETE FILE INDEX · %s FILES</div>\n'
        '<div class="meta">%s</div>\n</div></header>\n%s\n<main>\n%s\n</main>\n%s'
        '<script>bindTable("q","tbl","stat");</script>\n</body></html>'
        % (nav('archive.html'), '{:,}'.format(len(ASSETS)), meta, tools, body, FOOT))

p = os.path.join(SITE, 'archive.html')
io.open(p, 'w', encoding='utf-8').write(html)
print('  archive.html       %s' % fmt(os.path.getsize(p)))
