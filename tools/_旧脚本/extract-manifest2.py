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

hdr_end = o
print('header 结束 offset = %d' % hdr_end)
print('cib=%d uib=%d' % (cib, uib))
print()

# UnityFS 的块信息是 LZ4 压缩的！先解压 blockInfo
def lz4_decompress(src, dst_size=None):
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

bi_raw = raw[hdr_end:hdr_end+cib]
print('=== blockInfo 原始前 32 字节 ===')
print('  ' + ' '.join('%02X'%b for b in bi_raw[:32]))
print()
try:
    bi = lz4_decompress(bi_raw)
    print('blockInfo 解压后 %d 字节 (期望 %d)' % (len(bi), uib))
    print('  前 48 字节: ' + ' '.join('%02X'%b for b in bi[:48]))
    nb = struct.unpack_from('>I', bi, 0)[0]
    print('  块数 = %d' % nb)
    bo = 4
    for i in range(nb):
        u, c, fl = struct.unpack_from('>IIH', bi, bo); bo += 10
        print('    块%d: 未压缩=%d 压缩=%d flags=0x%X' % (i, u, c, fl))
    data_off = hdr_end + cib
    print('  数据起始 offset = %d' % data_off)
    # 解压数据块
    out = bytearray()
    for i in range(nb):
        u, c, fl = struct.unpack_from('>IIH', bi, 4 + i*10)
        chunk = raw[data_off:data_off+c]; data_off += c
        comp = fl & 0x3F
        if comp == 0:
            out += chunk
        else:
            out += lz4_decompress(chunk)
    print('  解压后总数据 = %d 字节' % len(out))
    # 保存
    outp = r'G:\project\其他\game\提取资源\怀旧服v128_导出\preserved_stage_manifest.raw'
    import os
    os.makedirs(os.path.dirname(outp), exist_ok=True)
    open(outp, 'wb').write(bytes(out))
    print('  已保存: %s' % outp)
    # 找字符串
    import re
    strs = re.findall(rb'[\x20-\x7e]{5,}', out)
    print()
    print('  可读字符串 %d 条:' % len(strs))
    for s in strs[:60]:
        print('    ' + s.decode('ascii','replace')[:110])
except Exception as e:
    import traceback; traceback.print_exc()
