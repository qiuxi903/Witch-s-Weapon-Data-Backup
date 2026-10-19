import io, json, sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\_对比报告.json'
with io.open(p, 'r', encoding='utf-8') as f:
    j = json.load(f)

print('=== 同名但大小不同（前 30，按差值排序）===')
rows = sorted(j['diff_size'], key=lambda x: -abs(x['new'] - x['cn']))
for r in rows[:30]:
    d = r['new'] - r['cn']
    print('  %-56s 怀旧 %10d  国服 %10d  %+d' % (r['path'], r['new'], r['cn'], d))

print()
print('=== 独有 config 文件 ===')
for r in j['only_new']:
    if r['path'].startswith('config/'):
        print('  %-52s %10d' % (r['path'], r['size']))

print()
print('=== 独有 assets 文件按子目录统计 ===')
from collections import Counter
c = Counter()
for r in j['only_new']:
    if r['path'].startswith('assets/'):
        parts = r['path'].split('/')
        c['/'.join(parts[:4])] += 1
for k, v in c.most_common(25):
    print('  %-56s %5d' % (k, v))
