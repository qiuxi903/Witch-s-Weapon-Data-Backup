import io, sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# ---- 收藏总目录.md ----
p = r'G:\project\其他\game\收藏总目录.md'
with io.open(p, 'r', encoding='utf-8') as f:
    c = f.read()

c = c.replace('> 总规模：**82,452 个文件 / 24.64 GB**',
              '> 总规模：**99,206 个文件 / 29.60 GB**')
c = c.replace('| [`安装包/`](#一安装包-602-gb) | 四区服 APK + XAPK（含 OBB） | 6.02 GB |',
              '| [`安装包/`](#一安装包-754-gb) | 四区服 APK + XAPK + **怀旧服客户端** | 7.54 GB |')
c = c.replace('## 一、安装包（6.02 GB）', '## 一、安装包（7.54 GB）')
c = c.replace('## 三、提取资源（19.28 GB）', '## 三、提取资源（16.26 GB）')
c = c.replace('| [`提取资源/`](#三提取资源-166-gb) | 完整解包与导出中间产物 | 16.6 GB |',
              '| [`提取资源/`](#三提取资源-1626-gb) | 完整解包与导出中间产物 | 16.26 GB |')
c = c.replace('| [`tools/`](tools/) | 全部���复现脚本 | 25 MB |',
              '| [`tools/`](tools/) | 全部可复现脚本 + 逆向工具链 | 2.24 GB |')

with io.open(p, 'w', encoding='utf-8') as f:
    f.write(c)
print('收藏总目录.md 已更新')

# ---- README.md ----
p2 = r'G:\project\其他\game\README.md'
with io.open(p2, 'r', encoding='utf-8') as f:
    c2 = f.read()

c2 = c2.replace('> **完整收藏总目录见 [`收藏总目录.md`](收藏总目录.md)** —— 24.64 GB / 82,452 个文件',
                '> **完整收藏总目录见 [`收藏总目录.md`](收藏总目录.md)** —— 29.60 GB / 99,206 个文件')
c2 = c2.replace('| **`剧情文本加密分析报告.md`** | **剧情文本加密的逆向分析报告** —— 数据结构、加密定位、已排除算法、后续路径。 |',
                '| **`剧情文本_完整版/`** | **完整剧情全文 —— 13 章 / 9,956 条对话 / 0.76 MB。** |\n'
                '| **`剧情文本加密分析报告.md`** | **剧情加密逆向分析（已破解）** —— AES-128，密钥 `sfe023f_9fd&fwfl`。 |\n'
                '| **`社区线索查找.md`** | **社区线索调查 —— 发现玩家自建怀旧服。** |')
c2 = c2.replace('| `提取资源/` | 完整解包与 AssetStudio 导出中间产物 | 15.5 GB |',
                '| `提取资源/` | 完整解包与 AssetStudio 导出中间产物 | 16.26 GB |')
c2 = c2.replace('| `tools/` | 全部可复现脚本 + AssetStudioModCLI | 25 MB |',
                '| `tools/` | 全部可复现脚本 + AssetStudioModCLI + Il2CppDumper + Ghidra | 2.24 GB |')

with io.open(p2, 'w', encoding='utf-8') as f:
    f.write(c2)
print('README.md 已更新')
