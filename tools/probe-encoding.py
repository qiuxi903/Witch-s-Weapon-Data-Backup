# 探测线上服务器上中文目录名的真实字节编码
#
#   python tools/probe-encoding.py https://witchweapon.hutaomu.cn
#
# 背景：/files/assets/img/cover.webp（纯 ASCII 路径）返回 200，
# 而 /files/06_美术素材/... 各种编码都 404。这里把所有可能的编码/二次编码
# 组合都试一遍，定位磁盘上的真实字节。
import json, sys, urllib.parse, urllib.request

BASE = (sys.argv[1] if len(sys.argv) > 1
        else 'https://witchweapon.hutaomu.cn').rstrip('/')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

NAME = '06_美术素材'
TAIL = '/01_角色卡面/Servant00_Image_100.webp'


def variants(s):
    """生成一份名字的各种可能落地形态"""
    out = {}
    out['utf-8（原样）'] = s.encode('utf-8')
    for enc in ('gbk', 'gb18030', 'big5', 'shift_jis', 'cp1252', 'latin-1'):
        try:
            raw = s.encode(enc)
        except Exception:
            continue
        out[enc] = raw
        # 二次编码：raw 被当成 latin-1 / cp1252 读进来，再按 utf-8 存
        for readback in ('latin-1', 'cp1252'):
            try:
                out['%s→%s→utf-8' % (enc, readback)] = \
                    raw.decode(readback).encode('utf-8')
            except Exception:
                pass
    return out


def head(url):
    req = urllib.request.Request(url, method='GET',
                                 headers={'User-Agent': 'Mozilla/5.0',
                                          'Range': 'bytes=0-99'})
    try:
        with urllib.request.urlopen(req, timeout=20) as r:
            return r.status
    except urllib.error.HTTPError as e:
        return e.code
    except Exception as e:
        return 'ERR:%s' % e


def enc_path(p):
    return '/'.join(urllib.parse.quote(x, safe='') for x in p.split('/'))


print('=== 探测 %s 在服务器磁盘上的真实字节 ===' % NAME)
print()
hits = []
for label, raw in variants(NAME).items():
    # 目录本身
    url_dir = BASE + '/files/' + urllib.parse.quote_from_bytes(raw, safe='') + '/'
    st_dir = head(url_dir)
    # 目录 + 后面的中文子目录 + ASCII 文件名
    tail_raw = '/'.join(
        urllib.parse.quote_from_bytes(x.encode('utf-8'), safe='')
        for x in TAIL.strip('/').split('/'))
    url_file = url_dir + tail_raw
    st_file = head(url_file)
    mark = '  <<< 命中' if st_dir == 200 or st_file == 200 else ''
    print('  %-28s 目录 %-5s 文件 %-5s%s' % (label, st_dir, st_file, mark))
    if st_dir == 200 or st_file == 200:
        hits.append((label, url_file))

print()
if hits:
    print('  命中：')
    for label, u in hits:
        print('    %s -> %s' % (label, u))
else:
    print('  所有编码变体都 404 —— 说明这些中文目录很可能根本没上传到服务器。')

# 对照：确认 files/ 本身与 files/assets/ 的状态
print()
print('=== 对照 ===')
for p in ['/files/', '/files/assets/', '/files/assets/img/cover.webp',
          '/thumbs/', '/thumbs/00031ff9ec8a8102.webp',
          '/data/zip/huijiu.zip', '/css/style.css']:
    print('  %-42s %s' % (p, head(BASE + p)))
