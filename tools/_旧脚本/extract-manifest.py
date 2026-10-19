# 解压 UnityFS (LZ4HC) 并提取 MonoBehaviour 的 bytes 字段
import io, os, sys, struct, re, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

def read_cstr(b, o):
    e = b.find(b'\x00', o)
    return b[o:e].decode('utf-8', 'replace'), e + 1

def align(o, n=4):
    r = o % n
    return o if r == 0 else o + (n - r)

# --- 纯 Python LZ4 块解压 ---
def lz4_decompress(src, dst_size):
    dst = bytearray()
    i = 0
    n = len(src)
    while i < n:
        token = src[i]; i += 1
        lit = token >> 4
        if lit == 15:
            while True:
                b = src[i]; i += 1
                lit += b
                if b != 255: break
        dst += src[i:i+lit]; i += lit
        if i >= n: break
        offset = src[i] | (src[i+1] << 8); i += 2
        ml = token & 0x0F
        if ml == 15:
            while True:
                b = src[i]; i += 1
                ml += b
                if b != 255: break
        ml += 4
        start = len(dst) - offset
        for k in range(ml):
            dst.append(dst[start + k])
    return bytes(dst)

def extract(path, label):
    print('=' * 72)
    print(label)
    print('=' * 72)
    with open(path, 'rb') as f:
        raw = f.read()
    o = 0
    sig, o = read_cstr(raw, o)
    ver = struct.unpack_from('>I', raw, o)[0]; o += 4
    unity, o = read_cstr(raw, o)
    uver, o = read_cstr(raw, o)
    size = struct.unpack_from('>q', raw, o)[0]; o += 8
    cib = struct.unpack_from('>I', raw, o)[0]; o += 4
    uib = struct.unpack_from('>I', raw, o)[0]; o += 4
    flags = struct.unpack_from('>I', raw, o)[0]; o += 4
    # UnityFS v6: 块信息紧跟在 flags 之后，无对齐
    # 块信息
    bi = raw[o:o+cib]
    bo = 0
    nblocks = struct.unpack_from('>I', bi, bo)[0]; bo += 4
    blocks = []
    for _ in range(nblocks):
        u = struct.unpack_from('>I', bi, bo)[0]; bo += 4
        c = struct.unpack_from('>I', bi, bo)[0]; bo += 4
        fl = struct.unpack_from('>H', bi, bo)[0]; bo += 2
        blocks.append((u, c, fl))
    print('  块数: %d' % nblocks)
    data_off = o + cib
    out = bytearray()
    for (u, c, fl) in blocks:
        chunk = raw[data_off:data_off+c]
        data_off += c
        comp = fl & 0x3F
        if comp == 0:
            out += chunk
        elif comp in (2, 3):
            out += lz4_decompress(chunk, u)
        else:
            print('  !! 未知压缩 %d' % comp)
            return None
    print('  解压后: %d 字节' % len(out))
    return bytes(out)

for name in ['preserved_stage_manifest.ab', 'community_notice_image.ab']:
    p = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config' + '\\' + name
    if not os.path.exists(p):
        continue
    d = extract(p, name)
    if d is None:
        continue
    # 找可读字符串
    strs = re.findall(rb'[\x20-\x7e]{4,}', d)
    print('  可读字符串 %d 条, 前 40:' % len(strs))
    for s in strs[:40]:
        print('    ' + s.decode('ascii', 'replace')[:110])
    # 找 UTF-8 中文
    try:
        txt = d.decode('utf-8', 'ignore')
        cjk = re.findall(r'[\u4e00-\u9fff]{2,}', txt)
        print('  中文串 %d 条, 前 30:' % len(cjk))
        for s in cjk[:30]:
            print('    ' + s[:80])
    except Exception as e:
        print('  中文提取失败: %s' % e)
    print()
