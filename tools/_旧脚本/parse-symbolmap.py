import io, sys, struct, re, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# 1) 解析 SymbolMap-ARM64
p = r'G:\project\其他\game\提取资源\国服DLL\SymbolMap-ARM64'
with open(p, 'rb') as f:
    sm = f.read()
print('SymbolMap 大小:', len(sm))
print('前 64 字节:', sm[:64].hex())
print()

# 尝试：每条记录 = 8字节地址 + 4字节长度? 或 8+8
# 从前面看：地址递增，后面有个小值（长度）
# 记录结构猜测：addr(8) + size(4) + pad(4)?  => 16 字节
rec16 = len(sm) // 16
print('按 16 字节/记录: %d 条' % rec16)
print('  前 5 条:')
for i in range(5):
    off = i * 16
    addr = struct.unpack_from('<Q', sm, off)[0]
    size = struct.unpack_from('<I', sm, off + 8)[0]
    print('    addr=0x%012X size=0x%X' % (addr, size))

print()
# 2) 在 global-metadata.dat 里找解密相关字符串
mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()
print('global-metadata.dat 大小:', len(md))

kws = [b'Decrypt', b'decrypt', b'Encrypt', b'encrypt', b'isEncrypt', b'IsEncrypt',
       b'XXTEA', b'Aes', b'AES', b'Rijndael', b'RC4', b'Des', b'Crypto',
       b'Lesson', b'lesson', b'Sentence', b'sentence', b'Config', b'TempConfig']
print()
print('=== global-metadata.dat 中的关键词 ===')
for kw in kws:
    idxs = []
    start = 0
    while True:
        i = md.find(kw, start)
        if i < 0: break
        idxs.append(i)
        start = i + 1
        if len(idxs) > 20: break
    if idxs:
        print('  %-14s x%-4d 位置: %s' % (kw.decode(), len(idxs), idxs[:8]))
