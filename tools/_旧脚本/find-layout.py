# 对比成功/失败文件的 BytesAsset 布局，找出真正的长度字段位置
import io, os, sys, struct, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

def read_cstr(b, o):
    e = b.find(b'\x00', o)
    return b[o:e].decode('utf-8','replace'), e+1

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

def decompress_bundle(path):
    raw = open(path,'rb').read()
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
    bi = lz4_decompress(raw[hdr_end:hdr_end+cib])
    nb = struct.unpack_from('>I', bi, 16)[0]
    blocks = []
    for i in range(nb):
        u,c,fl = struct.unpack_from('>IIH', bi, 20+i*10)
        blocks.append((u,c,fl))
    data_off = hdr_end + cib
    out = bytearray()
    for (u,c,fl) in blocks:
        chunk = raw[data_off:data_off+c]; data_off += c
        comp = fl & 0x3F
        out += chunk if comp == 0 else lz4_decompress(chunk)
    return bytes(out)

d_lesson = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson'

for fn in ['sentence_00001.ab', 'sentence_00002.ab']:
    p = os.path.join(d_lesson, fn)
    d = decompress_bundle(p)
    nm = re.search(rb'sentence_\d+', d)
    end = d.find(b'\x00', nm.end())
    print('=' * 72)
    print('%s   解压 %d 字节, 资源名结束于 %d' % (fn, len(d), end))
    print('=' * 72)
    # 打印 name_end 前后
    s = max(0, end - 16)
    print('  name_end-16 .. +80:')
    for i in range(s, min(end + 80, len(d)), 16):
        chunk = d[i:i+16]
        print('    %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in chunk),
              ''.join(chr(b) if 32<=b<127 else '.' for b in chunk)))
    # 在 name 之前找长度字段（Unity 的 byte[] 在 m_Name 之前还是之后？）
    print()
    print('  name 之前 64 字节:')
    s2 = max(0, nm.start() - 64)
    for i in range(s2, nm.start(), 16):
        chunk = d[i:i+16]
        print('    %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in chunk),
              ''.join(chr(b) if 32<=b<127 else '.' for b in chunk)))
    print()
