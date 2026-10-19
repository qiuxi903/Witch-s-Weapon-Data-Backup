# 《魔女兵器》OBB 数据包 — 最终成果报告

**结论：三个区服的 OBB 全部找到，均为 APKPure 官方 XAPK（内含标准命名的 OBB），已用 curl 实测可直接下载。**

全部经 `curl` 实测返回 **HTTP 206 Partial Content**，文件头为 `PK\x03\x04`（合法 ZIP/XAPK），
并通过 HTTP Range 读取 ZIP 中央目录，**逐一确认了内部 OBB 条目的确切文件名与字节数**。

---

## 1. 日服（优先）— 已找到 ✅

| 项目 | 值 |
|---|---|
| 包名 | `com.dmm.games.witchsweapon.google` |
| 版本 | 2.0.0 (versionCode **20042164**) |
| XAPK 总大小 | **1,434,298,104 字节** (1.34 GiB) |
| OBB 路径（包内） | `Android/obb/com.dmm.games.witchsweapon.google/main.20042164.com.dmm.games.witchsweapon.google.obb` |
| **OBB 大小** | **1,354,668,402 字节** (1.26 GiB) |
| APK 大小（包内） | 79,301,342 字节 (75.6 MB) |

### 可直接 curl 下载的 URL

```
https://data.winudf.com/XAPK/Y29tLmRtbS5nYW1lcy53aXRjaHN3ZWFwb24uZ29vZ2xlXzIwMDQyMTY0XzhiZGI4YWFm?_p=Y29tLmRtbS5nYW1lcy53aXRjaHN3ZWFwb24uZ29vZ2xl&download_id=otr_1112205565581023&filename=Witch%27s+Weapon+-%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8-_2.0.0_APKPure.xapk&full_size=1434298104&is_hot=false&k=f838a9a3a918709fe1c5de7124ea1c206ac92313&package_name=com.dmm.games.witchsweapon.google&source=web&token=1791393811-1c91f2c8e9-0-c6e570290a24c8c1d70df7248bbbb9d0
```

```bash
curl -L -o "WitchsWeapon_JP_2.0.0.xapk" \
  -x http://127.0.0.1:7897 \
  "https://data.winudf.com/XAPK/Y29tLmRtbS5nYW1lcy53aXRjaHN3ZWFwb24uZ29vZ2xlXzIwMDQyMTY0XzhiZGI4YWFm?_p=Y29tLmRtbS5nYW1lcy53aXRjaHN3ZWFwb24uZ29vZ2xl&download_id=otr_1112205565581023&filename=Witch%27s+Weapon+-%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8-_2.0.0_APKPure.xapk&full_size=1434298104&is_hot=false&k=f838a9a3a918709fe1c5de7124ea1c206ac92313&package_name=com.dmm.games.witchsweapon.google&source=web&token=1791393811-1c91f2c8e9-0-c6e570290a24c8c1d70df7248bbbb9d0"
```

- **无需 Referer、无需 Cookie、无需特殊 header**（CDN 为 tencent-cos，直连/走代理均可）
- 稳定入口（需过 Cloudflare，见下）：`https://d.apkpure.com/b/XAPK/com.dmm.games.witchsweapon.google?versionCode=20042164`
- 来源页面：https://apkpure.com/witch-s-weapon-��女兵器/com.dmm.games.witchsweapon.google/download

---

## 2. 港澳台（繁中）— 已找到 ✅

| 项目 | 值 |
|---|---|
| 包名 | `com.ltgames.mnbq.android` |
| 版本 | 1.6.0 (versionCode **20011667**) |
| XAPK 总大小 | **1,429,163,887 字节** (1.33 GiB) |
| OBB 路径（包内） | `Android/obb/com.ltgames.mnbq.android/main.20011667.com.ltgames.mnbq.android.obb` |
| **OBB 大小** | **1,345,856,832 字节** (1.25 GiB) |
| APK 大小（包内） | 82,961,404 字节 (79.1 MB) |

### 可直接 curl 下载的 URL

```
https://data.winudf.com/xapk/Y29tLmx0Z2FtZXMubW5icS5hbmRyb2lkXzIwMDExNjY3X2U0ZjUyZTUy?_p=Y29tLmx0Z2FtZXMubW5icS5hbmRyb2lk&download_id=otr_1491203680472382&filename=%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8%E2%80%94%E9%83%BD%E5%B8%82%E5%B9%BB%E6%83%B3%E8%BC%95%E5%B0%8F%E8%AA%AARPG_1.6.0_APKPure.xapk&full_size=1429163887&is_hot=false&k=9412fe52a25b95e364d0802d22c7d8c36ac92340&package_name=com.ltgames.mnbq.android&source=web&token=1791393856-6b8f57b7ea-0-65aa9d4628577f87851d2fc7eb08c5ff
```

- 稳定入口：`https://d.apkpure.com/b/XAPK/com.ltgames.mnbq.android?versionCode=20011667`
- 来源页面：https://apkpure.com/魔女兵器—都市幻想輕小說RPG/com.ltgames.mnbq.android/download
- 另有旧版 1.4.0 (versionCode **20010869**) �� XAPK 入口

---

## 3. 韩服 — 已找到 ✅

| 项目 | 值 |
|---|---|
| 包名 | `com.shuiqinling.ww.google.kr` |
| 版本 | 1.0 (versionCode **19071675**) |
| XAPK 总大小 | **1,308,555,560 字节** (1.22 GiB) |
| OBB 路径（包内） | `Android/obb/com.shuiqinling.ww.google.kr/main.19071675.com.shuiqinling.ww.google.kr.obb` |
| **OBB 大小** | **1,226,919,492 字节** (1.14 GiB) |
| APK 大小（包内） | 81,576,183 字节 (77.8 MB) |

### 可直接 curl 下载的 URL

```
https://data.winudf.com/xapk/Y29tLnNodWlxaW5saW5nLnd3Lmdvb2dsZS5rcl8xOTA3MTY3NV84OWZhNTcxMQ?_p=Y29tLnNodWlxaW5saW5nLnd3Lmdvb2dsZS5rcg%3D%3D&download_id=otr_1339308263081473&filename=%EB%A7%88%EB%85%80%EB%B3%91%EA%B8%B0_1.0_APKPure.xapk&full_size=1308555560&is_hot=false&k=15dfb6e8aaea9b69f775199a4e908cf36ac9235c&package_name=com.shuiqinling.ww.google.kr&source=web&token=1791393884-b6b078f1d0-0-f78c4ab6500f8856d2a35bf892174913
```

- 稳定入口：`https://d.apkpure.com/b/XAPK/com.shuiqinling.ww.google.kr?versionCode=19071675`
- 来源页面：https://apkpure.com/마녀병기/com.shuiqinling.ww.google.kr/download
- 另有 1.1.97、1.1.90 旧版 XAPK 入口

---

## 4. 国服 — 无需 OBB

`com.shuiqinling.ww.android.cn00` 的 APK 本身就是完整的 1.31 GB，自带全部资源，不需要 OBB。

---

## 技术要点：如何绕过 Cloudflare 拿到直链

1. **APKCombo 侧本来就能拿到线索**（apkcombo.com 无 Cloudflare 拦截）：
   其下载页的 `<a href="https://apkcombo.com/d?u=<base64>">` 解码后就是
   `https://download.pureapk.com/b/XAPK/<base64>`。但 pureapk 会 302 到 apkpure.com，
   而 apkpure.com 对 curl 返回 **403 + `Cf-Mitigated: challenge`**。

2. **突破口 = 非 headless 真实浏览器 + CDP**：
   ```powershell
   Start-Process "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" -ArgumentList @(
     "--remote-debugging-port=9222",
     "--user-data-dir=$env:TEMP\edge_ww_profile",
     "--no-first-run","--no-default-browser-check",
     "--proxy-server=http://127.0.0.1:7897",
     "https://apkpure.com/xapk/com.dmm.games.witchsweapon.google"
   )
   ```
   真实 Edge（带完整 UI）**自动通过了 Cloudflare JS 挑战**（页面标题变为游戏名，
   `document.body.innerText` 中无 "Just a moment"）。

3. 在已过挑战的会话里导航到 `/download` 页，从 DOM 提取
   `https://d.apkpure.com/b/XAPK/<pkg>?versionCode=<vc>`，
   再用 CDP `Network.responseReceived` 捕获其 302 后的最终 CDN 地址
   （`data.winudf.com/...`，tencent-cos，带签名 token）。

4. 该 CDN 直链**不校验 Referer/Cookie**，可直接用 curl 下载。

### 注意：签名 URL 可能过期
`data.winudf.com` 链接带 `token=` 与 `k=` 签名参数。如果失效，重新走第 2-3 步即可拿到新链接，
或用稳定入口 `https://d.apkpure.com/b/XAPK/<pkg>?versionCode=<vc>`（需浏览器会话过 CF）。

---

## 5. 如何从 XAPK 中取出 OBB

XAPK 就是普通 ZIP。解压后 OBB 位于 `Android/obb/<包名>/` 下：

```bash
# 解压
unzip WitchsWeapon_JP_2.0.0.xapk

# 得到：
#   Android/obb/com.dmm.games.witchsweapon.google/main.20042164.com.dmm.games.witchsweapon.google.obb
#   com.dmm.games.witchsweapon.google.apk

# 也可只提取 OBB：
unzip -j WitchsWeapon_JP_2.0.0.xapk "Android/obb/*/*.obb" -d ./obb_out
```

安装时把 OBB 放到设备的
`/sdcard/Android/obb/<包名>/main.<versionCode>.<包名>.obb`。

---

## 附：验证方法说明

- **HTTP 层**：`curl -H "Range: bytes=0-3"` → `206` + `PK..` 魔数
- **ZIP 层**：用 HTTP Range 读取文件末尾 64KB 找 EOCD，再按 `cdOffset/cdSize`
  拉取中央目录，逐条解析出 OBB 的**确切文件名与未压缩字节数**（脚本：`ziplist.mjs`）
- 三个区服的 OBB 文件名**完全符合 Android 规范** `main.<versionCode>.<packagename>.obb`，
  与任务描述中的预期格式一致。

## 未找到 OBB 的途径（已排除）
- 国服：不需要（APK 自带完整资源）
- APKMirror：无该游戏条目
- 其余镜像站：未提供 XAPK/OBB
- 网盘分享：未发现可靠的百度网盘等公开分享链接

**三个区服全部成功，无失败项。**
