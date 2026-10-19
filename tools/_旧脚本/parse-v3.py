# 最终版解析器：长度在 name_end+2 (u32 LE)，数据在 name_end+9
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
    在解压数据中定位 BytesAsset 的 bytes 数组。
    布局: "sentence_XXXXX" 00 00 <u32 LE 长度> <u32 未知> <密文>
    取最后一次出现的资源名（m_Name 在 MonoBehaciour 末尾）。
    """
    occ = [m for m in re.finditer(rb'sentence_\d+', d)]
    if not occ:
        return None, None
    for m in reversed(occ):
        name = m.group(0).decode()
        end = d.find(b'\x00', m.end())
        # 长度字段
        for lp in range(end + 1, end + 8):
            if lp + 4 > len(d): break
            cnt = struct.unpack_from('<I', d, lp)[0]
            if not (4 < cnt <= len(d)):
                continue
            # 数据起点
            for dp in range(lp + 4, lp + 12):
                if dp + cnt > len(d): continue
                payload = d[dp:dp+cnt]
                pt = bytes(b ^ 0xFF for b in payload)
                try:
                    s = pt.decode('utf-8')
                except UnicodeDecodeError:
                    continue
                cjk = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
                # 也接受多语言表（含制表符分隔）或纯 ASCII 短文本
                if cjk > 5 or ('\t' in s and len(s) > 100):
                    return name, payload
                # 短文本 / 纯英文：要求全部可打印
                if len(s) >= 4 and all(ch.isprintable() or ch in '\r\n\t' for ch in s):
                    return name, payload
    return None, None

if __name__ == '__main__':
    d_lesson = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson'
    files = sorted(f for f in os.listdir(d_lesson) if re.match(r'sentence_\d+\.ab$', f))
    ok = 0; fail = []
    for f in files:
        d = decompress_bundle(os.path.join(d_lesson, f))
        name, payload = extract_payload(d)
        if payload is None: fail.append(f)
        else: ok += 1
    print('成功 %d / %d' % (ok, len(files)))
    if fail:
        print('失败 %d: %s' % (len(fail), ', '.join(fail[:15])))
