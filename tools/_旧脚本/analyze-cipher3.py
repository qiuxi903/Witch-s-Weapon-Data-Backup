import io, re, sys, collections, math

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\导出_剧情文本_国服\assets\_temp_config\config\lesson\sentence_30219.json'
with io.open(p, 'r', encoding='utf-8') as f:
    txt = f.read()
m = re.search(r'"bytes":\s*\[([^\]]+)\]', txt)
nums = [int(x.strip()) for x in m.group(1).split(',')]

print('=== 三个 mod3 组分布完全相同 -> 不是位置相关变换 ===')
print()

# 检查字节值集合：是否只有 160 种？哪些值缺失？
present = set(nums)
missing = sorted(set(range(256)) - present)
print('缺失的字节值 (%d 种):' % len(missing))
print(' ', [hex(x) for x in missing])
print()

# 观察：缺失值是否有规律？
# 分成 0x00-0x0F, 0x10-0x1F ...
print('=== 按 16 字节块统计缺失 ===')
for blk in range(16):
    lo, hi = blk*16, blk*16+15
    miss = [x for x in range(lo, hi+1) if x not in present]
    cnt = sum(1 for x in nums if lo <= x <= hi)
    print('  0x%02X-0x%02X: 出现 %6d 次, 缺失 %2d 个 %s' % (lo, hi, cnt, len(miss), [hex(x) for x in miss]))

print()
print('=== 关键洞察：如果这是 7-bit 数据（每字节只用低 7 位）===')
# 检查每个字节的高位
highbit = sum(1 for b in nums if b & 0x80)
print('  最高位为 1 的字节: %d (%.1f%%)' % (highbit, 100*highbit/len(nums)))
print('  若为 7-bit 打包，应接近 0% 或 50%')

print()
print('=== 检查是否是 base128 / varint 编码 ===')
# varint: 每字节低 7 位是数据，最高位是续接标志
# 统计连续高位字节的长度
runs = []
cur = 0
for b in nums:
    if b & 0x80:
        cur += 1
    else:
        runs.append(cur)
        cur = 0
rc = collections.Counter(runs)
print('  高位连续长度分布:', sorted(rc.items())[:12])

print()
print('=== 熵分析 ===')
c = collections.Counter(nums)
ent = -sum((v/len(nums)) * math.log2(v/len(nums)) for v in c.values())
print('  香农熵: %.4f bits/byte (最大 8.0)' % ent)
print('  若为随机/加密数据应接近 8.0；若为文本应约 4-5')

print()
print('=== 检查 0x10 是否总是出现在特定上下文 ===')
# 之前看到 0x10 出现在位置 0, 53, 99, 116, 131...
pos10 = [i for i,b in enumerate(nums) if b == 0x10]
print('  0x10 位置差（前 30）:', [pos10[i+1]-pos10[i] for i in range(min(30,len(pos10)-1))])
