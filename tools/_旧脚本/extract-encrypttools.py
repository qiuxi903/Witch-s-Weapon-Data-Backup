import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

hdr = struct.unpack_from('<66I', md, 0)
str_off = hdr[6]; methods_off = hdr[12]

def get_str(idx):
    pos = str_off + idx
    end = md.find(b'\x00', pos)
    return md[pos:end].decode('utf-8', errors='replace')

# EncryptTools 的 TypeDefinition 在 15672784
# 但记录起点可能更早。Il2CppTypeDefinition v24 结构（92字节）：
#  nameIndex(4) namespaceIndex(4) byvalTypeIndex(4) byrefTypeIndex(4)   = 0,4,8,12
#  declaringTypeIndex(4) parentIndex(4) elementTypeIndex(4) rgctxStartIndex(4) = 16,20,24,28
#  rgctxCount(4) genericContainerIndex(4) flags(4) fieldStart(4)          = 32,36,40,44
#  methodStart(4) eventStart(4) propertyStart(4) nestedTypesStart(4)      = 48,52,56,60
#  interfacesStart(4) vtableStart(4) interfacesCount(2) vtableCount(2)    = 64,68,72,74
#  method_count(2) property_count(2) field_count(2) event_count(2)        = 76,78,80,82
#  nested_type_count(2) ...                                                = 84
# 总 92 字节

# 命中位置 15672784 是 nameIndex 字段
rec_off = 15672784
names = ['nameIndex','namespaceIndex','byvalTypeIndex','byrefTypeIndex',
         'declaringTypeIndex','parentIndex','elementTypeIndex','rgctxStartIndex',
         'rgctxCount','genericContainerIndex','flags','fieldStart',
         'methodStart','eventStart','propertyStart','nestedTypesStart',
         'interfacesStart','vtableStart']
vals = struct.unpack_from('<18I', md, rec_off)
print('=== EncryptTools TypeDefinition @%d ===' % rec_off)
for n, v in zip(names, vals):
    print('  %-22s = %d (0x%X)' % (n, v, v))

# 后面的 u16 字段
tail = struct.unpack_from('<7H', md, rec_off + 72)
print('  interfacesCount=%d vtableCount=%d method_count=%d property_count=%d field_count=%d event_count=%d nested_type_count=%d' % tail)

method_start = vals[12]
method_count = tail[2]
print()
print('=== 方法范围: %d .. %d (%d 个) ===' % (method_start, method_start+method_count, method_count))

REC_M = 56
print()
print('=== EncryptTools 的方法 ===')
for i in range(method_start, method_start + method_count):
    off = methods_off + i*REC_M
    nameIdx, declType, retType, paramStart, genIdx, mIdx, invIdx, delIdx, rgctxStart, rgctxCnt, token = struct.unpack_from('<11I', md, off)
    flags, iflags, slot, paramCnt = struct.unpack_from('<4H', md, off+44)
    print('  #%d  %-20s token=0x%X flags=0x%X slot=%d params=%d retType=%d' % (
        i, get_str(nameIdx), token, flags, slot, paramCnt, retType))
