# 提取并解密全部 clientexel 配置表（CSV 格式，XOR 0xFF）
import io, os, sys, struct, re, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')
exec(open(r'G:\project\其他\game\tools\parse-v3.py', encoding='utf-8').read().split("if __name__")[0])

def extract_csv_payload(d):
    """
    定位 BytesAsset 中的 CSV 数据：
    布局: "m_Name" ... 00 | <u32 LE 长度> | <u32 未知> | 密文
    密文取反后以 UTF-8 BOM 开头。
    """
    # 找所有 u32 LE 长度候选，其后 4 字节后紧跟 EF BB BF 的取反 (10 44 40)
    for m in re.finditer(rb'\x10\x44\x40', d):
        # 数据起点 = m.start()
        # 往前找长度字段
        for lp in range(m.start() - 8, m.start()):
            if lp < 0: continue
            cnt = struct.unpack_from('<I', d, lp)[0]
            if not (100 < cnt <= len(d) - m.start()):
                continue
            payload = d[m.start():m.start()+cnt]
            pt = bytes(b ^ 0xFF for b in payload)
            if pt[:3] == b'\xef\xbb\xbf' or pt[:1] == b'#' or b',' in pt[:200]:
                return payload
    return None

SOURCES = [
    ('怀旧服v128', r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config\clientexel'),
    ('国服v2.0.1', r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\clientexel'),
]
OUTROOT = r'G:\project\其他\game\配置表_解密版'

for label, src in SOURCES:
    if not os.path.isdir(src):
        print('[跳过] %s' % label); continue
    outdir = os.path.join(OUTROOT, label)
    os.makedirs(outdir, exist_ok=True)
    files = sorted(f for f in os.listdir(src) if f.endswith('.ab'))
    ok = 0; fail = []
    total = 0
    for f in files:
        try:
            d = decompress_bundle(os.path.join(src, f))
            payload = extract_csv_payload(d)
            if payload is None:
                fail.append(f); continue
            txt = bytes(b ^ 0xFF for b in payload).decode('utf-8', 'replace')
            if txt.startswith('\ufeff'):
                txt = txt[1:]
            io.open(os.path.join(outdir, f[:-3] + '.csv'), 'w', encoding='utf-8').write(txt)
            ok += 1; total += len(txt)
        except Exception as e:
            fail.append(f)
    print('[完成] %-12s %3d/%3d  %9d 字符' % (label, ok, len(files), total))
    if fail:
        print('        失败: %s' % ', '.join(x[:-3] for x in fail[:12]))
