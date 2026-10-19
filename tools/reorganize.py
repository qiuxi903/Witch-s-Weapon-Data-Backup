# 目录规范化：重命名为带编号的中文目录，建立清晰的收藏结构
import io, os, sys, shutil, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R = r'G:\project\其他\game'

# (旧名, 新高名, 说明)
PLAN = [
    ('安装包',          '01_安装包',            '五区 APK/XAPK + 怀旧服客户端'),
    ('提取资源',        '02_客户端解包',         '五区完整解包 + AssetBundle + 导出资源'),
    ('配置表_解密版',    '03_配置表',            '95 张配置表（XOR 0xFF 解密）'),
    ('剧情文本_解密版',  '04_剧情文本',          '五区剧情 + 未上线剧情'),
    ('剧情文本_表格版',  '05_剧情表格',          '五语对照 CSV/XLSX'),
    ('剧情文本_完整版',  '05_剧情表格/原始文本',  '原始解密文本'),
    ('美术素材_分类',    '06_美术素材',          '19 类分类归档'),
    ('音频资源_整理',    '07_音频资源',          'CV/BGM/音效归档'),
    ('视频资源_整理',    '08_视频资源',          '26 个独立视频（去重）'),
    ('着色器_整理',      '09_着色器',            '45 个独立着色器'),
    ('Lua脚本_整理',     '10_Lua脚本',           '176 个脚本（按模块）'),
    ('官网公告_整理',    '11_官网公告',          '103 条日文公告'),
    ('_旧版HTML_留念',   '_旧版HTML_留念',       '网站化前的 17 个独立页面'),
    ('_重复文件_待删',   '_重复文件_待删',        '59,818 个重复副本（可删）'),
    ('tools',           'tools',               '工具与脚本'),
]

print('=== 目录重命名 ===')
for old, new, note in PLAN:
    src = os.path.join(R, old)
    dst = os.path.join(R, new)
    if not os.path.exists(src):
        print('  跳过（不存在）: %s' % old)
        continue
    if old == new:
        print('  保持: %s' % old)
        continue
    if os.path.exists(dst):
        print('  !! 目标已存在，跳过: %s -> %s' % (old, new))
        continue
    try:
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        shutil.move(src, dst)
        print('  %-18s -> %s' % (old, new))
    except Exception as e:
        print('  失败 %s: %s' % (old, e))

# 空目录清理
print()
print('=== 清理空目录 ===')
for x in sorted(os.listdir(R)):
    p = os.path.join(R, x)
    if os.path.isdir(p) and not os.listdir(p):
        try:
            os.rmdir(p); print('  删除空目录: %s' % x)
        except Exception:
            pass

print()
print('=== 规范化后 ===')
for x in sorted(os.listdir(R)):
    p = os.path.join(R, x)
    if os.path.isdir(p):
        n = sum(len(f) for _, _, f in os.walk(p))
        s = 0
        for dp, _, fs in os.walk(p):
            for f in fs:
                try: s += os.path.getsize(os.path.join(dp, f))
                except Exception: pass
        print('  [DIR] %-24s %7d 个 %9.1f MB' % (x[:24], n, s / 1024 / 1024))
    else:
        print('        %-24s %22s' % (x[:24], '{:,}'.format(os.path.getsize(p))))
