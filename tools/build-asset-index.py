# 全库资产索引：为网站生成可引用的清单
import io, os, sys, json, re, hashlib
from collections import defaultdict, Counter

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R = r'G:\project\其他\game'
OUT = os.path.join(R, 'tools', '_asset_index.json')

SKIP = ['_重复文件_待删', 'tools', '_旧版HTML_留念', '网站']

IMG = ('.png', '.jpg', '.jpeg', '.webp', '.gif', '.bmp')
AUD = ('.mp3', '.wav', '.ogg', '.m4a', '.aac')
VID = ('.mp4', '.ogv', '.webm', '.avi')
DOC = ('.md', '.txt', '.csv', '.xlsx', '.json', '.html', '.pdf')
CODE = ('.lua', '.shader', '.cs', '.py', '.js', '.mjs', '.bat', '.ps1')
PKG = ('.apk', '.xapk', '.obb', '.zip', '.7z', '.rar')

def kind(f):
    e = os.path.splitext(f)[1].lower()
    if e in IMG: return 'image'
    if e in AUD: return 'audio'
    if e in VID: return 'video'
    if e in PKG: return 'package'
    if e in CODE: return 'code'
    if e in DOC: return 'doc'
    return 'other'

idx = []
n = 0
for dp, dn, fn in os.walk(R):
    rel_dp = os.path.relpath(dp, R)
    top = rel_dp.split(os.sep)[0]
    if top in SKIP:
        dn[:] = []
        continue
    for f in fn:
        p = os.path.join(dp, f)
        try:
            s = os.path.getsize(p)
        except Exception:
            continue
        rel = os.path.relpath(p, R).replace('\\', '/')
        idx.append({'p': rel, 'b': s, 'k': kind(f), 't': top})
        n += 1
        if n % 20000 == 0:
            print('  %d ...' % n)

print('索引 %d 个文件' % len(idx))

# 统计
byk = Counter(x['k'] for x in idx)
byt = Counter(x['t'] for x in idx)
print()
print('=== 按类型 ===')
for k, v in byk.most_common():
    sz = sum(x['b'] for x in idx if x['k'] == k)
    print('  %-10s %6d 个 %9.1f MB' % (k, v, sz / 1024 / 1024))
print()
print('=== 按目录 ===')
for k, v in byt.most_common():
    sz = sum(x['b'] for x in idx if x['t'] == k)
    print('  %-20s %6d 个 %9.1f MB' % (k[:20], v, sz / 1024 / 1024))

json.dump(idx, io.open(OUT, 'w', encoding='utf-8'), ensure_ascii=False, separators=(',', ':'))
print()
print('已保存 %s (%.1f MB)' % (OUT, os.path.getsize(OUT) / 1024 / 1024))
