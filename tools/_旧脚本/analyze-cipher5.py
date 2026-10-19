import io, re, sys, collections, math

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\导出_剧情文本_国服\assets\_temp_config\config\lesson\sentence_30219.json'
with io.open(p, 'r', encoding='utf-8') as f:
    txt = f.read()
m = re.search(r'"bytes":\s*\[([^\]]+)\]', txt)
nums = [int(x.strip()) for x in m.group(1).split(',')]

# 16-bit 单元
units = [(nums[i] << 8) | nums[i+1] for i in range(0, len(nums)-1, 2)]
print('16-bit 单元数:', len(units))

c = collections.Counter(units)
print()
print('=== 最常见 16-bit 单元 ===')
for k, v in c.most_common(20):
    print('  0x%04X x%-6d  (高字节 0x%02X 低字节 0x%02X)' % (k, v, k >> 8, k & 0xFF))

print()
print('=== 假设 1：16-bit XOR 常数 ===')
# 中文最常见字：的(7684) 了(4E86) 是(662F) 我(6211) 你(4F60) 不(4E0D) 一(4E00) 在(5728)
common = [0x7684, 0x4E86, 0x662F, 0x6211, 0x4F60, 0x4E0D, 0x4E00, 0x5728, 0x6709, 0x4EBA]
top_ct = c.most_common(10)
for ct, cnt in top_ct[:5]:
    print('  密文 0x%04X (x%d):' % (ct, cnt))
    for pt in common[:6]:
        k = ct ^ pt
        print('      若明文 0x%04X (%s) -> key 0x%04X' % (pt, chr(pt) if pt < 0x10000 else '?', k))

print()
print('=== 假设 2：字节交换后 XOR ===')
for ct, cnt in top_ct[:3]:
    sw = ((ct & 0xFF) << 8) | (ct >> 8)
    print('  密文 0x%04X 交换后 0x%04X:' % (ct, sw))
    for pt in common[:6]:
        k = sw ^ pt
        print('      明文 0x%04X -> key 0x%04X' % (pt, k))

print()
print('=== 假设 3：这是「每字节 + 偏移」的 16-bit 加法 ===')
for ct, cnt in top_ct[:3]:
    for pt in [0x7684, 0x4E86, 0x662F]:
        k = (ct - pt) & 0xFFFF
        print('  密文 0x%04X - 明文 0x%04X = 0x%04X' % (ct, pt, k))

print()
print('=== 假设 4：检查高位/低位字节是否独立变换 ===')
hi = collections.Counter(u >> 8 for u in units)
lo = collections.Counter(u & 0xFF for u in units)
print('  高字节最常见:', [(hex(k), v) for k, v in hi.most_common(8)])
print('  低字节最常见:', [(hex(k), v) for k, v in lo.most_common(8)])
print('  高字节范围: 0x%02X - 0x%02X' % (min(hi), max(hi)))
print('  低字节范围: 0x%02X - 0x%02X' % (min(lo), max(lo)))

print()
print('=== 假设 5：bit 旋转 (rotate) ===')
def rol16(v, n):
    return ((v << n) | (v >> (16 - n))) & 0xFFFF
for n in range(1, 16):
    rot = [rol16(u, n) for u in units]
    cjk = sum(1 for r in rot if 0x4E00 <= r <= 0x9FFF)
    if cjk / len(rot) > 0.5:
        print('  rol16(%d): CJK 比例 %.1f%%  <-- 候选!' % (n, 100*cjk/len(rot)))
