# 用统一解析器提取 sentence_*.ab 中的 BytesAsset 原始字节
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
        u, c, fl = struct.unpack_from('>IIH', bi, 20 + i*10)
        blocks.append((u, c, fl))
    data_off = hdr_end + cib
    out = bytearray()
    for (u, c, fl) in blocks:
        chunk = raw[data_off:data_off+c]; data_off += c
        comp = fl & 0x3F
        out += chunk if comp == 0 else lz4_decompress(chunk)
    return bytes(out)

def find_bytes_asset(d):
    """在解压后的 bundle 数据里定位 BytesAsset 的 bytes 数组"""
    # 找 m_Name 字符串
    m = re.search(rb'm_Name', d)
    # 找 "sentence_" 名字
    nm = re.search(rb'sentence_\d+', d)
    name = nm.group(0).decode() if nm else '?'
    # bytes 数组：在 MonoBehaviour ���，格式通常是
    #   int32 count, 然后 count 个 byte（或每个 byte 后跟 padding）
    # 先找 isEncrypt 标志（bool）
    res = {'name': name}
    # 定位 name 字符串结束后的位置
    if nm:
        end = d.find(b'\x00', nm.end())
        res['name_end'] = end
        # 打印 name 后 64 字节
        res['after_name'] = d[end:end+64].hex()
    return res

base = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config\lesson'
outdir = r'G:\project\其他\game\提取资源\怀旧服v128_导出\新剧情'
os.makedirs(outdir, exist_ok=True)

for n in ['sentence_30319', 'sentence_303190', 'sentence_30320', 'sentence_30321']:
    p = os.path.join(base, n + '.ab')
    print('=' * 72)
    print(n)
    print('=' * 72)
    d = decompress_bundle(p)
    print('  解压后 %d 字节' % len(d))
    info = find_bytes_asset(d)
    print('  资源名: %s' % info.get('name'))
    print('  name 后 64 字节: %s' % info.get('after_name'))
    # 保存解压数据供后续分析
    rawp = os.path.join(outdir, n + '.decompressed')
    open(rawp, 'wb').write(d)
    print('  已保存 %s' % rawp)
    print()
