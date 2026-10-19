import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
p = base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
i = raw.find(b'sentence_00001')
ln = struct.unpack_from('<H', raw, i+16)[0]
a = raw[i+20:i+20+ln]

# 关键洞察：0x1C 后跟 0x7C-0x7F
# 0x1C = 0b00011100
# 0x7C = 0b01111100, 0x7D = 01111101, 0x7E = 01111110, 0x7F = 01111111
# 
# 看 16-bit LE: 0x7E1C = 0b0111111000011100
# 看 16-bit BE: 0x1C7E = 0b0001110001111110
#
# 假设这是「UTF-16 但每个 16-bit 值的高 3 位被剥离/重排」
# 0x1C7E = 7286... 不是汉字
#
# 换个角度：0x1C7E ^ 0x4E00 = 0x527E  (不是)
# 0x1C7E + 0x3200 = 0x4E7E  (是汉字！)
# 
# 测试：每个 16-bit BE 单元 + 0x3200 是否得到汉字
units = [(a[j] << 8) | a[j+1] for j in range(0, len(a)-1, 2)]
print('=== 测试 16-bit BE + 常数 ===')
best = []
for k in range(0x10000):
    cnt = sum(1 for u in units[:300] if 0x4E00 <= ((u + k) & 0xFFFF) <= 0x9FFF)
    best.append((cnt, k))
best.sort(reverse=True)
print('  最佳加法常数:')
for cnt, k in best[:5]:
    print('    +0x%04X: %d/300 (%.0f%%)' % (k, cnt, 100*cnt/300))

# 测试 XOR
print()
print('=== 测试 16-bit BE XOR 常数 ===')
best = []
for k in range(0x10000):
    cnt = sum(1 for u in units[:300] if 0x4E00 <= (u ^ k) <= 0x9FFF)
    best.append((cnt, k))
best.sort(reverse=True)
print('  最佳 XOR 常数:')
for cnt, k in best[:5]:
    print('    ^0x%04X: %d/300 (%.0f%%)' % (k, cnt, 100*cnt/300))

# 关键：观察 0x1C 0x7E 对应的汉字应该是什么
# 如果 0x1C7E + 0x3200 = 0x4E7E = 乾 (罕见)
# 试 0x1C7E ^ 0x5262 = 0x4E1C ...
print()
print('=== 0x1C7E 的各种变换 ===')
u = 0x1C7E
for k in [0x3200, 0x3201, 0x3202, 0x5200, 0x4E00, 0x5000]:
    print('  0x%04X + 0x%04X = 0x%04X %r' % (u, k, (u+k)&0xFFFF, chr((u+k)&0xFFFF)))
for k in [0x5200, 0x5262, 0x4E00, 0x3200]:
    print('  0x%04X ^ 0x%04X = 0x%04X %r' % (u, k, u^k, chr(u^k)))
