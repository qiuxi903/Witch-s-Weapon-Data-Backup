import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

hdr = struct.unpack_from('<32I', md, 0)
methods_off = hdr[12]; str_off = hdr[6]; str_count = hdr[7]
REC = 56
N = 113509

# 关键：string 区的 index 是相对于 str_off 的偏移
# 但 EncryptTools 在 3027527，而 str_off=1400568，str_count=1765228
# str_off + str_count = 1400568 + 1765228 = 3165796 = eventsOffset  ✓ 正确
# 所以 string 区确实覆盖到 3165796，3027527 在其中 ✓
# 相对偏移 = 3027527 - 1400568 = 1626959  ✓ 这就是 index

# 但方法表里没有 nameIndex == 1626982
# 可能方法名用的是「字符串字面量」区，或者我读的字段顺序不对
# 让我扫描方法表，统计 nameIndex 的分布范围
print('=== 方法表 nameIndex 范围统计 ===')
minv, maxv = 10**9, 0
sample = []
for i in range(0, N, 1000):
    off = methods_off + i*REC
    n = struct.unpack_from('<I', md, off)[0]
    minv = min(minv, n); maxv = max(maxv, n)
    if i < 5000: sample.append(n)
print('  nameIndex 范围: %d - %d' % (minv, maxv))
print('  前 20 个:', sample[:20])

print()
print('=== 扫描全部方法，找名字含 toDecrypt/toEncrypt 的 ===')
hits = []
for i in range(N):
    off = methods_off + i*REC
    nameIdx = struct.unpack_from('<I', md, off)[0]
    if nameIdx > str_count: continue
    pos = str_off + nameIdx
    end = md.find(b'\x00', pos)
    if end - pos > 40: continue
    s = md[pos:end]
    if s in (b'toDecrypt', b'toEncrypt', b'useMD5', b'EncryptTools'):
        hits.append((i, s.decode(), nameIdx))
        print('  方法 #%d  name=%s  nameIdx=%d' % (i, s.decode(), nameIdx))

print()
print('总命中: %d' % len(hits))
