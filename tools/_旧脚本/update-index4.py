import io, sys, os

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\收藏总目录.md'
with io.open(p, 'r', encoding='utf-8') as f:
    c = f.read()

# 1) 导航表加入新条目
old_nav = '| [`剧情文本_完整版/`](#剧情文本完整版) | **完整剧情全文（13 章 / 9,956 条对话）** | 0.76 MB |'
new_nav = '''| [`魔女兵器_剧情全集.html`](魔女兵器_剧情全集.html) | **剧情全集电子书（16,687 行 · 五语对照）** | 10.7 MB |
| [`魔女兵器_剧情图鉴.html`](魔女兵器_剧情图鉴.html) | **剧情图鉴（带 84 张插图）** | 10.7 MB |
| [`剧情文本_解密版/`](#剧情文本解密版) | **游戏原始剧情解密（1,063 文件 / 1,327 万字符）** | 26 MB |
| [`剧情文本_完整版/`](#剧情文本完整版) | 第三方复刻剧情（13 章 / 9,956 条对话） | 0.76 MB |'''
if old_nav in c:
    c = c.replace(old_nav, new_nav)
    print('OK: 导航表')
else:
    print('MISS: 导航表')

# 2) 更新���题里的加密状态
c = c.replace('## 四、剧情文本：加密机制（**已破解**）',
              '## 四、剧情文本：加密机制（**已完全破解 —— XOR 0xFF**）')

# 3) 追加新章节
addition = '''

---

## 十四、剧情文本_解密版（26 MB）—— 本项目最大成果

> **游戏原始加密剧情已被完全破解。**

### 加密算法

**逐字节取反（XOR 0xFF）** —— 就这么简单。

```python
plaintext = bytes(b ^ 0xFF for b in ciphertext).decode('utf-8')
```

### 解密成果

| 区服 | 文件数 | 解密成功 | 空文件 | 字符数 |
|---|---:|---:|---:|---:|
| 国服 v2.0.1 | 225 | 221 | 4 | 2,752,172 |
| **怀旧服 v128** | **229** | **225** | 4 | **2,832,100** |
| 日服 v2.0.0 | 225 | 221 | 4 | 2,761,284 |
| 港澳台 v1.6.0 | 208 | 205 | 3 | 2,724,913 |
| 韩服 v1.0 | 194 | 191 | 3 | 2,202,644 |
| **合计** | **1,081** | **1,063** | **18** | **13,273,113** |

> 18 个"空文件"是零长度占位资源，非解密失败 —— **所有含数据的文件 100% 解密成功**。

### 文本格式

解密后是**五语言对照表**（制表符分隔）：

```
序号 <TAB> 说话人ID <TAB> 简中 <TAB> 繁中 <TAB> 日文 <TAB> 韩文 <TAB> 英文
```

### 目录结构

```
剧情文本_解密版/
├── 国服v2.0.1/     221 个 .txt (5.4 MB)
├── 怀旧服v128/     225 个 .txt (5.6 MB)
├── 日服v2.0.0/     221 个 .txt (5.5 MB)
├── 港澳台v1.6.0/   205 个 .txt (5.4 MB)
└── 韩服v1.0/       191 个 .txt (4.2 MB)
```

---

## 十五、HTML 电子书（2 本）

### 15.1 `魔女兵器_剧情全集.html`（10.7 MB）

纯文本剧情全集，深色阅读界面：

- **7 大章节**：序章 / 第一章 / 第二章 / 第三章 / 活动 / 支线 / 测试
- **221 个文本 · 16,687 行对话**
- 左侧固定导航（221 项，可跳转）
- 每行可展开查看**繁中/日文/韩文/英文**对照
- 说话人标签区分旁白与对白

### 15.2 `魔女兵器_剧情图鉴.html`（10.7 MB）

带插图的版本：

- 同样 16,687 行剧情
- **84 张插图**（角色卡面 / 加载图 / 官方壁纸 / 活动图 / 场景）
- 每章开头一个图廊
- 首屏大图 Hero 区

---

## 十六、怀旧服 v128 独有内容

对比国服 v2.0.1 与怀旧服 v128：

| 项目 | 国服 | 怀旧服 |
|---|---:|---:|
| assetbundle 文件总数 | 6,650 | **7,080** |
| 怀旧服独有 | — | **430 个** |
| 国服独有 | **0 个** | — |

**怀旧服是国服��严格超集**：

### 16.1 国服玩家从未见到的 4 个剧情文件

| 文件 | 大小 |
|---|---|
| `sentence_30319.ab` | 20,906 |
| `sentence_303190.ab` | 24,517 |
| `sentence_30320.ab` | 18,783 |
| `sentence_30321.ab` | 11,902 |

国服 lesson 目录**止于 `sentence_30318`**。

### 16.2 保留场景清单

`config/preserved_stage_manifest.ab`（269 KB）—— **32 张战斗地图**清单：

```
map_1000_overbridge    map_1011_classroombroken  map_1022_minefield02
map_1001_mallsunset    map_1012_playground!      map_1023_fighterhouse
map_1002_railwaybridge map_1013_groofbroken      map_1024_missile
map_1003_downtown      map_1014_blackmarket      map_1025_cityhall
map_1004_metroplatform map_1015_overpass         map_1026_outlets
map_1005_subwayinner   map_1016_factorycrossing  map_1026_outlets_4test
map_1006_traintracks   map_1017_factorylab       map_1027_spacewalk
map_1007_parkgateway   map_1018_factoryworkshop  map_1028_smelter
map_1008_riverbank     map_1019_wharfroad        map_1029_hieron
map_1009_fountain      map_1020_basestation      map_9999_scene4runtest
map_1010_classroomhallway map_1021_minefield01
```

> `map_1012_playground.ab!` 带感叹号标记；`map_1026_outlets_4test.ab` 为测试地图。

### 16.3 其他独有资源

- `config/community_notice_image.ab`（850 KB）—— 社区公告图
- 320 个 UI 图片 + 67 个 UI 预制体
- 3 个新手引导关卡

---

## 十七、解密工具链（可复现）

| 脚本 | 用途 |
|---|---|
| `tools/parse-v3.py` | **核心解析器**（UnityFS 解包 + BytesAsset 定位 + 取反解密） |
| `tools/decrypt-all-v2.py` | 批量解密 5 区服全部文件 |
| `tools/extract-manifest3.py` | UnityFS 解压参考实现（含 LZ4 blockInfo） |
| `tools/build-story-html.py` | 生成剧情全集 HTML |
| `tools/build-illustrated.py` | 生成剧情图鉴 HTML |
| `tools/compare-revival.py` | 怀旧服 vs 国服资源对比 |
| `tools/Il2CppDumper/` | IL2CPP 符号还原工具 |
| `tools/ghidra_12.1.4_PUBLIC/` | Ghidra 反汇编工具 |

---

## 十八、最终数据保全声明

1. **全部原始加密文件完整保存**（1,081 个 `sentence_*.ab`），一个字节未动。
2. **加密算法已完全还原**（XOR 0xFF），可随时重新解密验证。
3. **解密成果已落盘**：`剧情文本_解密版/`（13,273,113 字符）。
4. **两本 HTML 电子书**已生成，可离线阅读。
5. **四区服安装包 + 怀旧服客户端**全部到手。
6. **第三方复刻剧情**（Godot 项目）作为交叉验证保存。

---

*本目录最后更新：2026-10-08*
'''

c = c.rstrip() + addition
with io.open(p, 'w', encoding='utf-8') as f:
    f.write(c)
print('已追加, 总长 %d 字节' % len(c))
