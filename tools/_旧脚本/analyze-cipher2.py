import io, re, sys, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\导出_剧情文本_国服\assets\_temp_config\config\lesson\sentence_30219.json'
with io.open(p, 'r', encoding='utf-8') as f:
    txt = f.read()

m = re.search(r'"bytes":\s*\[([^\]]+)\]', txt)
nums = [int(x.strip()) for x in m.group(1).split(',')]

# 观察：重复间隔 60 最常见。检查是否是 60 字节的记录结构
print('=== 检查 60 字节周期性 ===')
for period in [60, 47, 62, 63, 30, 20, 15, 12, 10]:
    # 计算 nums[i] == nums[i+period] 的比例
    same = sum(1 for i in range(len(nums)-period) if nums[i] == nums[i+period])
    ratio = same / (len(nums)-period)
    print('  period=%3d  same=%6d/%6d = %5.2f%%' % (period, same, len(nums)-period, ratio*100))

print()
print('=== 关键：0x10 和 0xF6 是否是分隔符 ===')
pos10 = [i for i,b in enumerate(nums) if b == 0x10]
posf6 = [i for i,b in enumerate(nums) if b == 0xF6]
print('  0x10 出现 %d 次，前 20 位置: %s' % (len(pos10), pos10[:20]))
print('  0xF6 出现 %d 次，前 20 位置: %s' % (len(posf6), posf6[:20]))

print()
print('=== 检查低字节区（0x10-0x1F）是否成规律出现 ===')
low = [i for i,b in enumerate(nums) if 0x10 <= b <= 0x1F]
print('  低字节出现 %d 次 (%.1f%%)' % (len(low), 100*len(low)/len(nums)))
gaps = [low[i+1]-low[i] for i in range(len(low)-1)]
gc = collections.Counter(gaps)
print('  低字节间隔分布（前 15）:', gc.most_common(15))

print()
print('=== 假设：这是「每字节 = 明文 XOR 一个 0x10-0x1F 的值」 ===')
print('  观察前 32 字节中，低字节出现在位置:')
for i,b in enumerate(nums[:32]):
    mark = ' <-- 低字节' if 0x10 <= b <= 0x1F else ''
    print('    [%3d] 0x%02X%s' % (i, b, mark))
