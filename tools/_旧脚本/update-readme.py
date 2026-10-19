import io, sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\README.md'
with io.open(p, 'r', encoding='utf-8') as f:
    c = f.read()

reps = [
    ('> **完整收藏总目录见 [`收藏总目录.md`](收藏总目录.md)** —— 28.4 GB / 85,000+ 文件',
     '> **完整收藏总目录见 [`收藏总目录.md`](收藏总目录.md)** —— 24.64 GB / 82,452 个文件'),
    ('| **`收藏总目录.md`** | **完整收藏总目录** —— 全部资源的分类导航与说明。 |',
     '| **`收藏总目录.md`** | **完整收藏总目录** —— 全部资源的分类导航与说明。 |\n'
     '| **`剧情文本加密分析报告.md`** | **剧情文本加密的逆向分析报告** —— 数据结构、加密定位、已排除算法、后续路径。 |'),
    ('| `提取资源/` | 完整解包与 AssetStudio 导出中间产物 | 19.39 GB |',
     '| `提取资源/` | 完整解包与 AssetStudio 导出中间产物 | 15.5 GB |'),
    ('| `tools/` | 全部可复现脚本 + AssetStudioModCLI | 25 MB |',
     '| `提取资源/网络资源/` | **网络存档**：官网 / Wiki / 萌百 / 日文剧情博客 | 165 MB |\n'
     '| `tools/` | 全部可复现脚本 + AssetStudioModCLI | 25 MB |'),
]

for old, new in reps:
    if old in c:
        c = c.replace(old, new)
        print('OK: %s' % old[:44])
    else:
        print('MISS: %s' % old[:44])

with io.open(p, 'w', encoding='utf-8') as f:
    f.write(c)
print('已写入')
