import io, sys, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

hdr = struct.unpack_from('<66I', md, 0)
str_off = hdr[6]; methods_off = hdr[12]

def get_str(idx):
    if idx >= 2000000: return '?'
    pos = str_off + idx
    end = md.find(b'\x00', pos)
    return md[pos:end].decode('utf-8', errors='replace')

REC_M = 56
# 用已知方法 #0 (.ctor) 验证布局
print('=== 验证方法记录布局 (方法 #0) ===')
off = methods_off + 0
raw = md[off:off+REC_M]
print('  raw hex:', raw.hex())
vals = struct.unpack_from('<14I', md, off)
for i, v in enumerate(vals):
    s = ''
    if v < 2000000:
        t = get_str(v)
        if t and len(t) >= 2 and all(32 <= ord(c) < 127 for c in t):
            s = repr(t[:40])
    print('  [%2d] @+%-3d = %-12d (0x%08X)  %s' % (i, i*4, v, v, s))

print()
print('=== 方法 #70297 (EncryptTools.Bind) ===')
off = methods_off + 70297*REC_M
raw = md[off:off+REC_M]
print('  raw hex:', raw.hex())
vals = struct.unpack_from('<14I', md, off)
for i, v in enumerate(vals):
    s = ''
    if v < 2000000:
        t = get_str(v)
        if t and len(t) >= 2 and all(32 <= ord(c) < 127 for c in t):
            s = repr(t[:40])
    print('  [%2d] @+%-3d = %-12d (0x%08X)  %s' % (i, i*4, v, v, s))

print()
print('=== 方法 #70298 (EncryptTools..ctor) ===')
off = methods_off + 70298*REC_M
vals = struct.unpack_from('<14I', md, off)
for i, v in enumerate(vals):
    s = ''
    if v < 2000000:
        t = get_str(v)
        if t and len(t) >= 2 and all(32 <= ord(c) < 127 for c in t):
            s = repr(t[:40])
    print('  [%2d] @+%-3d = %-12d (0x%08X)  %s' % (i, i*4, v, v, s))

# 检查方法 #70297 附近是否有 toDecrypt 相关
print()
print('=== 方法 #70290 - #70310 的名字 ===')
for i in range(70290, 70310):
    off = methods_off + i*REC_M
    nameIdx = struct.unpack_from('<I', md, off)[0]
    print('  #%d  %s' % (i, get_str(nameIdx)))
