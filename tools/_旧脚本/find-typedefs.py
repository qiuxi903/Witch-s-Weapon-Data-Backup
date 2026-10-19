import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

hdr = struct.unpack_from('<66I', md, 0)
str_off = hdr[6]; str_count = hdr[7]
methods_off = hdr[12]; methods_count = hdr[13]

# header 32-65 的字段含义（v24 后半部分）
# 从已知：typeDefinitions 通常在 images 之前
# 让我用已知的偏移推断
print('=== 尝试识别 typeDefinitions 表 ===')
# 已知区域：
#  string: 1400568 .. 3165796
#  events: 3165796
#  properties: 3175232
#  methods: 3668096
#  parameters: 10612368
#  fields: 12235648
#  ...
#  typeDefinitions 应该在 events 之前
# 从 header[32..] 看：13581152, 13593512, 13612080, 14278744, 14386720, ...

# Il2CppTypeDefinition 大小 = 88 字节 (v24)
# 尝试在 3165796 之前找 typeDefinitions
# 实际上 header 顺序：... stringLiteral, string, events, properties, methods,
#   parameterDefaultValues, fieldDefaultValues, fieldAndParameterDefaultValueData,
#   fieldMarshaledSizes, parameters, fields, genericParameters,
#   genericParameterConstraints, genericContainers, typeDefinitions, ...
# 所以 typeDefinitions 在 genericContainers 之后
# genericContainers: 13552592, count 28560
# 下一个：13581152 (hdr[32]) -> 这应该是 typeDefinitions
typeDefs_off = hdr[32]
typeDefs_count = hdr[33]
print('  typeDefinitions: offset=%d count=%d' % (typeDefs_off, typeDefs_count))
REC_TD = 88
print('  记录数 = %d / %d = %.2f' % (typeDefs_count, REC_TD, typeDefs_count/REC_TD))

# 接下来 images
images_off = hdr[34]; images_count = hdr[35]
print('  images: offset=%d count=%d (rec=%d)' % (images_off, images_count, images_count//40))
