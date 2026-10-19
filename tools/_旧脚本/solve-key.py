import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
p = base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
i = raw.find(b'sentence_00001')
ln = struct.unpack_from('<H', raw, i+16)[0]
ct = raw[i+20:i+20+ln]

# 明文 UTF-8 中文的字节分布（典型）：
#   0xE4-0xE9 (高 nibble E)  : 约 33%
#   0x80-0xBF (高 nibble 8-B) : 约 66%
#   ASCII 标点 (0x20-0x7E)   : 少量
#
# 密文高 nibble 分布：0:14.4% 1:16.7% 2:2.0% 3:1.8% 4:8.1% 5:8.0% 6:9.6% 7:12.4% 8:4.9% 9:9.3%
#
# 如果 XOR 常数 K，则明文高 nibble 集合 {E, 8,9,A,B} 应映射到密文的高频集合
# 密文高频: 0(14.4), 1(16.7), 7(12.4), 6(9.6), 9(9.3), 4(8.1), 5(8.0)
#
# 假设明文 E(33%) -> 密文 1(16.7%) + 0(14.4%) = 31%  ✓ 接近!
#   即 E ^ K 的高 nibble = 0 或 1
# 
# 但 XOR 是逐位的，高 nibble 的映射不是简单加法
# E = 1110, 要变成 0000 或 0001，K 的高 nibble 需为 1110 或 1111
# 即 K 高 nibble = E 或 F

print('=== 假设 K 高 nibble = 0xE 或 0xF ===')
# 明文 8-B (66%) 映射到密文的哪些高 nibble？
# 8 ^ E = 6, 9 ^ E = 7, A ^ E = 4, B ^ E = 5
# 所以密文高 nibble 应为 6,7,4,5 -> 观察: 6(9.6) 7(12.4) 4(8.1) 5(8.0) = 38.1%
# 但明文 8-B 占 66%! 不匹配。
#
# 试 K 高 nibble = F: 8^F=7, 9^F=6, A^F=5, B^F=4 -> 同样 4,5,6,7 = 38.1%
# 
# 都不够。说明不是单字节 XOR。

# 换个思路：明文 8-B 占 66%，密文里哪个高 nibble 组合占 66%？
# 0(14.4)+1(16.7)+7(12.4)+6(9.6)+4(8.1)+5(8.0) = 69.2%  ← 接近 66%!
# 这 6 个 nibble: 0,1,4,5,6,7
# 明文 8,9,A,B 四个值映射到 6 个值 -> 不是双射，说明有额外变换

print()
print('=== 关键：检查密文是否 = 明文 XOR K 后再做半字节交换 ===')
# 或者：这是「UTF-16」！
# UTF-16 中文: 0x4E00-0x9FFF -> 高字节 4E-9F, 低字节 00-FF
# 高字节高 nibble: 4-9
# 密文高 nibble 高频: 0,1,4,5,6,7
# 4,5,6,7 占了 38%... 
# 
# 试：密文 = UTF-16LE 明文 XOR 常数
# 明文 UTF-16LE: 低字节先
# 中文 0x4E2D -> 2D 4E
# 低字节 0x00-0xFF 均匀，高字节 0x4E-0x9F

units_le = [ct[j] | (ct[j+1] << 8) for j in range(0, len(ct)-1, 2)]
units_be = [(ct[j] << 8) | ct[j+1] for j in range(0, len(ct)-1, 2)]

for name, units in [('LE', units_le), ('BE', units_be)]:
    print()
    print('=== %s: 高字节高 nibble 分布 ===' % name)
    hi = [u >> 8 for u in units]
    c = collections.Counter(h >> 4 for h in hi)
    for k in sorted(c):
        print('   0x%X: %d (%.1f%%)' % (k, c[k], 100*c[k]/len(hi)))
