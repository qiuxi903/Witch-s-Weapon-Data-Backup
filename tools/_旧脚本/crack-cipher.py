import io, re, sys, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\导出_剧情文本_国服\assets\_temp_config\config\lesson\sentence_30219.json'
with io.open(p, 'r', encoding='utf-8') as f:
    txt = f.read()
m = re.search(r'"bytes":\s*\[([^\]]+)\]', txt)
nums = [int(x.strip()) for x in m.group(1).split(',')]

print('=== 按 position % 3 分组，看各组字节分布 ===')
for r in range(3):
    grp = [nums[i] for i in range(r, len(nums), 3)]
    c = collections.Counter(grp)
    print('  mod3==%d: %d 个, 最常见: %s' % (r, len(grp), [(hex(k), v) for k, v in c.most_common(6)]))
    print('            min=0x%02X max=0x%02X' % (min(grp), max(grp)))

print()
print('=== 假设：UTF-8 中文，每字符 3 字节 E4-E9 xx xx ===')
print('  那么 mod3==0 位置的明文应在 0xE4-0xE9 区间')
print('  若密文 = 明文 XOR key，则 key = 密文 XOR 0xE4..0xE9')

# mod3==0 组的密文最常见值
grp0 = [nums[i] for i in range(0, len(nums), 3)]
c0 = collections.Counter(grp0)
print()
print('  mod3==0 密文最常见: %s' % [(hex(k), v) for k, v in c0.most_common(10)])

# 中文 UTF-8 首字节分布：E4(228) E5(229) E6(230) E7(231) E8(232) E9(233)
# 常见汉字首字节：E4 E5 E6 E7 E8 E9 大致均匀
# 试 key0 = 0x1C XOR 0xE4 = 0xF8
print()
print('=== 尝试推导 key0 ===')
for ct in [0x1C, 0x1A, 0x18, 0x16, 0x17, 0x19, 0x13, 0x14, 0x1B]:
    for pt in [0xE4, 0xE5, 0xE6, 0xE7, 0xE8, 0xE9]:
        k = ct ^ pt
        print('    ct=0x%02X pt=0x%02X -> key=0x%02X' % (ct, pt, k), end='')
    print()

print()
print('=== 更直接：暴力搜索 key0/key1/key2 (各 256 种) ===')
# 评分：解出的文本应该是合法 UTF-8 中文
best = []
for k0 in range(256):
    # 快速预筛：mod3==0 解出的字节应在 E4-E9 附近
    grp0_dec = collections.Counter(b ^ k0 for b in grp0)
    # 统计落在 0xE4-0xE9 的比例
    hit = sum(v for k, v in grp0_dec.items() if 0xE4 <= k <= 0xE9)
    if hit / len(grp0) > 0.5:
        best.append((hit / len(grp0), k0))

best.sort(reverse=True)
print('  候选 key0（mod3==0 解出 E4-E9 比例 >50%%）:')
for ratio, k0 in best[:10]:
    print('    key0=0x%02X (%.1f%%)' % (k0, ratio*100))
