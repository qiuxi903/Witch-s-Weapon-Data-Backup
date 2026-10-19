import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
start = 0x6AF + 4
ln = struct.unpack_from('<I', raw, 0x6AF)[0]
data = raw[start:start+ln]

# 尝试 LZ4 解压（多种偏移）
def lz4_decompress(src, max_out=4*1024*1024):
    out = bytearray()
    i = 0
    n = len(src)
    while i < n:
        token = src[i]; i += 1
        lit = token >> 4
        if lit == 15:
            while True:
                if i >= n: return None
                b = src[i]; i += 1
                lit += b
                if b != 255: break
        if i + lit > n: return None
        out += src[i:i+lit]; i += lit
        if i >= n: break
        if i + 2 > n: return None
        offset = src[i] | (src[i+1] << 8); i += 2
        if offset == 0 or offset > len(out): return None
        mlen = token & 0x0F
        if mlen == 15:
            while True:
                if i >= n: return None
                b = src[i]; i += 1
                mlen += b
                if b != 255: break
        mlen += 4
        s = len(out) - offset
        for j in range(mlen):
            out.append(out[s + j])
        if len(out) > max_out: return None
    return bytes(out)

print('=== 尝试 LZ4（各偏移）===')
for off in range(0, 8):
    try:
        out = lz4_decompress(data[off:])
        if out and len(out) > 100:
            print('  offset=%d OK! %d -> %d' % (off, len(data)-off, len(out)))
            print('     ', repr(out[:200]))
    except Exception as e:
        pass

# 尝试 LZO
print()
print('=== 尝试 zlib/lzma 各偏移 ===')
import zlib, lzma, bz2
for off in range(0, 16):
    for name, fn in [('zlib', lambda d: zlib.decompress(d)),
                     ('deflate', lambda d: zlib.decompress(d, -15)),
                     ('gzip', lambda d: zlib.decompress(d, 31)),
                     ('lzma', lambda d: lzma.decompress(d)),
                     ('bz2', lambda d: bz2.decompress(d))]:
        try:
            out = fn(data[off:])
            print('  offset=%d %-9s OK! -> %d bytes' % (off, name, len(out)))
            print('     ', repr(out[:200]))
        except Exception:
            pass

# 检查是否 Unity 的 LZ4 块（带压缩/解压大小头）
print()
print('=== Unity LZ4 块格式检查 ===')
for off in range(0, 16):
    if off + 8 <= len(data):
        a = struct.unpack_from('<I', data, off)[0]
        b = struct.unpack_from('<I', data, off+4)[0]
        if 0 < a < 10*1024*1024 and 0 < b < 10*1024*1024:
            print('  offset=%d: compressedSize=%d uncompressedSize=%d' % (off, a, b))
