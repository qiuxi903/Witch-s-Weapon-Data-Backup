# 校验站点：所有静态引用是否都能在磁盘上找到
#
#   python tools/check-deploy.py            # 默认检查 部署/
#   python tools/check-deploy.py 网站       # 检查归档版（引用会跑到仓库根目录）
#
# 只检查真正的 URL 属性（src/href/data-src/data-full/poster/srcset）
# 与 CSS 里的 url()，不会把 alt/title/内联样式误判为引用。
import io, os, re, sys, urllib.parse
from collections import defaultdict

R = r'G:\project\其他\game'
D = os.path.join(R, sys.argv[1] if len(sys.argv) > 1 else '部署')
# 引用可能指向站点目录之外（归档版用 ../ 引用仓库里的原始素材），
# 这类路径以 REPO 为根解析。
REPO = R
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# 只认这些属性名（含 data-* 资源属性）
URL_ATTR = re.compile(
    r'\b(src|href|data-src|data-full|poster|data-poster|data-orig)\s*=\s*"([^"]*)"',
    re.I)
SRCSET = re.compile(r'\bsrcset\s*=\s*"([^"]*)"', re.I)
CSSURL = re.compile(r'(?<![A-Za-z])url\(\s*[\'"]?([^\'")]+)[\'"]?\s*\)', re.I)

SKIP_PREFIX = ('http://', 'https://', '//', 'data:', 'mailto:', 'javascript:',
               '#', 'about:', 'blob:')


def norm(u, page):
    """把引用规范化成绝对磁盘路径；返回 None 表示不需要检查"""
    u = u.strip()
    if not u or u.startswith(SKIP_PREFIX):
        return None
    # 去掉查询串与锚点
    u = u.split('#')[0].split('?')[0]
    if not u:
        return None
    # 跳过明显的模板/动态拼接
    if any(c in u for c in "'+ ") or u.endswith('+') or '{' in u:
        return None
    u = urllib.parse.unquote(u)
    if u.startswith('/'):
        # 站点绝对路径
        return os.path.normpath(os.path.join(D, u.lstrip('/').replace('/', os.sep)))
    # 相对页面所在目录解析；../ 会自然逃出站点目录（归档版就是这样引用仓库素材的）
    base = os.path.dirname(page)
    return os.path.normpath(os.path.join(D, base, u.replace('/', os.sep)))


def main():
    pages = sorted(f for f in os.listdir(D) if f.endswith('.html'))
    missing = defaultdict(list)
    checked = 0
    by_ext = defaultdict(int)

    for page in pages:
        txt = io.open(os.path.join(D, page), encoding='utf-8',
                      errors='replace').read()
        urls = [m.group(2) for m in URL_ATTR.finditer(txt)]
        for m in SRCSET.finditer(txt):
            urls += [p.strip().split(' ')[0] for p in m.group(1).split(',')]
        for m in CSSURL.finditer(txt):        # 内联 style 里的 url()
            urls.append(m.group(1))
        for u in urls:
            rel = norm(u, page)
            if rel is None:
                continue
            checked += 1
            by_ext[os.path.splitext(rel)[1].lower()] += 1
            if not os.path.exists(rel):
                missing[page].append((u, rel))

    # CSS 文件里的 url()
    css = os.path.join(D, 'css', 'style.css')
    if os.path.exists(css):
        txt = io.open(css, encoding='utf-8', errors='replace').read()
        for m in CSSURL.finditer(txt):
            rel = norm(m.group(1), 'css/style.css')
            if rel is None:
                continue
            checked += 1
            by_ext[os.path.splitext(rel)[1].lower()] += 1
            if not os.path.exists(rel):
                missing['css/style.css'].append((m.group(1), rel))

    print('=== 引用校验：%s ===' % D)
    print('  页面 %d 个，检查引用 %d 处' % (len(pages), checked))
    miss = sum(len(v) for v in missing.values())
    if miss:
        print('  缺失 %d 处：' % miss)
        for p, ms in sorted(missing.items()):
            print('    %s（%d）' % (p, len(ms)))
            for u, rel in ms[:6]:
                print('       %s' % u)
    else:
        print('  ✓ 全部引用均可在磁盘上找到')
    print()
    print('  引用类型分布：')
    for e, n in sorted(by_ext.items(), key=lambda x: -x[1])[:12]:
        print('    %-10s %7d' % (e or '(无)', n))

    # 关键页面自检
    deploy = os.path.basename(D) == '部署'
    print()
    print('=== 关键文件存在性 ===')
    keys = ['index.html', 'css/style.css', 'js/app.js', 'logo.png',
            'data/cfg-huijiu.js', 'data/zip/huijiu.zip']
    for k in keys:
        p = os.path.join(D, k.replace('/', os.sep))
        print('  %-24s %s' % (k, 'OK' if os.path.exists(p) else '缺失'))
    if deploy:
        probes = ['files/06_美术素材/01_角色卡面/Servant00_Image_100.webp',
                  'files/07_音频资源/CV语音/player/player_01.ogg',
                  'files/07_音频资源/CV语音/player/player_01.mp3',
                  'thumbs/11c932a9e8203398.webp']
        for k in probes:
            p = os.path.join(D, k.replace('/', os.sep))
            print('  %-58s %s' % (k, 'OK' if os.path.exists(p) else '缺失'))
    else:
        # 归档版：素材在站点目录外面，以仓库根为基准
        probes = ['06_美术素材/01_角色卡面/Servant00_Image_100.png',
                  '07_音频资源/CV语音/player/player_01.wav',
                  '08_视频资源/pv.mp4']
        for k in probes:
            p = os.path.join(REPO, k.replace('/', os.sep))
            print('  %-58s %s' % (k, 'OK' if os.path.exists(p) else '缺失'))
    return 1 if miss else 0


if __name__ == '__main__':
    sys.exit(main())
