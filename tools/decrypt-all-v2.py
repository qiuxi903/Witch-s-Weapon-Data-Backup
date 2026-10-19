# 《魔女兵器》全量剧情解密 —— 算法：XOR 0xFF
import io, os, sys, struct, re, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

exec(open(r'G:\project\其他\game\tools\parse-v3.py', encoding='utf-8').read().split("if __name__")[0])

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
        print('[跳过] %s' % label); continue
    files = []
    for dp, dn, fn in os.walk(srcdir):
        for f in fn:
            if re.match(r'sentence_\d+\.ab$', f):
                files.append(os.path.join(dp, f))
    files.sort()
    if not files:
        print('[跳过] %s (无文件)' % label); continue
    outdir = os.path.join(OUTROOT, label)
    os.makedirs(outdir, exist_ok=True)
    ok = 0; empty = 0; total_chars = 0
    manifest = []
    for p in files:
        base = os.path.splitext(os.path.basename(p))[0]
        try:
            d = decompress_bundle(p)
            name, payload = extract_payload(d)
            if payload is None:
                empty += 1
                continue
            txt = bytes(b ^ 0xFF for b in payload).decode('utf-8', 'replace')
            with io.open(os.path.join(outdir, base + '.txt'), 'w', encoding='utf-8') as f:
                f.write(txt)
            ok += 1; total_chars += len(txt)
            manifest.append({'file': base, 'chars': len(txt)})
        except Exception as e:
            empty += 1
    summary.append((label, len(files), ok, empty, total_chars))
    with io.open(os.path.join(outdir, '_manifest.json'), 'w', encoding='utf-8') as f:
        json.dump(manifest, f, ensure_ascii=False, indent=1)
    print('[完成] %-14s 共 %3d  解密 %3d  空 %2d  %9d 字符' % (label, len(files), ok, empty, total_chars))

print()
print('=== 汇总 ===')
tot = 0
for label, n, ok, empty, chars in summary:
    print('  %-14s %3d/%3d   %9d 字符' % (label, ok, n, chars))
    tot += chars
print('  合计 %d 字符' % tot)
