import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

hdr = struct.unpack_from('<32I', md, 0)
methods_off = hdr[12]; str_off = hdr[6]
typeDefs_off = None
# 需要 typeDefinitions 偏移 —— 在 header 后面还有更多字段
# v24 header 有 66 个字段
hdr_full = struct.unpack_from('<66I', md, 0)
print('=== 完整 header (前 66 字段) ===')
for i in range(32, 66):
    if i*4 + 4 <= len(md):
        print('  [%2d] @%-4d = %d (0x%X)' % (i, i*4, hdr_full[i], hdr_full[i]))

REC = 56
def get_str(idx):
    pos = str_off + idx
    end = md.find(b'\x00', pos)
    return md[pos:end].decode('utf-8', errors='replace')

# 目标 string idx
target_idx = 1626982  # toDecrypt
print()
print('=== 查找 nameIndex == %d (toDecrypt) 的方法 ===' % target_idx)
found = []
for i in range(113509):
    off = methods_off + i*REC
    nameIdx = struct.unpack_from('<I', md, off)[0]
    if nameIdx == target_idx:
        declType, retType, paramStart, genIdx, mIdx, invIdx, delIdx, rgctxStart, rgctxCnt, token = struct.unpack_from('<10I', md, off+4)
        flags, iflags, slot, paramCnt = struct.unpack_from('<4H', md, off+44)
        found.append((i, declType, token, flags, slot, paramCnt))
        print('  方法 #%d: declType=%d token=0x%X flags=0x%X slot=%d paramCnt=%d' % (i, declType, token, flags, slot, paramCnt))

print()
# 同样找 toEncrypt
for tidx, tname in [(1626972,'toEncrypt'), (1626992,'useMD5')]:
    print('=== nameIndex == %d (%s) ===' % (tidx, tname))
    for i in range(113509):
        off = methods_off + i*REC
        nameIdx = struct.unpack_from('<I', md, off)[0]
        if nameIdx == tidx:
            declType, retType, paramStart, genIdx, mIdx, invIdx, delIdx, rgctxStart, rgctxCnt, token = struct.unpack_from('<10I', md, off+4)
            flags, iflags, slot, paramCnt = struct.unpack_from('<4H', md, off+44)
            print('  方法 #%d: declType=%d token=0x%X flags=0x%X slot=%d paramCnt=%d' % (i, declType, token, flags, slot, paramCnt))
