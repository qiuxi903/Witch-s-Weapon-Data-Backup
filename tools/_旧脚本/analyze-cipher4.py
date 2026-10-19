import io, re, sys, collections, math, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\导出_剧情文本_国服\assets\_temp_config\config\lesson\sentence_30219.json'
with io.open(p, 'r', encoding='utf-8') as f:
    txt = f.read()
m = re.search(r'"bytes":\s*\[([^\]]+)\]', txt)
nums = [int(x.strip()) for x in m.group(1).split(',')]

print('=== 关键发现：0x00-0x0F, 0x20-0x2F, 0xE0-0xEF 三个块完全缺失 ===')
print('=== 这是「量化」特征，不是加密 ===')
print()

# 假设：这是 7-bit ASCII 文本，但每个字节被「展开」了
# 观察：出现最多的值是 0x40-0x7F 区间（16141+15532+17561+32173 = 81407，占 49.8%）
# 0x40-0x7F 正是 ASCII 大写字母、小写字母、数字的范围！
print('=== 0x40-0x7F 占比: %.1f%% ===' % (100*(16141+15532+17561+32173)/len(nums)))
print('  这正是 ASCII 可打印字符的范围 (A-Z a-z 0-9 等)')
print()

# 假设：每���「逻辑字符」用 2 个字节表示？
# 检查是否 nums[2i] 和 nums[2i+1] 有不同分布
print('=== 按 mod 2 分组 ===')
for r in range(2):
    grp = [nums[i] for i in range(r, len(nums), 2)]
    c = collections.Counter(grp)
    print('  mod2==%d: 最常见 %s' % (r, [(hex(k), v) for k, v in c.most_common(5)]))

print()
print('=== 按 mod 4 分组 ===')
for r in range(4):
    grp = [nums[i] for i in range(r, len(nums), 4)]
    c = collections.Counter(grp)
    print('  mod4==%d: 最常见 %s' % (r, [(hex(k), v) for k, v in c.most_common(5)]))

print()
print('=== 假设：这是 UTF-16BE/LE 被某种方式处理 ===')
# UTF-16 中文: 4E00-9FFF -> 高字节 4E-9F, 低字节 00-FF
# 观察 0x40-0x7F 和 0x80-0x9F 都很多，符合 UTF-16 高字节特征
# 但低字节 0x00-0x0F 缺失，说明低字节不是原始值
print()

# 关键测试：如果这是 UTF-16BE，每 2 字节是一个字符
# 中文 CJK 范围 0x4E00-0x9FFF
cnt_cjk = 0
cnt_ascii = 0
cnt_other = 0
for i in range(0, len(nums)-1, 2):
    ch = (nums[i] << 8) | nums[i+1]
    if 0x4E00 <= ch <= 0x9FFF:
        cnt_cjk += 1
    elif 0x20 <= ch <= 0x7E:
        cnt_ascii += 1
    else:
        cnt_other += 1
print('  按 UTF-16BE 解释 (%d 个字符):' % (len(nums)//2))
print('    CJK 汉字 (4E00-9FFF): %6d (%.1f%%)' % (cnt_cjk, 100*cnt_cjk/(len(nums)//2)))
print('    ASCII 可打印:         %6d (%.1f%%)' % (cnt_ascii, 100*cnt_ascii/(len(nums)//2)))
print('    其它:                 %6d (%.1f%%)' % (cnt_other, 100*cnt_other/(len(nums)//2)))

print()
print('=== 检查是否有重复的 2 字节模式（可能是高频汉字）===')
pairs = [bytes(nums[i:i+2]) for i in range(0, len(nums)-1, 2)]
pc = collections.Counter(pairs)
print('  最常见 2 字节对:')
for k, v in pc.most_common(15):
    ch = (k[0] << 8) | k[1]
    print('    %s (0x%04X) x%d' % (k.hex(), ch, v))
