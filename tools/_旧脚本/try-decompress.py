import io, re, sys, collections, struct, zlib, lzma, bz2

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\导出_剧情文本_国服\assets\_temp_config\config\lesson\sentence_30219.json'
with io.open(p, 'r', encoding='utf-8') as f:
    txt = f.read()
m = re.search(r'"bytes":\s*\[([^\]]+)\]', txt)
nums = [int(x.strip()) for x in m.group(1).split(',')]
data = bytes(nums)

print('原始长度:', len(data))
print()

# 尝试各种标准解压
print('=== 尝试标准解压 ===')
for name, fn in [
    ('zlib', lambda d: zlib.decompress(d)),
    ('gzip', lambda d: zlib.decompress(d, 16+15)),
    ('raw deflate', lambda d: zlib.decompress(d, -15)),
    ('lzma', lambda d: lzma.decompress(d)),
    ('bz2', lambda d: bz2.decompress(d)),
]:
    try:
        out = fn(data)
        print('  %-14s OK! %d -> %d bytes' % (name, len(data), len(out)))
        print('     ', repr(out[:200]))
    except Exception as e:
        print('  %-14s 失败: %s' % (name, str(e)[:60]))

print()
print('=== 尝试各种偏移后再解压（可能有头部）===')
for off in range(0, 16):
    for name, fn in [('zlib', lambda d: zlib.decompress(d)), ('lzma', lambda d: lzma.decompress(d))]:
        try:
            out = fn(data[off:])
            print('  offset=%d %s OK! -> %d bytes' % (off, name, len(out)))
            print('     ', repr(out[:200]))
        except Exception:
            pass

print()
print('=== 检查是否是 LZ4 块 ===')
# LZ4 block: 第一字节高4位是 literal 长度
# 尝试手动 LZ4 解压
def lz4_decompress(src, max_out=10*1024*1024):
    out = bytearray()
    i = 0
    while i < len(src):
        token = src[i]; i += 1
        lit = token >> 4
        if lit == 15:
            while True:
                if i >= len(src): return None
                b = src[i]; i += 1
                lit += b
                if b != 255: break
        if i + lit > len(src): return None
        out += src[i:i+lit]; i += lit
        if i >= len(src): break
        if i + 2 > len(src): return None
        offset = src[i] | (src[i+1] << 8); i += 2
        if offset == 0: return None
        mlen = token & 0x0F
        if mlen == 15:
            while True:
                if i >= len(src): return None
                b = src[i]; i += 1
                mlen += b
                if b != 255: break
        mlen += 4
        start = len(out) - offset
        if start < 0: return None
        for j in range(mlen):
            out.append(out[start + j])
        if len(out) > max_out: return None
    return bytes(out)

try:
    out = lz4_decompress(data)
    if out:
        print('  LZ4 解压成功! %d -> %d bytes' % (len(data), len(out)))
        print('     ', repr(out[:300]))
    else:
        print('  LZ4 解压返回 None')
except Exception as e:
    print('  LZ4 失败:', e)
