import io, struct, sys, re, os
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
hdr_end = o

def lz4_decompress(src):
    dst = bytearray(); i = 0; n = len(src)
    while i < n:
        token = src[i]; i += 1
        lit = token >> 4
        if lit == 15:
            while True:
                b = src[i]; i += 1; lit += b
                if b != 255: break
        dst += src[i:i+lit]; i += lit
        if i >= n: break
        offset = src[i] | (src[i+1] << 8); i += 2
        ml = token & 0x0F
        if ml == 15:
            while True:
                b = src[i]; i += 1; ml += b
                if b != 255: break
        ml += 4
        start = len(dst) - offset
        for k in range(ml):
            dst.append(dst[start+k])
    return bytes(dst)

bi = lz4_decompress(raw[hdr_end:hdr_end+cib])
print('blockInfo (%d 字节):' % len(bi))
for i in range(0, len(bi), 16):
    print('  %04X  %s' % (i, ' '.join('%02X'%b for b in bi[i:i+16])))

# 标准 UnityFS 块信息格式：u32 blockCount, 然后每个块 {u32 uncompressed, u32 compressed, u16 flags}
# 但这里前 20 字节是 0，然后 05 00 02 00 ...
# 试：blockCount 在 offset 16?
for off in [0, 4, 8, 12, 16, 20]:
    if off + 4 <= len(bi):
        v = struct.unpack_from('>I', bi, off)[0]
        print('  offset %2d 处 u32 BE = %d' % (off, v))

print()
print('=== 假设 blockCount 在 offset 16 ===')
nb = struct.unpack_from('>I', bi, 16)[0]
print('  块数 = %d' % nb)
bo = 20
blocks = []
for i in range(nb):
    if bo + 10 > len(bi): break
    u, c, fl = struct.unpack_from('>IIH', bi, bo); bo += 10
    blocks.append((u, c, fl))
    print('    块%d: 未压缩=%d 压缩=%d flags=0x%X' % (i, u, c, fl))

if blocks:
    data_off = hdr_end + cib
    out = bytearray()
    for (u, c, fl) in blocks:
        chunk = raw[data_off:data_off+c]; data_off += c
        comp = fl & 0x3F
        out += chunk if comp == 0 else lz4_decompress(chunk)
    print('  解压后 = %d 字节' % len(out))
    outp = r'G:\project\其他\game\提取资源\怀旧服v128_导出\preserved_stage_manifest.raw'
    os.makedirs(os.path.dirname(outp), exist_ok=True)
    open(outp,'wb').write(bytes(out))
    print('  已保存 %s' % outp)
    strs = re.findall(rb'[\x20-\x7e]{5,}', out)
    print('  可读字符串 %d 条:' % len(strs))
    for s in strs[:70]:
        print('    ' + s.decode('ascii','replace')[:110])
