import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
start = 0x6AF + 4
ln = struct.unpack_from('<I', raw, 0x6AF)[0]
data = raw[start:start+ln]

# 45% CJK 说明是 UTF-16，但变换非恒定
# 检查：是否 16-bit 单元的高字节被 XOR 了，低字节保持？
# UTF-16BE 中文: 高字节 0x4E-0x9F, 低字节 0x00-0xFF
units_be = [(data[i] << 8) | data[i+1] for i in range(0, len(data)-1, 2)]
hi = [u >> 8 for u in units_be]
lo = [u & 0xFF for u in units_be]

print('=== UTF-16BE 高字节分布 ===')
ch = collections.Counter(hi)
print('  最常见:', [(hex(k), v) for k, v in ch.most_common(12)])
print('  范围: 0x%02X - 0x%02X' % (min(hi), max(hi)))

print()
print('=== UTF-16BE 低字节分布 ===')
cl = collections.Counter(lo)
print('  最常见:', [(hex(k), v) for k, v in cl.most_common(12)])
print('  范围: 0x%02X - 0x%02X' % (min(lo), max(lo)))

# 中文 UTF-16 高字节应在 0x4E-0x9F
# 观察实际高字节常见值：0x1A, 0x76, 0x5E, 0x19...
# 如果 高字节 XOR key_hi 得到 0x4E-0x9F:
print()
print('=== 推导高字节 XOR key ===')
# 假设最常见的高字节 0x1A 对应最常见的汉字高字节 0x4E-0x9F
for ct in [0x1A, 0x76, 0x5E, 0x19, 0x7A, 0x18, 0x17]:
    for pt in [0x4E, 0x5B, 0x65, 0x6B, 0x76, 0x8B, 0x9F]:
        k = ct ^ pt
        print('    ct=0x%02X pt=0x%02X -> key=0x%02X' % (ct, pt, k), end='')
    print()

print()
print('=== 关键测试：高字节 XOR 0x54 (0x1A^0x4E) ===')
for k in [0x54, 0x38, 0x34, 0x2C, 0x24]:
    dec_hi = [h ^ k for h in hi]
    cjk = sum(1 for h in dec_hi if 0x4E <= h <= 0x9F)
    print('  key=0x%02X: 高字节落在 0x4E-0x9F 的比例 %.1f%%' % (k, 100*cjk/len(dec_hi)))

print()
print('=== 暴力搜索高字节 key (256 种) ===')
best = []
for k in range(256):
    cjk = sum(1 for h in hi if 0x4E <= (h ^ k) <= 0x9F)
    best.append((cjk/len(hi), k))
best.sort(reverse=True)
print('  最佳高字节 key:')
for r, k in best[:8]:
    print('    key=0x%02X: %.1f%%' % (k, r*100))
