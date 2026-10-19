import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

hdr = struct.unpack_from('<32I', md, 0)
methods_off = hdr[12]
methods_count = hdr[13]
str_off = hdr[6]
str_count = hdr[7]

# Il2CppMethodDefinition 大小 = 56 字节 (v24)
REC = 56
n_methods = methods_count // REC
print('方法数: %d (记录大小 %d)' % (n_methods, REC))
print()

def get_str(idx):
    """从 string 区读取以 null 结尾的字符串"""
    pos = str_off + idx
    end = md.find(b'\x00', pos)
    return md[pos:end].decode('utf-8', errors='replace')

# 先验证：读第一个方法
print('=== 前 5 个方法 ===')
for i in range(5):
    off = methods_off + i*REC
    nameIdx, declType, retType, paramStart, genIdx, mIdx, invIdx, delIdx, rgctxStart, rgctxCnt, token, flags, iflags, slot, paramCnt = struct.unpack_from('<11IHHHH', md, off)
    print('  [%d] name=%r declType=%d token=0x%X flags=0x%X slot=%d paramCnt=%d' % (
        i, get_str(nameIdx), declType, token, flags, slot, paramCnt))

print()
print('=== 搜索 EncryptTools 类型名 ===')
# 找包含 EncryptTools 的字符串
for m in re.finditer(rb'EncryptTools', md):
    pos = m.start()
    # 往前找字符串起点
    start = md.rfind(b'\x00', max(0,pos-200), pos) + 1
    end = md.find(b'\x00', pos)
    s = md[start:end].decode('utf-8', errors='replace')
    print('  @%d  完整串: %r  (string idx = %d)' % (pos, s, start - str_off))

print()
print('=== 搜索 toDecrypt / toEncrypt 方法名 ===')
for kw in [b'toDecrypt', b'toEncrypt', b'useMD5']:
    for m in re.finditer(re.escape(kw), md):
        pos = m.start()
        start = md.rfind(b'\x00', max(0,pos-200), pos) + 1
        end = md.find(b'\x00', pos)
        s = md[start:end].decode('utf-8', errors='replace')
        print('  %-12s @%d 完整串: %r  (string idx = %d)' % (kw.decode(), pos, s, start - str_off))
