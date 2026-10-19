import io, struct, sys
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config\preserved_stage_manifest.ab'
raw = open(p, 'rb').read()

def read_cstr(b, o):
    e = b.find(b'\x00', o)
    return b[o:e].decode('utf-8','replace'), e+1

o = 0
sig, o = read_cstr(raw, o)
ver = struct.unpack_from('>I', raw, o)[0]; o += 4
unity, o = read_cstr(raw, o)
uver, o = read_cstr(raw, o)
size = struct.unpack_from('>q', raw, o)[0]; o += 8
cib = struct.unpack_from('>I', raw, o)[0]; o += 4
uib = struct.unpack_from('>I', raw, o)[0]; o += 4
flags = struct.unpack_from('>I', raw, o)[0]; o += 4

print('sig=%s ver=%d unity=%s uver=%s' % (sig, ver, unity, uver))
print('size=%d cib=%d uib=%d flags=0x%X' % (size, cib, uib, flags))
print('header 结束于 offset %d' % o)
print()
print('=== 从 header 结束处的原始字节 ===')
for i in range(o, min(o+64, len(raw)), 16):
    chunk = raw[i:i+16]
    print('  %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in chunk),
          ''.join(chr(b) if 32<=b<127 else '.' for b in chunk)))
print()
# 试几种对齐
for a in [0, 4, 8, 16]:
    off = o + ((a - o % a) % a)
    if off + 8 <= len(raw):
        n = struct.unpack_from('>I', raw, off)[0]
        print('  对齐到 %2d -> offset %d, 首 4 字节(u32 BE)=%d' % (a, off, n))
