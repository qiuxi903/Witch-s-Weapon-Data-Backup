# 全库去重：保留每个重复组的「规范副本」，其余移入 _重复文件_待删/
# 安全策略：不直接删除，移到隔离区；保留优先级 = 目录规范度
import io, os, sys, json, shutil, hashlib
from collections import defaultdict

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
QUAR = os.path.join(R, '_重复文件_待删')
os.makedirs(QUAR, exist_ok=True)

groups = json.load(io.open(os.path.join(R, 'tools', '_dup_groups.json'), encoding='utf-8'))
print('重复组 %d' % len(groups))

# 保留优先级：数字越小越优先保留
def rank(path):
    p = path.replace('/', '\\')
    # 1) 整理后的目录最优先
    for i, k in enumerate(['\\美术素材_分类\\', '\\音频资源_整理\\', '\\视频资源_整理\\',
                            '\\着色器_整理\\', '\\Lua脚本_整理\\', '\\配置表_解密版\\',
                            '\\剧情文本_解密版\\', '\\剧情文本_表格版\\', '\\官网公告_整理\\',
                            '\\安装包\\', '\\音乐原声\\', '\\assets\\']):
        if k in p + '\\':
            return i
    # 2) 完整解包目录次之
    if '\\怀旧服v128_完整解包\\' in p: return 20
    if '\\国服v2.0.1_完整解包\\' in p: return 21
    if '\\日服v2.0.0_OBB解包\\' in p: return 22
    if '\\港澳台v1.6.0_OBB解包\\' in p: return 23
    if '\\韩服v1.0_OBB解包\\' in p: return 24
    # 3) 导出目录
    if '\\导出_' in p: return 30
    # 4) 网络资源
    if '\\网络资源\\' in p: return 40
    # 5) 其它
    return 50

moved = 0
freed = 0
log = []
fails = []

for gi, g in enumerate(groups):
    files = g['files']
    # 按优先级 + 路径长度排序
    files_sorted = sorted(files, key=lambda x: (rank(x), len(x)))
    keep = files_sorted[0]
    for f in files_sorted[1:]:
        src = os.path.join(R, f.lstrip('\\'))
        if not os.path.exists(src):
            continue
        # 隔离区路径：保留原目录结构
        rel = f.lstrip('\\')
        dst = os.path.join(QUAR, rel)
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        # 重名冲突加后缀
        if os.path.exists(dst):
            stem, ext = os.path.splitext(dst)
            dst = '%s_%s%s' % (stem, hashlib.md5(f.encode()).hexdigest()[:6], ext)
        try:
            sz = os.path.getsize(src)
            shutil.move(src, dst)
            moved += 1
            freed += sz
            log.append({'keep': keep, 'moved': f, 'bytes': sz})
        except Exception as e:
            fails.append({'file': f, 'err': str(e)[:80]})
    if (gi + 1) % 2000 == 0:
        print('  处理 %d / %d 组, 已移动 %d 个, 释放 %.2f GB'
              % (gi + 1, len(groups), moved, freed / 1024 / 1024 / 1024))

print()
print('=== 去重完成 ===')
print('  移动 %d 个重复文件' % moved)
print('  释放 %.2f GB' % (freed / 1024 / 1024 / 1024))
print('  失败 %d 个' % len(fails))

json.dump({'moved': moved, 'freed': freed, 'log': log[:5000], 'fails': fails[:200]},
          io.open(os.path.join(R, 'tools', '_dedup_log.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)

# 写说明
io.open(os.path.join(QUAR, '_说明.md'), 'w', encoding='utf-8').write(
'''# 重复文件隔离区

本目录存放**全库去重**后判定为重复的文件。

## 说明

- 全库扫描 **104,030 个文件**（不含 `tools/`）
- 发现 **19,388 组**重复（同 MD5）
- 移动 **%d 个**重复副本到此处，释放 **%.2f GB**
- **未删除任何文件** —— 确认无误后可整体删除本目录

## 保留规则

每个重复组保留**路径最规范**的那一份，优先级：

1. 整理后的目录（`美术素材_分类/`、`音频资源_整理/` 等）
2. 完整解包目录（`怀旧服v128_完整解包/` 优先于其它服）
3. 导出目录（`导出_*`）
4. 网络资源
5. 其它

## 恢复

本目录**保持了原目录结构**，如需恢复，把文件移回对应路径即可。

详细记录见 `tools/_dedup_log.json`。
''' % (moved, freed / 1024 / 1024 / 1024))
print('已写说明')
