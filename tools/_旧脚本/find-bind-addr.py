import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

hdr_mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(hdr_mp, 'rb') as f:
    md = f.read()

hdr = struct.unpack_from('<66I', md, 0)
str_off = hdr[6]; methods_off = hdr[12]

def get_str(idx):
    if idx >= 2000000: return '?'
    pos = str_off + idx
    end = md.find(b'\x00', pos)
    return md[pos:end].decode('utf-8', errors='replace')

# 方法 #70297 (Bind) 的完整信息
REC_M = 56
off = methods_off + 70297*REC_M
vals = struct.unpack_from('<11I', md, off)
labels = ['nameIndex','declaringType','returnType','parameterStart','genericContainerIndex',
          'methodIndex','invokerIndex','delegateWrapperIndex','rgctxStartIndex','rgctxCount','token']
print('=== EncryptTools.Bind 方法记录 ===')
for l, v in zip(labels, vals):
    extra = ''
    if l in ('nameIndex','declaringType','returnType'):
        extra = ' -> ' + repr(get_str(v)[:40])
    print('  %-24s = %d (0x%X)%s' % (l, v, v, extra))
flags, iflags, slot, paramCnt = struct.unpack_from('<4H', md, off+44)
print('  flags=0x%X iflags=0x%X slot=%d paramCount=%d' % (flags, iflags, slot, paramCnt))

# methodIndex 是关键！它对应 Il2CppCodeGenModule 的方法指针表
print()
print('=== 关键：methodIndex = %d ===' % vals[5])
print('=== 这对应 libil2cpp.so 中的方法指针表索引 ===')

# 解析 SymbolMap 找地址
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
print('SymbolMap 记录数: %d' % len(records))

mi = vals[5]
if mi < len(records):
    print('  方法索引 %d -> addr=0x%X size=0x%X' % (mi, records[mi][0], records[mi][1]))
else:
    print('  方法索引 %d 超出 SymbolMap 范围' % mi)
