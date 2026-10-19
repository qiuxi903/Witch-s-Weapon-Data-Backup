# 精确解析 BytesAsset：长度字段在 name_end+2 (uint32 LE)
import io, os, sys, struct, re, json
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

def extract_payload(d):
    """
    返回 (资源名, 密文)。
    布局: ... "sentence_XXXXX" 00 00 <u32 LE 长度> <u32 未知> <密文>
    """
    nm = re.search(rb'sentence_\d+', d)
    if not nm:
        return None, None
    name = nm.group(0).decode()
    end = d.find(b'\x00', nm.end())
    # 长度字段：从 name_end+1 开始，4 字节对齐后尝试
    base = end + 1
    base = base + ((4 - base % 4) % 4)
    # 逐个偏移尝试，取第一个"长度 + 数据"能覆盖到文件末尾附近的
    best = None
    for delta in range(0, 32):
        p = base + delta
        if p + 4 > len(d): break
        cnt = struct.unpack_from('<I', d, p)[0]
        if not (100 < cnt <= len(d) - p - 4):
            continue
        # 数据起点：p+4 后再对齐 4
        for d2 in range(0, 8):
            off = p + 4 + d2
            if off + cnt > len(d): continue
            payload = d[off:off+cnt]
            # 校验：解密后应为合法 UTF-8
            pt = bytes(b ^ 0xFF for b in payload)
            try:
                s = pt.decode('utf-8')
                cjk = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
                if cjk > 5:
                    return name, payload
            except UnicodeDecodeError:
                pass
    return name, None

d_lesson = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson'
files = sorted(f for f in os.listdir(d_lesson) if re.match(r'sentence_\d+\.ab$', f))
ok = 0; fail = []
for f in files:
    d = decompress_bundle(os.path.join(d_lesson, f))
    name, payload = extract_payload(d)
    if payload is None:
        fail.append(f)
    else:
        ok += 1
print('=== 新解析器结果 ===')
print('  成功 %d / %d' % (ok, len(files)))
print('  失败 %d 个: %s' % (len(fail), ', '.join(fail[:12])))
