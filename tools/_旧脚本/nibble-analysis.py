import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
p = base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
i = raw.find(b'sentence_00001')
ln = struct.unpack_from('<H', raw, i+16)[0]
a = raw[i+20:i+20+ln]

# 关键：0x1C 后跟 0x7C-0x7F，且 0x1C 出现 89 次
# 0x1C = 28. 如果这是「长度」，28 字节的字符串？
# 但 0x1C 0x7E 后面没有 28 字节的规律结构
#
# 新思路：观察 0x1C 0x7E 的重复模式
# @405-420: 1c7e50 1c7f7e 1c7e7d 1c7d76 1c7d79 1c7d74
# 这些是 3 字节组：1c 7e 50 / 1c 7f 7e / 1c 7e 7d ...
# 
# 或者 2 字节：1c7e, 501c, 7f7e, 1c7e, 7d1c, 7d76...
#
# 关键：1c 7e / 1c 7d / 1c 7f / 1c 7c 的第二字节都在 0x7C-0x7F
# 这是「最高两位为 01」的范围
# 0x7C = 0111 1100
# 
# 假设：这是 base-128 varint 或 6-bit 编码
# 
# 决定性测试：统计每个字节的高 2 位分布
print('=== 字节高 2 位分布 ===')
hi2 = collections.Counter(b >> 6 for b in a)
for k in sorted(hi2):
    print('  0b%02d (0x%02X-0x%02X): %d (%.1f%%)' % (k, k<<6, (k<<6)|0x3F, hi2[k], 100*hi2[k]/len(a)))

print()
print('=== 字节高 3 位分布 ===')
hi3 = collections.Counter(b >> 5 for b in a)
for k in sorted(hi3):
    print('  0b%03d (0x%02X-0x%02X): %d (%.1f%%)' % (k, k<<5, (k<<5)|0x1F, hi3[k], 100*hi3[k]/len(a)))

print()
print('=== 字节低 4 位分布（看是否有 nibble 结构）===')
lo4 = collections.Counter(b & 0xF for b in a)
for k in sorted(lo4):
    print('  0x%X: %d (%.1f%%)' % (k, lo4[k], 100*lo4[k]/len(a)))

print()
print('=== 字节高 4 位分布 ===')
hi4 = collections.Counter(b >> 4 for b in a)
for k in sorted(hi4):
    print('  0x%X: %d (%.1f%%)' % (k, hi4[k], 100*hi4[k]/len(a)))
