import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

hdr = struct.unpack_from('<66I', md, 0)
str_off = hdr[6]; str_count = hdr[7]

# EncryptTools 的 string index
pos = md.find(b'EncryptTools')
# 往前找字符串起点
start = md.rfind(b'\x00', max(0,pos-300), pos) + 1
enc_str_idx = start - str_off
print('EncryptTools string index = %d (pos=%d)' % (enc_str_idx, start))

# Il2CppTypeDefinition (v24):
#   nameIndex(4) namespaceIndex(4) byvalTypeIndex(4) byrefTypeIndex(4)
#   declaringTypeIndex(4) parentIndex(4) elementTypeIndex(4) rgctxStartIndex(4)
#   rgctxCount(4) genericContainerIndex(4) flags(4) fieldStart(4)
#   methodStart(4) eventStart(4) propertyStart(4) nestedTypesStart(4)
#   interfacesStart(4) vtableStart(4) interfacesCount(2) vtableCount(2)
#   method_count(2) property_count(2) field_count(2) event_count(2)
#   nested_type_count(2) ... 总 88 字节? 让我用 92
# 实际 v24 Il2CppTypeDefinition = 0x5C = 92 字节
REC_TD = 92

# 扫描候选偏移：找 nameIndex == enc_str_idx 的记录
print()
print('=== 扫描各候选偏移，找 nameIndex == %d ===' % enc_str_idx)
best = []
for off in range(13500000, 13620000, 4):
    v = struct.unpack_from('<I', md, off)[0]
    if v == enc_str_idx:
        # 检查后续字段是否合理
        ns = struct.unpack_from('<I', md, off+4)[0]
        best.append((off, ns))
        print('  候选 @%d  namespaceIndex=%d' % (off, ns))

print()
print('候选数: %d' % len(best))
