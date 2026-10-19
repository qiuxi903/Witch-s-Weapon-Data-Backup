import io, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# 思路：EncryptTools.Bind 的 token = 0x0600184A
# IL2CPP 的方法指针表按 methodIndex 索引
# 但 methodIndex 是 0xFFFFFFFF（未设置），说明用 token 或 slot
# 
# 换个思路：直接反汇编 .so，找引用 "EncryptTools" 或 "toDecrypt" 的地方
# 但这些字符串在 metadata 里，不在 .so

# 最直接：找 .so 里做 XOR/AES 的小函数
# 先看 .so 的节表

so = r'G:\project\其他\game\提取资源\国服DLL\libil2cpp.so'
with open(so, 'rb') as f:
    data = f.read()

print('=== ELF 头 ===')
print('  magic:', data[:4])
print('  class:', data[4], '(2=64bit)')
print('  endian:', data[5], '(1=LE)')
e_shoff = struct.unpack_from('<Q', data, 0x28)[0]
e_shentsize = struct.unpack_from('<H', data, 0x3A)[0]
e_shnum = struct.unpack_from('<H', data, 0x3C)[0]
e_shstrndx = struct.unpack_from('<H', data, 0x3E)[0]
print('  section header offset:', hex(e_shoff), 'count:', e_shnum, 'entsize:', e_shentsize)

# 读节名
sh_str_off = struct.unpack_from('<Q', data, e_shoff + e_shstrndx*e_shentsize + 0x18)[0]
print()
print('=== 节表 ===')
sections = []
for i in range(e_shnum):
    off = e_shoff + i*e_shentsize
    name_off = struct.unpack_from('<I', data, off)[0]
    sh_type = struct.unpack_from('<I', data, off+4)[0]
    sh_flags = struct.unpack_from('<Q', data, off+8)[0]
    sh_addr = struct.unpack_from('<Q', data, off+0x10)[0]
    sh_offset = struct.unpack_from('<Q', data, off+0x18)[0]
    sh_size = struct.unpack_from('<Q', data, off+0x20)[0]
    end = data.find(b'\x00', sh_str_off + name_off)
    name = data[sh_str_off+name_off:end].decode('ascii', errors='replace')
    sections.append((name, sh_addr, sh_offset, sh_size, sh_flags))
    print('  %-22s addr=0x%08X off=0x%08X size=0x%08X flags=0x%X' % (name, sh_addr, sh_offset, sh_size, sh_flags))
