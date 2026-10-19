import io, sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\收藏总目录.md'
with io.open(p, 'r', encoding='utf-8') as f:
    c = f.read()

reps = [
    # 总规模
    ('> 总规：**85,258 个文件 / 28.34 GB**',
     '> 总规模：**约 81,800 个文件 / 24.4 GB**'),
    # 提取资源大小
    ('| [`提取资源/`](#三提取资源-1934-gb) | 完整解包与导出中间产物 | 19.34 GB |',
     '| [`提取资源/`](#三提取资源-155-gb) | 完整解包与导出中间产物 | 15.5 GB |'),
    # 字体着色器行
    ('| `导出_字体着色器` | 3,447 | 3.98 GB | 16 字体 + 3,431 着色器 |',
     '| `导出_字体着色器` | 16 | 9.0 MB | 3 OTF + 13 TTF（**3,431 个着色器已删除，释放 3.88 GB**） |'),
]

for old, new in reps:
    if old in c:
        c = c.replace(old, new)
        print('OK: %s' % old[:50])
    else:
        print('MISS: %s' % old[:50])

# 在导航表加一行分析报告
nav_old = '| [`收藏总目录.md`](收藏总目录.md) | 本文件 | — |'
nav_new = ('| [`剧情文本加密分析报告.md`](剧情文本加密分析报告.md) | 剧情加密逆向分析 | 12 KB |\n'
           '| [`收藏总目录.md`](收藏总目录.md) | 本文件 | — |')
if nav_old in c:
    c = c.replace(nav_old, nav_new)
    print('OK: 导航表')
else:
    print('MISS: 导航表')

with io.open(p, 'w', encoding='utf-8') as f:
    f.write(c)
print('已写入')
