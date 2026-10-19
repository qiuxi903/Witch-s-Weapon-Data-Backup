import io, sys, re, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# SymbolMap 结构分析：从之前看，记录像是 [addr(8)][size(4)][pad(4)]
# 但解析出的地址很奇怪。重新分析。
p = r'G:\project\其他\game\提取资源\国服DLL\SymbolMap-ARM64'
with open(p, 'rb') as f:
    sm = f.read()

print('大小:', len(sm))
print()
print('=== 前 128 字节逐字节 ===')
for i in range(0, 128, 8):
    chunk = sm[i:i+8]
    v8 = struct.unpack('<Q', chunk)[0]
    v4a = struct.unpack('<I', chunk[:4])[0]
    v4b = struct.unpack('<I', chunk[4:])[0]
    print('  %04X: %s  u64=0x%016X  u32=(0x%08X, 0x%08X)' % (i, chunk.hex(), v8, v4a, v4b))

print()
# 观察：0x43a40300 00808a19 01000000 40000000
# 小端 u32: 0x0003a443, 0x198a8000, 0x00000001, 0x00000040
# 看起来像：value(4) + addr(4) + ?(4) + ?(4)
print('=== 按 16 字节，解释为 (u32 a, u32 b, u32 c, u32 d) ===')
for i in range(0, 256, 16):
    a,b,c,d = struct.unpack_from('<IIII', sm, i)
    print('  %04X: %10d(0x%08X)  %10d(0x%08X)  %10d(0x%08X)  %10d(0x%08X)' % (i,a,a,b,b,c,c,d,d))

print()
# 另一种可能：这是 Il2CppCodeRegistration 的映射表
# 尝试按 8 字节：地址 + 长度
print('=== 按 8 字节 (addr, size) 对 ===')
for i in range(0, 128, 16):
    a = struct.unpack_from('<Q', sm, i)[0]
    b = struct.unpack_from('<Q', sm, i+8)[0]
    print('  %04X: 0x%016X  0x%016X' % (i, a, b))
