import io, sys, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\国服DLL\SymbolMap-ARM64'
with open(p, 'rb') as f:
    sm = f.read()

# 观察 16 字节块：
#  0010: addr=0x01198AC0  size=0x0C   -> 然后 0x01198ACC
#  0020: addr=0x01198D00  size=0x78
#  0030: addr=0x01198DD0  size=0x94
# 模式：每个记录是 12 字节: (addr:u64? no)
# 实际看：
#  0x00: 43 a4 03 00 | 80 8a 19 01 | 00 00 00 00 | 40 00 00 00
# 如果记录是 12 字节: [0x0003a443][0x01198a80][0x00000000] 然后 [0x40000000]...
# 不对。

# 换个思路：这可能是「地址(8) + 大小(4)」的 12 字节记录，但起点有偏移
# 试 offset 4: 
print('=== 尝试 12 字节记录，从 offset 4 开始 ===')
for off in [4]:
    for i in range(6):
        pos = off + i*12
        a = struct.unpack_from('<Q', sm, pos)[0]
        s = struct.unpack_from('<I', sm, pos+8)[0]
        print('  [%d] addr=0x%012X size=0x%X' % (i, a, s))

print()
print('=== 尝试 12 字节记录，从 offset 0 开始 ===')
for i in range(8):
    pos = i*12
    a = struct.unpack_from('<Q', sm, pos)[0]
    s = struct.unpack_from('<I', sm, pos+8)[0]
    print('  [%d] addr=0x%012X size=0x%X' % (i, a, s))

print()
# 关键洞察：观察 16 字节块的中间两个 u32
# 0010: (0x01198AC0, 0x00000000, 0x0000000C, 0x01198ACC)
#        ^addr        ^0           ^size        ^next addr
# 0020: (0x00000000, 0x00000078, 0x01198D00, 0x00000000)
# 所以记录是交错的！每 16 字节含 2 个 (addr,size) 对的一部分
# 实际：这是一串 [addr(4)][0(4)][size(4)][addr(4)] 交错

# 更简单：把整个文件按 u32 读，找 addr 递增序列
vals = struct.unpack_from('<%dI' % (len(sm)//4), sm, 0)
print('=== 前 40 个 u32 ===')
for i in range(40):
    print('  [%2d] 0x%08X (%d)' % (i, vals[i], vals[i]))
