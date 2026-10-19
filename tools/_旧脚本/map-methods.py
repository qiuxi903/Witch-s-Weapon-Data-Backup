import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# 1) 解析 SymbolMap: 12字节记录，从 offset 4 开始
p = r'G:\project\其他\game\提取资源\国服DLL\SymbolMap-ARM64'
with open(p, 'rb') as f:
    sm = f.read()

records = []
pos = 4
while pos + 12 <= len(sm):
    addr = struct.unpack_from('<Q', sm, pos)[0]
    size = struct.unpack_from('<I', sm, pos+8)[0]
    records.append((addr, size))
    pos += 12

print('SymbolMap 记录数: %d' % len(records))
print('  首条: addr=0x%X size=0x%X' % records[0])
print('  末条: addr=0x%X size=0x%X' % records[-1])
# 检查连续性
gaps = 0
for i in range(1, min(1000, len(records))):
    if records[i][0] != records[i-1][0] + records[i-1][1]:
        gaps += 1
print('  前 1000 条中不连续: %d' % gaps)
print()

# 2) global-metadata.dat 的方法表
mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

# metadata v24 头部字段（Il2CppGlobalMetadataHeader）
hdr = struct.unpack_from('<32I', md, 0)
names = ['sanity','version','stringLiteralOffset','stringLiteralCount',
         'stringLiteralDataOffset','stringLiteralDataCount',
         'stringOffset','stringCount',
         'eventsOffset','eventsCount',
         'propertiesOffset','propertiesCount',
         'methodsOffset','methodsCount',
         'parameterDefaultValuesOffset','parameterDefaultValuesCount',
         'fieldDefaultValuesOffset','fieldDefaultValuesCount',
         'fieldAndParameterDefaultValueDataOffset','fieldAndParameterDefaultValueDataCount',
         'fieldMarshaledSizesOffset','fieldMarshaledSizesCount',
         'parametersOffset','parametersCount',
         'fieldsOffset','fieldsCount',
         'genericParametersOffset','genericParametersCount',
         'genericParameterConstraintsOffset','genericParameterConstraintsCount',
         'genericContainersOffset','genericContainersCount']
print('=== metadata 头部 ===')
for i, n in enumerate(names):
    print('  [%2d] %-42s = %d (0x%X)' % (i, n, hdr[i], hdr[i]))

# 找 methods 表
print()
# 方法名在 stringOffset 区，方法记录在 methodsOffset 区
# Il2CppMethodDefinition: nameIndex(4) declaringType(4) returnType(4) 
#   parameterStart(4) genericContainerIndex(4) methodIndex(4) invokerIndex(4)
#   delegateWrapperIndex(4) rgctxStartIndex(4) rgctxCount(4) token(4) flags(2) iflags(2) slot(2) parameterCount(2)
print('=== 搜索 EncryptTools 在 string 区的位置 ===')
i = md.find(b'EncryptTools')
print('  字符串位置: %d' % i)
# string 区从 stringOffset 开始
str_off = hdr[6]
print('  string 区起始: %d' % str_off)
print('  相对偏移: %d' % (i - str_off))
