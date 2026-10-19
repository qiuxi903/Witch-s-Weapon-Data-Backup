# 解密全部区服的 clientexel 配置表 → 03_配置表/<区服>/*.csv
#
# 来源：<解包>/assets/assetbundle/config/clientexel/*.ab
#   UnityFS 资源包（LZ4 压缩）→ BytesAsset 内的 CSV 密文 → XOR 0xFF 解密
import io, os, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')
R = r'G:\project\其他\game'


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
        dst += src[i:i + lit]; i += lit
        if i >= n: break
        offset = src[i] | (src[i + 1] << 8); i += 2
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
    bi = lz4_decompress(raw[hdr_end:hdr_end + cib])
    nb = struct.unpack_from('>I', bi, 16)[0]
    blocks = []
    for i in range(nb):
        u, c, fl = struct.unpack_from('>IIH', bi, 20 + i * 10)
        blocks.append((u, c, fl))
    data_off = hdr_end + cib
    out = bytearray()
    for (u, c, fl) in blocks:
        chunk = raw[data_off:data_off + c]
        data_off += c
        comp = fl & 0x3F
        out += chunk if comp == 0 else lz4_decompress(chunk)
    return bytes(out)


def extract_csv_payload(d):
    """定位 BytesAsset 中的 CSV 密文：取反后以 UTF-8 BOM 开头。"""
    for m in re.finditer(rb'\x10\x44\x40', d):
        for lp in range(m.start() - 8, m.start()):
            if lp < 0:
                continue
            cnt = struct.unpack_from('<I', d, lp)[0]
            if not (100 < cnt <= len(d) - m.start()):
                continue
            payload = d[m.start():m.start() + cnt]
            pt = bytes(b ^ 0xFF for b in payload)
            if pt[:3] == b'\xef\xbb\xbf' or pt[:1] == b'#' or b',' in pt[:200]:
                return payload
    return None


def decode_csv(pt, cnt):
    """XOR 后的字节 → CSV 文本。

    长度字段有时比实际内容少 1 字节，会把末尾的多字节字符切断，
    因此在 cnt 附近试几个长度，取第一个能完整解码的。
    """
    for extra in range(0, 5):
        end = min(cnt + extra, len(pt))
        try:
            t = pt[:end].decode('utf-8')
        except UnicodeDecodeError:
            continue
        if any((ord(c) < 0x20 and c not in '\r\n\t') or c == '\ufffd' for c in t):
            continue
        return t
    # 兜底：宽松解码，并丢掉末尾的二进制残渣行
    t = pt[:cnt].decode('utf-8', 'replace')
    lines = t.split('\n')
    while lines and '\ufffd' in lines[-1]:
        lines.pop()
    return '\n'.join(lines)


# (输出目录名, 解包目录名)
SOURCES = [
    ('怀旧服v128',  '怀旧服v128_完整解包'),
    ('国服v2.0.1',  '国服v2.0.1_完整解包'),
    ('日服v2.0.0',  '日服v2.0.0_OBB解包'),
    ('港澳台v1.6.0', '港澳台v1.6.0_OBB解包'),
    ('韩服v1.0',    '韩服v1.0_OBB解包'),
]

if __name__ == '__main__':
    for label, unpack in SOURCES:
        src = os.path.join(R, '02_客户端解包', unpack,
                           'assets', 'assetbundle', 'config', 'clientexel')
        if not os.path.isdir(src):
            print('[跳过] %-14s 源目录不存在' % label)
            continue
        outdir = os.path.join(R, '03_配置表', label)
        os.makedirs(outdir, exist_ok=True)
        files = sorted(f for f in os.listdir(src) if f.endswith('.ab'))
        ok = 0
        fail = []
        for f in files:
            try:
                d = decompress_bundle(os.path.join(src, f))
                payload = extract_csv_payload(d)
                if payload is None:
                    fail.append(f[:-3]); continue
                txt = decode_csv(bytes(b ^ 0xFF for b in payload), len(payload))
                if txt.startswith('\ufeff'):
                    txt = txt[1:]
                io.open(os.path.join(outdir, f[:-3] + '.csv'), 'w',
                        encoding='utf-8').write(txt)
                ok += 1
            except Exception:
                fail.append(f[:-3])
        print('[完成] %-14s %3d/%3d 解出' % (label, ok, len(files)))
        if fail:
            print('        非 CSV（二进制配置）: %s' % ', '.join(fail[:14]))
