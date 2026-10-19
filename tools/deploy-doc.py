# 生成部署目录的文档：把 网站/_说明.md 改写成部署版，并放入《部署指南.md》
#
#   python tools/deploy-doc.py
#
# 由 tools/deploy.py 自动调用；也可单独运行。
import io, os, shutil, sys

R    = r'G:\project\其他\game'
SRC  = os.path.join(R, '网站', '_说明.md')
DEST = os.path.join(R, '部署')
GUIDE_SRC = os.path.join(R, 'tools', '_部署指南.md')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# (旧文本, 新文本) —— 每一条都必须命中，否则报错，避免静默漏改
REPL = [
    # 一、怎么打开
    ("""## 一、怎么打开

站点必须从**项目根目录**启动（页面通过 `../` 引用解包素材）：

```powershell
cd "G:\\project\\其他\\game"
python -m http.server 8950
```

然后浏览器打开 <http://127.0.0.1:8950/网站/index.html>

> 直接双击 `index.html` 打开会看不到图片 —— 浏览器禁止 `file://` 协议跨目录读取素材。""",
     """## 一、怎么打开

这是**自包含**的部署版：所有素材都在本站目录内的 `files/`，页面不再用 `../` 往外跑。

```powershell
cd "G:\\project\\其他\\game\\部署"
python -m http.server 8951
```

然后浏览器打开 <http://127.0.0.1:8951/index.html>

> 直接双击 `index.html` 打开会看不到图片 —— 浏览器禁止 `file://` 协议读取素材，必须走 HTTP。
>
> **要传到服务器上，看同目录的《部署指南.md》。**"""),

    # 五、性能设计里的缩略图说明
    ("- **缩略图**：列表用 `网站/thumbs/` 下的 640px JPEG（共 7,410 张），点击才加载原图。",
     "- **缩略图**：列表用 `thumbs/` 下的 640px **WebP** 缩略图（共 7,410 张），点击才加载原图。"),

    # 配置表 ZIP 路径
    ("ZIP 是构建时生成好的静态文件（`网站/data/zip/<区服>.zip`，240–400 KB）",
     "ZIP 是构建时生成好的静态文件（`data/zip/<区服>.zip`，240–400 KB）"),

    # 八、目录结构
    ("""```
网站/
├── index.html          首页
├── story.html          剧情
├── characters.html     角色
├── art.html            美术
├── manga.html          四格漫画
├── audio.html          音频
├── video.html          视频
├── config.html         配置表
├── system.html         系统设计
├── news.html           官网公告
├── relics.html         开发遗迹
├── archive.html        全部文件
├── logo.png            游戏官方 LOGO（官网 img/top/logo.png）
├── css/style.css       设计系统 v5
├── js/app.js           交互脚本 v5
├── data/               配置表数据（按需加载）
│   ├── cfg-*.js        huijiu / guofu / rifu / gangtai / hanfu（16.8 MB）
│   └── zip/*.zip       各区服整包（240–400 KB，可直接下载）
└── thumbs/             7,410 张缩略图（165 MB）
```""",
     """```
部署/                      ← 整个目录直接作为网站根目录
├── index.html             首页
├── story.html             剧情
├── characters.html        角色
├── art.html               美术
├── manga.html             四格漫画
├── audio.html             音频
├── video.html             视频
├── config.html            配置表
├── system.html            系统设计
├── news.html              官网公告
├── relics.html            开发遗迹
├── archive.html           全部文件
├── logo.png               游戏官方 LOGO（官网 img/top/logo.png）
├── _说明.md                本文件
├── 部署指南.md             宝塔面板部署步骤
├── css/style.css          设计系统 v5
├── js/app.js              交互脚本 v5
├── data/                  配置表数据（18.3 MB，按需加载）
│   ├── cfg-*.js           huijiu / guofu / rifu / gangtai / hanfu
│   └── zip/*.zip          各区服整包（240–400 KB，可直接下载）
├── thumbs/                7,410 张 WebP 缩略图（108.6 MB）
└── files/                 11,014 个素材（870.8 MB）
    ├── 06_美术素材/        图片全部转成 WebP
    ├── 07_音频资源/        WAV 全部转成 ogg + mp3 双格式
    ├── 08_视频资源/        原样保留
    ├── 02_客户端解包/      解包出的原始素材
    └── assets/            图标等零散资源
```

**合计 18,451 个文件 / 1,012.2 MB**（原始素材 22.06 GB，压缩到 4.6%）。

> 归档版 `网站/` 仍然保留 —— 它用 `../` 直接引用仓库里的原始素材，适合本地查看未压缩的原图/原音频。"""),

    # 重建顺序
    ("""```powershell
python tools/decrypt-config.py    # 解密 5 个区服的配置表（新增区服时跑）
python tools/site-css.py
python tools/site-js.py
python tools/site-characters.py
python tools/site-story.py
python tools/site-index.py
python tools/site-pages-a.py      # 美术/音频/视频/漫画
python tools/site-config.py       # 配置表（多区服）
python tools/site-pages-c.py      # 系统设计/全部文件
python tools/site-news.py         # 必须最后
python tools/site-relics.py       # 必须最后
```

> `site-pages-b.py` 已改为空操作（配置表页迁到 `site-config.py`），保留仅为兼容旧流程。""",
     """部署版由 `tools/deploy.py` 一个命令重建（它给全部脚本注入 `WW_DEPLOY=1`）：

```powershell
cd "G:\\project\\其他\\game"

# 素材有变动时才需要：图片转 WebP、WAV 转 ogg/mp3、生成缩略图、拷贝视频
python tools\\deploy-assets.py all

# 重建全部页面到 部署\\
python tools\\deploy.py

# 校验所有静态引用都能在磁盘上找到
python tools\\check-deploy.py
```

归档版 `网站/` 的重建顺序（不加 `WW_DEPLOY`）：

```powershell
python tools/decrypt-config.py    # 解密 5 个区服的配置表（新增区服时跑）
python tools/site-css.py
python tools/site-js.py
python tools/site-characters.py
python tools/site-story.py
python tools/site-index.py
python tools/site-pages-a.py      # 美术/音频/视频/漫画
python tools/site-config.py       # 配置表（多区服）
python tools/site-pages-c.py      # 系统设计/全部文件
python tools/site-news.py         # 必须最后
python tools/site-relics.py       # 必须最后
```

> `site-pages-b.py` 已改为空操作（配置表页迁到 `site-config.py`），保留仅为兼容旧流程。"""),
]


def main():
    if not os.path.exists(SRC):
        print('！ 找不到 %s' % SRC)
        return 1
    txt = io.open(SRC, encoding='utf-8').read()
    for i, (old, new) in enumerate(REPL, 1):
        if old not in txt:
            print('！ 第 %d 处替换未命中，_说明.md 结构可能已变' % i)
            print('   片段开头：%s' % old.split('\n')[0][:60])
            return 1
        txt = txt.replace(old, new, 1)

    out = os.path.join(DEST, '_说明.md')
    io.open(out, 'w', encoding='utf-8', newline='\n').write(txt)
    print('  OK   _说明.md（部署版）  %.1f KB' % (os.path.getsize(out) / 1024))

    if os.path.exists(GUIDE_SRC):
        g = os.path.join(DEST, '部署指南.md')
        shutil.copy2(GUIDE_SRC, g)
        print('  OK   部署指南.md          %.1f KB' % (os.path.getsize(g) / 1024))
    else:
        print('  --   跳过 部署指南.md（%s 不存在）' % GUIDE_SRC)
    return 0


if __name__ == '__main__':
    sys.exit(main())
