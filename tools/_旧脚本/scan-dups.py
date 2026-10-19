# 全库重复情况盘点（不删除，只统计）
import io, os, sys, hashlib, json
from collections import defaultdict

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R = r'G:\project\其他\game'

# 按大小分组（快），再对同大小的算 hash
bysize = defaultdict(list)
n = 0
for dp, dn, fn in os.walk(R):
    # 跳过工具目录（第三方程序自带大量重复）
    if '\\tools\\' in dp + '\\':
        continue
    for f in fn:
        p = os.path.join(dp, f)
        try:
            s = os.path.getsize(p)
        except Exception:
            continue
        bysize[s].append(p)
        n += 1

print('扫描 %d 个文件（不含 tools/）' % n)
cand = {s: v for s, v in bysize.items() if len(v) > 1 and s > 0}
print('同大小候选组 %d 组, 涉及 %d 个文件' % (len(cand), sum(len(v) for v in cand.values())))

# 算 hash
dup = defaultdict(list)
for s, v in cand.items():
    for p in v:
        try:
            h = hashlib.md5()
            with open(p, 'rb') as fh:
                while True:
                    b = fh.read(1 << 20)
                    if not b: break
                    h.update(b)
            dup[h.hexdigest()].append(p)
        except Exception:
            pass

real = {h: v for h, v in dup.items() if len(v) > 1}
print()
print('=== 真实重复组 %d 组 ===' % len(real))
waste = 0
groups = []
for h, v in sorted(real.items(), key=lambda x: -os.path.getsize(x[1][0]) * (len(x[1]) - 1)):
    s = os.path.getsize(v[0])
    w = s * (len(v) - 1)
    waste += w
    groups.append({'hash': h, 'bytes': s, 'count': len(v), 'waste': w,
                   'files': [x.replace(R, '') for x in v]})

print('可回收空间 %.2f GB' % (waste / 1024 / 1024 / 1024))
print()
print('=== 浪费最多的 25 组 ===')
for g in groups[:25]:
    print('  %10.1f MB x%-3d  %s' % (g['bytes'] / 1024 / 1024, g['count'],
                                     os.path.basename(g['files'][0])))

json.dump(groups, io.open(os.path.join(R, 'tools', '_dup_groups.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
print()
print('已保存 tools/_dup_groups.json')

# 按顶层目录统计
top = defaultdict(lambda: [0, 0])
for g in groups:
    for f in g['files']:
        parts = f.strip('\\').split('\\')
        k = parts[0] if parts else '?'
        top[k][0] += 1
        top[k][1] += g['waste'] // g['count']
print()
print('=== 按顶层目录 ===')
for k, (c, w) in sorted(top.items(), key=lambda x: -x[1][1]):
    print('  %-24s %6d 个  %8.1f MB' % (k[:24], c, w / 1024 / 1024))
