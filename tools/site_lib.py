# 网站公共库 v4 —— 左侧竖排导航 + 游戏 LOGO + 亮/暗主题
import io, os, sys, json, csv, re, urllib.parse

R    = r'G:\project\其他\game'
# 部署模式：WW_DEPLOY=1 时输出到「部署/」，素材前缀从 ../ 改成 files/
DEPLOY = os.environ.get('WW_DEPLOY') == '1'
SITE   = os.path.join(R, os.environ.get('WW_SITE',
                                        '部署' if DEPLOY else '网站'))
ASSET  = 'files' if DEPLOY else '..'

try:
    DMAP = (json.load(io.open(os.path.join(R, 'tools', '_deploy_map.json'),
                              encoding='utf-8')) if DEPLOY else {})
except Exception:
    DMAP = {}

ASSETS = json.load(io.open(os.path.join(R, 'tools', '_asset_index.json'), encoding='utf-8'))
# 排除"扩展名是图片但内容是 HTML 错误页"的伪图片
try:
    _BAD = set(json.load(io.open(os.path.join(R, 'tools', '_bad_images.json'),
                                 encoding='utf-8')))
    if _BAD:
        ASSETS = [a for a in ASSETS if a['p'] not in _BAD]
except Exception:
    _BAD = set()

try:
    IMETA = json.load(io.open(os.path.join(R, 'tools', '_image_meta.json'), encoding='utf-8'))
except Exception:
    IMETA = {}
try:
    THUMBS = json.load(io.open(os.path.join(R, 'tools', '_thumb_map.json'), encoding='utf-8'))
except Exception:
    THUMBS = {}

# 游戏官方 LOGO（来自官网 img/top/logo.png）
LOGO_SRC = '02_客户端解包/网络资源/01_官网witchs-weapon/img/top/logo.png'

# 页面清单：(文件, 名称, 序号, 数量标签)
PAGES = [
    ('index.html',      '首页',      '01', ''),
    ('story.html',      '剧情',      '02', '7 章'),
    ('characters.html', '角色',      '03', '37'),
    ('art.html',        '美术',      '04', '7,424'),
    ('manga.html',      '四格漫画',  '05', '45 篇'),
    ('audio.html',      '音频',      '06', '1,828'),
    ('video.html',      '视频',      '07', '26'),
    ('config.html',     '配置表',    '08', '5 服'),
    ('system.html',     '系统设计',  '09', ''),
    ('news.html',       '官网公告',  '10', '102'),
    ('relics.html',     '开发遗迹',  '11', '1,184'),
    ('archive.html',    '全部文件',  '12', '44,196'),
]


def _q(p):
    """按路径分段做 URL 编码（保留 /）"""
    return '/'.join(urllib.parse.quote(x) for x in p.split('/'))


def U(p):
    """素材 URL。部署模式下查映射表，指向 files/ 下转换后的文件。"""
    k = p.replace('\\', '/')
    if DEPLOY:
        v = DMAP.get(k)
        if v:
            return _q(v[0])
    return ASSET + '/' + _q(k)


def UALT(p):
    """第二格式 URL（音频的 mp3 回退），没有则返回 None"""
    if not DEPLOY:
        return None
    v = DMAP.get(p.replace('\\', '/'))
    return _q(v[1]) if v and len(v) > 1 and v[1] else None


def T(relpath):
    """缩略图 URL（无则回退原图）"""
    t = THUMBS.get(relpath)
    if not t:
        return U(relpath)
    if DEPLOY:
        t = os.path.splitext(t)[0] + '.webp'
    return 'thumbs/' + t


def esc(s):
    return (s or '').replace('&', '&amp;').replace('<', '&lt;') \
                    .replace('>', '&gt;').replace('"', '&quot;')


def fmt(n):
    if n >= 1024 ** 3: return '%.2f GB' % (n / 1024 ** 3)
    if n >= 1024 ** 2: return '%.1f MB' % (n / 1024 ** 2)
    if n >= 1024:      return '%.0f KB' % (n / 1024)
    return '%d B' % n


def logo_url():
    """站点内的 LOGO 副本（构建时复制到 网站/logo.png）"""
    return 'logo.png'


def sidebar(cur):
    """左侧竖排导航（可收起）"""
    items = []
    for h, t, no, ct in PAGES:
        cls = ' class="on"' if h == cur else ''
        aria = ' aria-current="page"' if h == cur else ''
        cnt = ('<span class="ct">%s</span>' % esc(ct)) if ct else ''
        items.append('<a href="%s"%s%s title="%s"><span class="no">%s</span>'
                     '<span class="lb">%s</span>%s</a>'
                     % (h, cls, aria, esc(t), no, esc(t), cnt))
    return (
        '<a class="skip" href="#main">跳到主要内容</a>'
        '<aside class="side" id="side">'
        '<div class="side-scroll">'
        '<div class="side-hd">'
        '<img class="mini-logo" src="logo.png" alt="魔女兵器">'
        '<img class="side-logo" src="%s" alt="魔女兵器 Witch\'s Weapon">'
        '<div class="side-sub">Complete Game Archive<br>5 Regions · 2018–2024</div>'
        '</div>'
        '<nav class="side-nav" aria-label="主导航">%s</nav>'
        '<div class="side-ft">'
        '<button class="collapse-btn" id="collapseBtn" type="button" '
        'aria-expanded="true" aria-label="收起侧边栏">'
        '<span class="ar" id="collapseAr">«</span>'
        '<span class="full">收起侧边栏</span></button>'
        '<button class="theme-btn" id="themeBtn" type="button" '
        'aria-label="切换深浅色主题" aria-pressed="false">'
        '<span class="ic" id="themeIc">◑</span>'
        '<span class="tx" id="themeTx">亮色模式</span>'
        '</button>'
        '</div></div></aside>'
        '<div class="topbar">'
        '<img src="%s" alt="魔女兵器">'
        '<span class="sp"></span>'
        '<button class="top-theme" id="topTheme" type="button" '
        'aria-label="切换深浅色主题" aria-pressed="false">'
        '<span id="topThemeIc">◑</span></button>'
        '<button class="menu-btn" id="menuBtn" type="button" '
        'aria-label="打开导航" aria-expanded="false">目录</button>'
        '</div>'
        % (logo_url(), ''.join(items), logo_url()))


FOOT = '''<footer><div class="foot-in">
<b>《魔女兵器》 Witch's Weapon 收藏档案</b><br>
游戏开发：北京水琴铃（WaterBell）· 日服发行：EXNOA LLC / SUIKINREI<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途，不作任何商业使用。
</div></footer>
</div>
<button id="top" type="button" aria-label="返回顶部" title="返回顶部">↑</button>
<script src="js/app.js"></script>
</body></html>'''


def page(fname, title, eyebrow, en, meta, body, tools=''):
    """页面骨架：左侧导航 + 右侧内容"""
    return ('<!DOCTYPE html>\n<html lang="zh-CN" class="no-js">\n<head><meta charset="UTF-8">\n'
            '<script>(function(){var d=document.documentElement;d.className="js";'
            'try{var t=localStorage.getItem("ww-theme");'
            'if(t==="light"){d.setAttribute("data-theme","light")}'
            'if(localStorage.getItem("ww-mini")==="1")'
            '{d.setAttribute("data-mini","1")}}catch(e){}})();</script>\n'
            '<meta name="viewport" content="width=device-width, initial-scale=1, '
            'viewport-fit=cover">\n'
            '<meta name="theme-color" content="#07080b" media="(prefers-color-scheme:dark)">\n'
            '<meta name="theme-color" content="#faf9f7" media="(prefers-color-scheme:light)">\n'
            '<meta name="color-scheme" content="dark light">\n'
            '<title>%s · 魔女兵器收藏档案</title>\n'
            '<meta name="description" content="《魔女兵器》Witch\'s Weapon 停服游戏完整档案 —— %s">\n'
            '<link rel="icon" href="logo.png">\n'
            '<link rel="stylesheet" href="css/style.css">\n</head><body>\n%s\n'
            '<div class="wrap">\n'
            '<main id="main">\n'
            '<header class="phead">\n'
            '<div class="kick">%s</div>\n'
            '<h1>%s</h1>\n'
            '<div class="en">%s</div>\n'
            '<div class="desc">%s</div>\n'
            '</header>\n%s\n%s\n</main>\n%s'
            % (esc(title), esc(title), sidebar(fname), esc(eyebrow),
               esc(title), esc(en), meta, tools, body, FOOT))


# ============================================================
#  角色数据
# ============================================================
_CHARS = None


def chars():
    """读取角色设定集，并为每个角色匹配立绘（卡面）"""
    global _CHARS
    if _CHARS is not None:
        return _CHARS
    data = json.load(io.open(os.path.join(R, '角色设定集.json'), encoding='utf-8'))
    card_map = {}
    for a in ASSETS:
        if a['k'] != 'image':
            continue
        if not a['p'].startswith('06_美术素材/01_角色卡面/'):
            continue
        b = os.path.basename(a['p'])
        m = re.match(r'Servant00_Image_(\d+)(?:_(\d+))?\.png$', b)
        if m:
            num = m.group(1)
            idx = int(m.group(2) or 1)
            card_map.setdefault(num, []).append((idx, a['p']))
    av_map = {}
    for a in ASSETS:
        if a['k'] != 'image':
            continue
        if not a['p'].startswith('06_美术素材/12_角色头像/'):
            continue
        b = os.path.basename(a['p'])
        m = re.search(r'(\d{3})', b)
        if m:
            av_map.setdefault(m.group(1), a['p'])
    out = []
    for c in data:
        num = str(c.get('num', '')).strip()
        cards = sorted(card_map.get(num, []))
        c = dict(c)
        c['num'] = num
        c['portrait'] = cards[0][1] if cards else None
        c['portraits'] = [p for _, p in cards]
        c['avatar'] = av_map.get(num)
        out.append(c)
    _CHARS = out
    return out


# ============================================================
#  剧情章节数据
# ============================================================
_STORY = None


def story_chapters():
    """读取已分好的章节 CSV，返回 [{name, lines, files, speakers}]"""
    global _STORY
    if _STORY is not None:
        return _STORY
    d = os.path.join(R, '05_剧情表格')
    order = ['序章·系统与引导', '第一章·人生的终结、命运的开始',
             '第二章·想守护的她、被守护的你', '第三章·神魂的治愈、身体的诅咒',
             '活动剧情', '支线剧情', '测试与其它']
    chapters = []
    if not os.path.isdir(d):
        _STORY = chapters
        return chapters
    for f in sorted(os.listdir(d)):
        if not f.endswith('.csv') or not f.startswith('分章节_'):
            continue
        name = f[len('分章节_'):-len('.csv')]
        fp = os.path.join(d, f)
        rows = list(csv.reader(io.open(fp, encoding='utf-8', errors='replace')))
        if len(rows) < 2:
            continue
        hdr = [h.lstrip('\ufeff') for h in rows[0]]
        try:
            i_file = hdr.index('文件'); i_sp = hdr.index('说话人')
            i_zh = hdr.index('简体中文'); i_jp = hdr.index('日本語')
            i_tw = hdr.index('繁體中文')
        except ValueError:
            continue
        lines = []
        for r in rows[1:]:
            if len(r) <= max(i_file, i_sp, i_zh):
                continue
            zh = r[i_zh].strip()
            if not zh:
                continue
            lines.append({
                'file': r[i_file].strip(),
                'who': r[i_sp].strip(),
                'zh': zh,
                'tw': r[i_tw].strip() if len(r) > i_tw else '',
                'jp': r[i_jp].strip() if len(r) > i_jp else '',
            })
        if not lines:
            continue
        files = sorted(set(l['file'] for l in lines))
        speakers = sorted(set(l['who'] for l in lines
                              if l['who'] and l['who'] != 'N/A'))
        chapters.append({
            'name': name, 'lines': lines, 'files': files,
            'speakers': speakers,
        })

    def key(c):
        try:
            return (order.index(c['name']), '')
        except ValueError:
            return (len(order), c['name'])
    chapters.sort(key=key)
    _STORY = chapters
    return chapters


CHAP_BG = {
    '序章·系统与引导':              'Story00_Main_01',
    '第一章·人生的终结、命运的开始':  'Story00_Main_02',
    '第二章·想守护的她、被守护的你':  'Story00_Main_03',
    '第三章·神魂的治愈、身体的诅咒':  'Story00_Main_04',
    '活动剧情':                     'Activity_Story_001',
    '支线剧情':                     'Story00_Independence_01',
    '测试与其它':                   'Story00_Independence_03',
}

_IMGIDX = None


def find_image(name):
    """按文件名（不含扩展名）找素材，返回相对路径"""
    global _IMGIDX
    if not name:
        return None
    if _IMGIDX is None:
        _IMGIDX = {}
        for a in ASSETS:
            if a['k'] == 'image':
                _IMGIDX.setdefault(os.path.basename(a['p']).lower(), a['p'])
    low = name.lower()
    for ext in ('.png', '.jpg', '.jpeg'):
        if low + ext in _IMGIDX:
            return _IMGIDX[low + ext]
    for k, v in _IMGIDX.items():
        if low in k:
            return v
    return None
