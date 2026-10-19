import io, sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# ---- 收藏总目录.md ----
p = r'G:\project\其他\game\收藏总目录.md'
with io.open(p, 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace('> 总规模：**99,206 个文件 / 29.60 GB**', '> 总规模：**111,386 个文件 / 31.90 GB**')
c = c.replace('| [`提取资源/`](#三提取资源-1626-gb) | 完整解包与导出中间产物 | 16.26 GB |',
              '| [`提取资源/`](#三提取资源-1830-gb) | 完整解包与导出中间产物 | 18.30 GB |')
c = c.replace('## 三、提取资源（16.26 GB）', '## 三、提取资源（18.30 GB）')
c = c.replace('| [`tools/`](tools/) | 全部可复现脚本 + 逆向工具链 | 2.24 GB |',
              '| [`tools/`](tools/) | 全部可复现脚本 + 逆向工具链 | 2.32 GB |')
c = c.replace('| [`assets/img/`](assets/img/) | HTML 资料集引用图 | 14.3 MB |',
              '| [`assets/img/`](assets/img/) | HTML 电子书引用图 | 158.1 MB |')

with io.open(p, 'w', encoding='utf-8') as f:
    f.write(c)
print('收藏总目录.md OK')

# ---- README.md ----
p2 = r'G:\project\其他\game\README.md'
with io.open(p2, 'r', encoding='utf-8') as f:
    c2 = f.read()
c2 = c2.replace('29.60 GB / 99,206 个文件', '31.90 GB / 111,386 个文件')
c2 = c2.replace('| `提取资源/` | 完整解包与 AssetStudio 导出中间产物 | 16.26 GB |',
                '| `提取资源/` | 完整解包与 AssetStudio 导出中间产物 | 18.30 GB |')
c2 = c2.replace('| `tools/` | 全部可复现脚本 + AssetStudioModCLI + Il2CppDumper + Ghidra | 2.24 GB |',
                '| `tools/` | 全部可复现脚本 + AssetStudioModCLI + Il2CppDumper + Ghidra | 2.32 GB |')
with io.open(p2, 'w', encoding='utf-8') as f:
    f.write(c2)
print('README.md OK')
