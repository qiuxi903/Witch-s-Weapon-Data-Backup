# 对比怀旧服 v128 与国服 v2.0.1，找出怀旧服独有的资源
import io, os, sys, json, hashlib

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

NEW = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle'
CN  = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle'

def scan(root):
    """返回 {相对路径: (大小, 完整路径)}"""
    d = {}
    for dp, dn, fn in os.walk(root):
        for f in fn:
            p = os.path.join(dp, f)
            rel = os.path.relpath(p, root).replace('\\', '/')
            try:
                d[rel] = (os.path.getsize(p), p)
            except OSError:
                pass
    return d

print('扫描中...')
n = scan(NEW)
c = scan(CN)
print('  怀旧服: %d 个文件' % len(n))
print('  国服:   %d 个文件' % len(c))

only_new = sorted(set(n) - set(c))
only_cn  = sorted(set(c) - set(n))
both     = set(n) & set(c)

# 同名但内容不同
diff_size = []
for k in both:
    if n[k][0] != c[k][0]:
        diff_size.append((k, n[k][0], c[k][0]))

print()
print('=== 怀旧服独有: %d 个 ===' % len(only_new))
print('=== 国服独有:   %d 个 ===' % len(only_cn))
print('=== 同名不同大小: %d 个 ===' % len(diff_size))

# 按目录归类怀旧服独有
from collections import Counter
cat = Counter()
for k in only_new:
    parts = k.split('/')
    cat['/'.join(parts[:2]) if len(parts) > 1 else parts[0]] += 1
print()
print('--- 怀旧服独有文件按目录 ---')
for k, v in cat.most_common(30):
    print('  %-46s %5d' % (k, v))

# 保存清单
out = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\_对比报告.json'
report = {
    'new_count': len(n), 'cn_count': len(c),
    'only_new': [{'path': k, 'size': n[k][0]} for k in only_new],
    'only_cn': [{'path': k, 'size': c[k][0]} for k in only_cn],
    'diff_size': [{'path': k, 'new': a, 'cn': b} for k, a, b in diff_size],
}
with io.open(out, 'w', encoding='utf-8') as f:
    json.dump(report, f, ensure_ascii=False, indent=1)
print()
print('已写入 %s' % out)

# 打印独有文件示例
print()
print('--- 怀旧服独有文件示例（前 40）---')
for k in only_new[:40]:
    print('  %-62s %10d' % (k, n[k][0]))
