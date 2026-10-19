import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

hdr = struct.unpack_from('<66I', md, 0)
str_off = hdr[6]

pos = md.find(b'EncryptTools')
start = md.rfind(b'\x00', max(0,pos-300), pos) + 1
enc_str_idx = start - str_off
print('EncryptTools string index = %d' % enc_str_idx)

# 全文件扫描 nameIndex == enc_str_idx 的 4 字节对齐位置
print()
print('=== 全文件扫描（4 字节对齐）===')
hits = []
for off in range(0, len(md)-4, 4):
    v = struct.unpack_from('<I', md, off)[0]
    if v == enc_str_idx:
        hits.append(off)
print('命中 %d 处:' % len(hits))
for h in hits[:40]:
    # 打印周围
    vals = struct.unpack_from('<8I', md, h)
    print('  @%-9d  %s' % (h, ' '.join('%d' % v for v in vals)))

# 也许 string index 不是相对 str_off，而是绝对偏移
print()
print('=== 用绝对偏移 %d 扫描 ===' % start)
hits2 = []
for off in range(0, len(md)-4, 4):
    v = struct.unpack_from('<I', md, off)[0]
    if v == start:
        hits2.append(off)
print('命中 %d 处: %s' % (len(hits2), hits2[:20]))
