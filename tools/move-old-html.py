# 把旧的 15 个 HTML 移入留念文件夹
import io, os, sys, shutil

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
DEST = os.path.join(R, '_旧版HTML_留念')
os.makedirs(DEST, exist_ok=True)

htmls = [f for f in os.listdir(R) if f.lower().endswith('.html')]
print('根目录 HTML %d 个' % len(htmls))

moved = []
for f in htmls:
    src = os.path.join(R, f)
    dst = os.path.join(DEST, f)
    if os.path.exists(dst):
        print('  已存在，跳过: %s' % f)
        continue
    try:
        shutil.move(src, dst)
        moved.append(f)
        print('  -> %s (%.1f MB)' % (f, os.path.getsize(dst) / 1024 / 1024))
    except Exception as e:
        print('  失败 %s: %s' % (f, e))

# 说明文件
io.open(os.path.join(DEST, '_说明.md'), 'w', encoding='utf-8').write(
'''# 旧版 HTML 留念

本目录保存**网站化之前**的 %d 个独立 HTML 页面。

## 为什么保留

这些页面是逐步做出来的，��个都是**单文件自包含**的完整交付物：

- 可以直接双击打开，不依赖任何服务器
- 图片/音频用相对路径引用，在**本目录内**可能失效（原路径是上一级）
- 内容与新网站**完全一致**，只是组织形式不同

## 文件清单

%s

## 新网站

见上一级 `网站/` 目录 —— 内容已全部整合，且素材引用完整。

**本目录未做任何修改，仅移动位置。**
''' % (len(moved), '\n'.join('- `%s`' % f for f in moved)))

print()
print('已移动 %d 个到 _旧版HTML_留念/' % len(moved))
