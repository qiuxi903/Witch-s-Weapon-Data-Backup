import io, sys

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\收藏总目录.md'
with io.open(p, 'r', encoding='utf-8') as f:
    c = f.read()

# 1) 导航表：加入新目录
nav_old = '''| [`魔女兵器_资料与考据.html`](魔女兵器_资料与考据.html) | 37 页 HTML 资料集 | 135 KB |
| [`剧情文本加密分析报告.md`](剧情文本加密分析报告.md) | 剧情加密逆向分析 | 12 KB |'''
nav_new = '''| [`剧情文本_完整版/`](#剧情文本完整版) | **完整剧情全文（13 章 / 9,956 条对话）** | 0.76 MB |
| [`魔女兵器_资料与考据.html`](魔女兵器_资料与考据.html) | 37 页 HTML 资料集 | 135 KB |
| [`剧情文本加密分析报告.md`](剧情文本加密分析报告.md) | 剧情加密逆向分析（**已解决**） | 13 KB |
| [`社区线索查找.md`](社区线索查找.md) | 社区/网盘线索（**发现怀旧服**） | 24 KB |
| [`国服历史版本查找.md`](国服历史版本查找.md) | 国服历史版���核查 | 9 KB |'''
if nav_old in c:
    c = c.replace(nav_old, nav_new)
    print('OK: 导航表')
else:
    print('MISS: 导航表')

# 2) 在文件末尾追加新章节
addition = '''

---

## 十、剧情文本_完整版（0.76 MB）

> **这是本项目最有价值的成果之一。**

《魔女兵器》游戏内剧情文本是**加密**的（AES-128，密钥 `sfe023f_9fd&fwfl`）。
本目录中的剧情全文来自玩家自建的 **Godot 剧情复刻项目**，该项目已完成全部剧情的解密与复刻。

| 文件 | 内容 | 对话数 |
|---|---|---|
| `魔女兵器_完整剧情.md` | **全部剧情合集** | **9,956** |
| `第一章_人生的终结命运的开始.md` | 主线第 1 章 | 93 |
| `第二章_想守护的她被守护的你.md` | 主线第 2 章 | 1,192 |
| `第三章_神魂的治愈身体的诅咒.md` | 主线第 3 章 | 766 |
| `活动_深潜症.md` | 活动 1 | 1,774 |
| `活动_创伤反射.md` | 活动 2 | 964 |
| `活动_启示录.md` | 活动 3 | 1,854 |
| `活动_星尘降临.md` | 活动 4 | 2,133 |
| `活动_混沌演算.md` | 活动 5（**未完结**） | 127 |
| `活动_死亡告白.md` | 活动 6（**未完结**） | 65 |
| `支线_少女与皇帝.md` | 支线 | 317 |
| `支线01.md` / `支线02.md` / `支线03.md` | 支线 | 671 |

**来源**：`YANG301/Witch-Weapon-Godot-`（35 star，GDScript）
**官网**：https://www.witchweapon.wiki/

---

## 十一、玩家自建怀旧服（重大发现）

> **游戏可以重新玩了。**

在调查国服历史版本的过程中，意外发现了一个**玩家自建的怀旧服**：

| 项目 | 说明 |
|---|---|
| 官网 | **https://www.witchweapon.wiki/** |
| 口号 | 「故事未完，我们重逢。」 |
| **怀旧服客户端** | **v128 测试构建 · Android · 1.66 GiB** |
| 剧情编辑器 | v1.4.2（Windows / Linux / macOS / Android） |
| GitHub | `YANG301/Witch-Weapon-Godot-` |
| QQ 群 | 1078249413 |

### 已下载的怀旧服客户端

```
安装包/魔女兵器_怀旧服_witchweapon.wiki_v128测试构建_Android.apk
  大小:   1,781,319,377 字节 (1.66 GB)
  SHA256: B49FCEF9DBE64F3545DD63AC71C4484658332D198B2D89576320B3DD040E4D98
  条目:   9,624 个
  含:     libil2cpp.so (92,312,960) / global-metadata.dat (19,584,772)
          全部场景 / 角色 / UI / 视频资源
```

> ⚠️ **注意**：这是**玩家自建服务端**，非官方。官网明确声明「本站内容仅供爱好者交流参考，所有内容免费，不要被骗了」。
> 请勿用于商业用途。

### 网络资源新增目录

```
提取资源/网络资源/11_怀旧服witchweapon.wiki/
  ├── index.html / *.js / *.css          站点前端
  ├── api_catalog.json                   API 目录（5 个可下载项）
  └── src/Witch-Weapon-Godot--main/      剧情编辑器源码（475.8 MB / 7,220 文件）
        └── scripts/story/               完整剧情脚本（13 章 × 13 语言）
```

---

## 十二、逆向工具链（已完成的部分）

本次为破解剧情加密，搭建了完整的 IL2CPP 逆向工具链：

| 工具 | 位置 | 说明 |
|---|---|---|
| **Il2CppDumper** v6.7.46 | `tools/Il2CppDumper/` | IL2CPP 符号还原 |
| **Ghidra** 12.1.4 | `tools/ghidra_12.1.4_PUBLIC/` | 反汇编/反编译 |
| 分析脚本 | `tools/extract_decrypt.py`、`ExtractDecrypt.java` | Ghidra 自动提取脚本 |

### Il2CppDumper 产出（`提取资源/国服DLL/Il2CppDump/`）

| 文件 | 大小 | 说明 |
|---|---|---|
| **`dump.cs`** | **30.0 MB** | **全部 C# 代码结构（含方法名、字段、RVA）** |
| `script.json` | 80.9 MB | Ghidra/IDA 符号脚本 |
| `il2cpp.h` | 61.5 MB | C++ 头文件 |
| `Assembly-CSharp.dll` | 12.7 MB | 还原的托管程序集 |
| `stringliteral.json` | 3.3 MB | 字符串字面量 |
| 其他 DLL | — | 60+ 个还原的依赖程序集 |

### 由此确认的加密信息

```csharp
public class EncryptTools
{
    private const string key = "sfe023f_9fd&fwfl";   // ← AES-128 密钥
    private static bool useMD5;
    public static string Encrypt(string toEncrypt) { }
    public static string Decrypt(string toDecrypt) { }
}
```

---

## 十三、未获取的资源（明确清单）

### 站点级失效，无法恢复

| 资源 | 状态 |
|---|---|
| `anywhere.coresv.net`「魔女兵器の備忘録」 | 根路径 403，全站 404，主域 DNS 不解析 → **站点已死** |
| Wayback Machine | **本机网络不可达**（DNS 污染至黑洞 IP，封禁至 2035） |

### 确认不存在 / 已下架

| 资源 | 状态 |
|---|---|
| OST 试听（ototoy） | 站内搜索 0 结果，专辑已下架 |
| 《ANOTHER REAL》试听 | 未找到 |
| 官方 B 站账号 | 无官方号，仅同名玩家号 |
| 官方 YouTube 频道 | 404 已删除 |
| 游戏图标（App Store） | 六区 iTunes Lookup 全部 0 结果 |
| 官方微博四格漫画 | 需登录态，未获取 |
| 官网壁纸下载页 | **不存在**（壁纸改从 BWIKI 获取 27 张） |
| 官方 PDF / 设定资料 | 全站扫描无任何 .pdf |

### 部分缺失，可续跑

| 资源 | 状态 |
|---|---|
| 官网活动图编号 025–073、091+ | 已获 38 张（002–024、074–090），可续跑 |
| 国服 v1.x / v2.0.0 原始 APK | **确认拿不到**（详见 `国服历史版本查找.md`） |

---

## 十四、数据保全声明

1. **全部 231 个 `sentence_*.ab` 加密文件完整保存**（国服 221 + 日服 221 + 港澳台 204 + 韩服 188），一个字节未动。
2. **加密算法已完全还原**（AES-128，密钥 `sfe023f_9fd&fwfl`），理论上可自行解密全部原始文件。
3. **剧情全文已提取**（9,956 条对话），见 `剧情文本_完整版/`。
4. **四区服安装包全部到手**（13 个包 / 6.02 GB），含三个区服的完整 OBB。
5. **怀旧服可玩客户端已到手**（1.66 GB）。

---

*本目录最后更新：2026-10-08*
'''

c = c.rstrip() + addition
with io.open(p, 'w', encoding='utf-8') as f:
    f.write(c)
print('已追加新章节, 总长 %d 字节' % len(c))
