import io, sys, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# SymbolMap 记录 = (addr, size)，索引 = methodIndex
sm_p = r'G:\project\其他\game\提取资源\国服DLL\SymbolMap-ARM64'
with open(sm_p, 'rb') as f:
    sm = f.read()
records = []
pos = 4
while pos + 12 <= len(sm):
    addr = struct.unpack_from('<Q', sm, pos)[0]
    size = struct.unpack_from('<I', sm, pos+8)[0]
    records.append((addr, size))
    pos += 12
print('记录数:', len(records))
print('首条 addr=0x%X  (.text 起始 0x1198A80)' % records[0][0])

# metadata
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
# EncryptTools.Bind = 方法 #70297
# 但 methodIndex 字段是 0xFFFFFFFF，说明需要用其他方式索引
# 试试：直接用方法序号 70297 索引 SymbolMap
print()
print('=== 用方法序号直接索引 SymbolMap ===')
for mi in [70297, 70298]:
    if mi < len(records):
        print('  方法 #%d -> addr=0x%X size=0x%X' % (mi, records[mi][0], records[mi][1]))

# 验证：取几个已知方法看地址是否在 .text 范围
print()
print('=== 验证 SymbolMap 索引方式 ===')
print('  .text 范围: 0x1198A80 - 0x%X' % (0x1198A80 + 0x2F14B90))
in_text = sum(1 for a, s in records if 0x1198A80 <= a < 0x1198A80 + 0x2F14B90)
print('  落在 .text 的记录: %d / %d (%.1f%%)' % (in_text, len(records), 100*in_text/len(records)))

# 方法表里 methodIndex 字段的分布
print()
print('=== 方法表中 methodIndex 字段分布 ===')
vals = []
for i in range(0, 100000, 1000):
    off = methods_off + i*REC_M
    mi = struct.unpack_from('<I', md, off+20)[0]
    vals.append(mi)
print('  前 100 个采样:', vals[:20])
nonzero = [v for v in vals if v != 0xFFFFFFFF]
print('  非 0xFFFFFFFF 的: %d / %d' % (len(nonzero), len(vals)))
