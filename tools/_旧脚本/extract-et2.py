import io, sys, struct, re

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

# 记录大小 = 15672888 - 15672784 = 104
REC_TD = 104
rec = 15672784
print('=== EncryptTools TypeDefinition (rec size %d) ===' % REC_TD)
vals = struct.unpack_from('<26I', md, rec)
labels = ['nameIndex','namespaceIndex','byvalTypeIndex','byrefTypeIndex',
          'declaringTypeIndex','parentIndex','elementTypeIndex','rgctxStartIndex',
          'rgctxCount','genericContainerIndex','flags','fieldStart',
          'methodStart','eventStart','propertyStart','nestedTypesStart',
          'interfacesStart','vtableStart','interfaceOffsetsStart','?18','?19','?20','?21','?22','?23','?24']
for i, (l, v) in enumerate(zip(labels, vals)):
    print('  [%2d] %-22s = %d (0x%X)' % (i, l, v, v))

# u16 尾部
tail_off = rec + 104 - 16
tail = struct.unpack_from('<8H', md, tail_off)
print()
print('  尾部 u16:', tail)

# 关键字段
method_start = vals[12]
print()
print('methodStart = %d' % method_start)
# 找下一个类型的 methodStart 来界定范围
next_rec = 15672888  # GameAnalytics
next_vals = struct.unpack_from('<26I', md, next_rec)
print('下一个类型 (GameAnalytics) methodStart = %d' % next_vals[12])
print('=> EncryptTools 方法数 = %d' % (next_vals[12] - method_start))

REC_M = 56
print()
print('=== EncryptTools 的方法 ===')
for i in range(method_start, next_vals[12]):
    off = methods_off + i*REC_M
    nameIdx, declType, retType, paramStart, genIdx, mIdx, invIdx, delIdx, rgctxStart, rgctxCnt, token = struct.unpack_from('<11I', md, off)
    flags, iflags, slot, paramCnt = struct.unpack_from('<4H', md, off+44)
    print('  #%d  %-20s token=0x%X flags=0x%X slot=%d params=%d retType=%d' % (
        i, get_str(nameIdx), token, flags, slot, paramCnt, retType))
