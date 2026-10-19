import io, sys, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\怀旧服v128_导出\preserved_stage_manifest.raw'
d = open(p, 'rb').read()

strs = [s.decode('ascii') for s in re.findall(rb'[\x20-\x7e]{3,}', d)]

# 提取所有 scene/map_*.ab 引用
maps = sorted(set(s for s in strs if s.startswith('scene/map_')))
others = sorted(set(s for s in strs if s.startswith('scene/') and not s.startswith('scene/map_')))

print('=== 保留场景（map_*）: %d 个 ===' % len(maps))
for m in maps:
    print('  ' + m)

print()
print('=== 其他场景: %d 个 ===' % len(others))
for m in others:
    print('  ' + m)

# 保存清单
out = r'G:\project\其他\game\提取资源\怀旧服v128_导出\保留场景清单.txt'
with io.open(out, 'w', encoding='utf-8') as f:
    f.write('# 《魔女兵器》怀旧服保留场景清单\n')
    f.write('# 来源: config/preserved_stage_manifest.ab\n\n')
    f.write('## 战斗地图 (%d)\n' % len(maps))
    for m in maps:
        f.write(m + '\n')
    f.write('\n## 其他场景 (%d)\n' % len(others))
    for m in others:
        f.write(m + '\n')
print()
print('已保存: %s' % out)
