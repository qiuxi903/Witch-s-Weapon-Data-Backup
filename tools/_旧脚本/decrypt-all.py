# 批量解密全部 sentence_*.ab —— 算法：XOR 0xFF
import io, os, sys, struct, re, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

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

def get_bytes_asset(d):
    nm = re.search(rb'sentence_\d+', d)
    if not nm:
        return None, None
    name = nm.group(0).decode()
    end = d.find(b'\x00', nm.end())
    o = end + 1
    o = o + ((4 - o % 4) % 4)
    for delta in range(0, 24, 4):
        p = o + delta
        if p + 4 > len(d):
            continue
        cnt = struct.unpack_from('<i', d, p)[0]
        if 100 < cnt < 500000 and p + 4 + cnt <= len(d):
            return name, d[p + 4:p + 4 + cnt]
    return name, None

def decrypt_file(path):
    d = decompress_bundle(path)
    name, payload = get_bytes_asset(d)
    if payload is None:
        return name, None
    return name, bytes(b ^ 0xFF for b in payload)

# ============ 批量处理 ============
SOURCES = [
    ('国服v2.0.1',   r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson'),
    ('怀旧服v128',   r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config\lesson'),
    ('日服v2.0.0',   r'G:\project\其他\game\提取资源\日服v2.0.0_OBB解包'),
    ('港澳台v1.6.0', r'G:\project\其他\game\提取资源\港澳台v1.6.0_OBB解包'),
    ('韩服v1.0',     r'G:\project\其他\game\提取资源\韩服v1.0_OBB解包'),
]

OUTROOT = r'G:\project\其他\game\剧情文本_解密版'
os.makedirs(OUTROOT, exist_ok=True)

summary = []
for label, srcdir in SOURCES:
    if not os.path.isdir(srcdir):
        print('[跳过] %s (目录不存在: %s)' % (label, srcdir))
        continue
    # 递归找 sentence_*.ab
    files = []
    for dp, dn, fn in os.walk(srcdir):
        for f in fn:
            if re.match(r'sentence_\d+\.ab$', f):
                files.append(os.path.join(dp, f))
    files.sort()
    if not files:
        print('[跳过] %s (无 sentence 文件)' % label)
        continue
    outdir = os.path.join(OUTROOT, label)
    os.makedirs(outdir, exist_ok=True)
    ok = 0; fail = 0; total_chars = 0
    manifest = []
    for p in files:
        base = os.path.splitext(os.path.basename(p))[0]
        try:
            name, pt = decrypt_file(p)
            if pt is None:
                fail += 1
                continue
            txt = pt.decode('utf-8', 'replace')
            with io.open(os.path.join(outdir, base + '.txt'), 'w', encoding='utf-8') as f:
                f.write(txt)
            ok += 1
            total_chars += len(txt)
            manifest.append({'file': base, 'chars': len(txt), 'bytes': len(pt)})
        except Exception as e:
            fail += 1
    summary.append((label, len(files), ok, fail, total_chars))
    with io.open(os.path.join(outdir, '_manifest.json'), 'w', encoding='utf-8') as f:
        json.dump(manifest, f, ensure_ascii=False, indent=1)
    print('[完成] %-14s 文件 %3d  成功 %3d  失败 %2d  共 %9d 字符' % (label, len(files), ok, fail, total_chars))

print()
print('=== 汇总 ===')
for label, n, ok, fail, chars in summary:
    print('  %-14s %3d/%3d 成功, %9d 字符' % (label, ok, n, chars))
