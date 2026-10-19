import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
regions = {
    'CN': base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab',
    'JP': base + r'\日服v2.0.0_OBB解包\assets\assetbundle\config\lesson\sentence_00001.ab',
    'TW': base + r'\港澳台v1.6.0_OBB解包\assets\assetbundle\config\lesson\sentence_00001.ab',
    'KR': base + r'\韩服v1.0_OBB解包\assets\assetbundle\config\lesson\sentence_00001.ab',
}

def extract_bytes(path):
    with open(path, 'rb') as f:
        raw = f.read()
    i = raw.find(b'sentence_00001')
    if i < 0: return None
    after = i + len(b'sentence_00001')
    pad = (4 - (after % 4)) % 4
    after += pad
    ln = struct.unpack_from('<I', raw, after)[0]
    if not (0 < ln < 1000000): return None
    return raw[after+4:after+4+ln]

data = {}
for k, p in regions.items():
    d = extract_bytes(p)
    data[k] = d
    print('%s: %s bytes' % (k, len(d) if d else 'FAIL'))
    if d:
        print('   前 32:', d[:32].hex())

print()
print('=== 对比 CN vs JP 头部 ===')
if data['CN'] and data['JP']:
    a, b = data['CN'], data['JP']
    n = min(len(a), len(b), 64)
    print('  CN:', a[:n].hex())
    print('  JP:', b[:n].hex())
    same = sum(1 for i in range(n) if a[i] == b[i])
    print('  相同字节: %d / %d' % (same, n))
    # XOR 差异
    diff = bytes(x ^ y for x, y in zip(a[:n], b[:n]))
    print('  XOR 差异:', diff.hex())

print()
print('=== 全局对比 ===')
keys = [k for k in data if data[k]]
for i in range(len(keys)):
    for j in range(i+1, len(keys)):
        a, b = data[keys[i]], data[keys[j]]
        n = min(len(a), len(b))
        same = sum(1 for x in range(n) if a[x] == b[x])
        print('  %s vs %s: 相同 %d/%d (%.1f%%)' % (keys[i], keys[j], same, n, 100*same/n))
