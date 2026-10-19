# 诊断解密失败的文件
import io, os, sys, struct, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

sys.path.insert(0, r'G:\project\其他\game\tools')

def read_cstr(b, o):
    e = b.find(b'\x00', o)
    return b[o:e].decode('utf-8', 'replace'), e + 1

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
            dst.append(dst[start + k])
    return bytes(dst)

def decompress_bundle(path):
    raw = open(path, 'rb').read()
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
        u, c, fl = struct.unpack_from('>IIH', bi, 20 + i * 10)
        blocks.append((u, c, fl))
    data_off = hdr_end + cib
    out = bytearray()
    for (u, c, fl) in blocks:
        chunk = raw[data_off:data_off + c]; data_off += c
        comp = fl & 0x3F
        out += chunk if comp == 0 else lz4_decompress(chunk)
    return bytes(out)

d_lesson = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson'
files = sorted(f for f in os.listdir(d_lesson) if re.match(r'sentence_\d+\.ab$', f))

# 找成功和失败的样本
ok_samples, fail_samples = [], []
for f in files[:40]:
    p = os.path.join(d_lesson, f)
    try:
        d = decompress_bundle(p)
        nm = re.search(rb'sentence_\d+', d)
        if not nm:
            fail_samples.append((f, 'NO_NAME', len(d)))
            continue
        end = d.find(b'\x00', nm.end())
        o = end + 1
        o = o + ((4 - o % 4) % 4)
        found = None
        for delta in range(0, 24, 4):
            q = o + delta
            if q + 4 > len(d): continue
            cnt = struct.unpack_from('<i', d, q)[0]
            if 100 < cnt < 500000 and q + 4 + cnt <= len(d):
                found = (cnt, q + 4); break
        if found is None:
            fail_samples.append((f, 'NO_LEN', len(d)))
        else:
            cnt, off = found
            payload = d[off:off+cnt]
            pt = bytes(b ^ 0xFF for b in payload)
            try:
                s = pt.decode('utf-8')
                cjk = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
                if cjk > 20:
                    ok_samples.append((f, cnt, cjk))
                else:
                    fail_samples.append((f, 'LOW_CJK', cjk))
            except UnicodeDecodeError:
                fail_samples.append((f, 'UTF8_FAIL', cnt))
    except Exception as e:
        fail_samples.append((f, 'EXC:' + str(e)[:30], 0))

print('=== 成功样本 (%d) ===' % len(ok_samples))
for f, cnt, cjk in ok_samples[:10]:
    print('  %-24s 密文 %7d  CJK %6d' % (f, cnt, cjk))
print()
print('=== 失败样本 (%d) ===' % len(fail_samples))
for f, why, extra in fail_samples[:25]:
    print('  %-24s %-12s %s' % (f, why, extra))
