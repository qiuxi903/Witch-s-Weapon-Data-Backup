import io, sys, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
p = base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
i = raw.find(b'sentence_00001')
ln = struct.unpack_from('<H', raw, i+16)[0]
a = raw[i+20:i+20+ln]

# 最终观察：把数据按 2 字节分组，看 16-bit BE 值的分布
units = [(a[j] << 8) | a[j+1] for j in range(0, len(a)-1, 2)]

print('=== 16-bit BE 单元的高 6 位分布 ===')
import collections
c = collections.Counter(u >> 10 for u in units)
for k in sorted(c):
    print('  %2d (0x%04X-0x%04X): %d' % (k, k<<10, (k<<10)|0x3FF, c[k]))

print()
print('=== 16-bit BE 单元的低 10 位分布（前 20）===')
c2 = collections.Counter(u & 0x3FF for u in units)
for k, v in c2.most_common(20):
    print('  0x%03X: %d' % (k, v))

# 关键：0x1C7E = 0b0001110001111110
# 高 6 位 = 0b000111 = 7
# 低 10 位 = 0b0001111110 = 126
# 
# 如果这是 UTF-16 汉字的某种编码...
# 汉字 0x4E00-0x9FFF 高 6 位范围 = 0b010011 - 0b100111 = 19 - 39
# 观察实际分布是否集中
print()
print('=== 检查：如果 XOR 0x8000 后再看 ===')
c3 = collections.Counter((u ^ 0x8000) >> 10 for u in units)
for k in sorted(c3):
    print('  %2d: %d' % (k, c3[k]))
