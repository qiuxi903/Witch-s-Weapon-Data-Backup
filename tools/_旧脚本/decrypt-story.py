# 《魔女兵器》剧情文本解密器 —— 算法：每字节取反 (XOR 0xFF)
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
    """返回 (资源名, 密文字节)"""
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

def decrypt(payload):
    """核心：每字节取反"""
    return bytes(b ^ 0xFF for b in payload)

# ---- 测试 ----
src = r'G:\project\其他\game\提取资源\怀旧服v128_导出\新剧情\sentence_30319.decompressed'
d = open(src, 'rb').read()
name, payload = get_bytes_asset(d)
print('资源: %s, 密文 %d 字节' % (name, len(payload) if payload else 0))
pt = decrypt(payload)
txt = pt.decode('utf-8', 'replace')
print()
print('=== 解密结果（前 800 字符）===')
print(txt[:800])
print()
print('=== 总长度: %d 字符 ===' % len(txt))
