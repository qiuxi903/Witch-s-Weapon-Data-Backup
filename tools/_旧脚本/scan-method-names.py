import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

hdr = struct.unpack_from('<66I', md, 0)
str_off = hdr[6]; methods_off = hdr[12]; methods_count = hdr[13]

def get_str(idx):
    pos = str_off + idx
    end = md.find(b'\x00', pos)
    return md[pos:end].decode('utf-8', errors='replace')

# 找 toDecrypt 的 string index
for kw in [b'toDecrypt', b'toEncrypt', b'useMD5']:
    p = md.find(kw)
    s = md.rfind(b'\x00', max(0,p-300), p) + 1
    print('%-12s string idx = %d' % (kw.decode(), s - str_off))

print()
print('=== 扫描整个方法表（113509 条），找名字匹配的 ===')
targets = {}
for kw in [b'toDecrypt', b'toEncrypt', b'useMD5', b'EncryptTools']:
    p = md.find(kw)
    s = md.rfind(b'\x00', max(0,p-300), p) + 1
    targets[s - str_off] = kw.decode()

REC = 56
hits = []
for i in range(113509):
    off = methods_off + i*REC
    nameIdx = struct.unpack_from('<I', md, off)[0]
    if nameIdx in targets:
        declType = struct.unpack_from('<I', md, off+4)[0]
        hits.append((i, targets[nameIdx], declType))
        print('  方法 #%d  name=%s  declType=%d' % (i, targets[nameIdx], declType))

print()
print('命中: %d' % len(hits))

# 也扫描 typeDefinitions 区域找 EncryptTools 作为类型名
print()
print('=== 扫描 typeDefinitions 区域（找 EncryptTools 类型）===')
# typeDefinitions 在 methods 之后、fields 之前？不对。
# 从 header: methods=3668096, parameters=10612368, fields=12235648
# typeDefinitions 应该在某处。扫描 13500000-13600000 之外
enc_idx = md.rfind(b'\x00', 0, md.find(b'EncryptTools')) + 1 - str_off
print('EncryptTools idx = %d' % enc_idx)
# 全文件找 nameIndex == enc_idx
for off in range(0, len(md)-4, 4):
    v = struct.unpack_from('<I', md, off)[0]
    if v == enc_idx:
        print('  @%d' % off)
