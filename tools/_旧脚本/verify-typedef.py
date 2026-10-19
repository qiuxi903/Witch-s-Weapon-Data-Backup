import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

hdr = struct.unpack_from('<66I', md, 0)
str_off = hdr[6]

def get_str(idx):
    pos = str_off + idx
    end = md.find(b'\x00', pos)
    return md[pos:end].decode('utf-8', errors='replace')

# EncryptTools nameIndex 在 15672784
# Il2CppTypeDefinition v24 大小是 0x5C=92? 让我验证：
# 找相邻的类型记录。如果 15672784 是某条记录的 nameIndex，
# 那么前一条记录的 nameIndex 应该在 15672784 - 92 或 -88 或 -96
print('=== 验证记录大小：检查附近的对齐 ===')
for rec in [88, 92, 96, 100]:
    off_prev = 15672784 - rec
    v = struct.unpack_from('<I', md, off_prev)[0]
    s = get_str(v) if v < 2000000 else '?'
    print('  rec=%d: 前一条 nameIndex=%d -> %r' % (rec, v, s[:40]))

print()
# 直接看 15672784 附近的数据
print('=== 15672784 附近 (前后 200 字节) ===')
lo = 15672784 - 200
for i in range(lo, lo+400, 4):
    v = struct.unpack_from('<I', md, i)[0]
    mark = ' <== EncryptTools nameIndex' if i == 15672784 else ''
    s = ''
    if v < 2000000:
        try:
            t = get_str(v)
            if t and all(32 <= ord(c) < 127 for c in t) and len(t) >= 3:
                s = repr(t[:40])
        except Exception:
            pass
    print('  %9d  %12d (0x%08X)  %s%s' % (i, v, v, s, mark))
