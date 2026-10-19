import io, sys, re, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

# global-metadata.dat 头部结构
# magic(4) version(4) ...
print('=== global-metadata.dat 头部 ===')
print('  magic:', md[:4].hex(), repr(md[:4]))
ver = struct.unpack_from('<i', md, 4)[0]
print('  version:', ver)
# 2017.4 的 metadata 版本约 24
for i in range(8, 16):
    v = struct.unpack_from('<i', md, i*4)[0]
    print('  field[%d] @%d = %d (0x%X)' % (i, i*4, v, v & 0xFFFFFFFF))

print()
print('=== 查找 toDecrypt / toEncrypt 字符串 ===')
for kw in [b'toDecrypt', b'toEncrypt', b'useMD5']:
    idxs = []
    start = 0
    while True:
        i = md.find(kw, start)
        if i < 0: break
        idxs.append(i); start = i+1
    print('  %-12s x%d 位置: %s' % (kw.decode(), len(idxs), idxs[:10]))

print()
print('=== toDecrypt 上下文 ===')
i = md.find(b'toDecrypt')
if i >= 0:
    lo=max(0,i-200); hi=min(len(md),i+300)
    parts = re.findall(rb'[\x20-\x7e]{2,}', md[lo:hi])
    print('  ', ' | '.join(p.decode('ascii') for p in parts))
