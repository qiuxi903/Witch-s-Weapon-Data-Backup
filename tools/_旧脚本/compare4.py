import io, sys, struct

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
    # 在 i+14 之后的 8 字节窗口里找合理的长度
    for off in range(i+14, i+22):
        ln = struct.unpack_from('<I', raw, off)[0]
        if 0 < ln < 2000000 and off+4+ln <= len(raw):
            return raw[off+4:off+4+ln], off, ln
    return None, None, None

data = {}
for k, p in regions.items():
    d, off, ln = extract_bytes(p)
    data[k] = d
    if d:
        print('[%s] len@%d = %d, 数据 %d 字节' % (k, off, ln, len(d)))
        print('     前 32: %s' % d[:32].hex())
    else:
        print('[%s] FAIL' % k)

print()
keys = [k for k in data if data[k]]
print('=== 跨区服对比（前 64 字节）===')
for i in range(len(keys)):
    for j in range(i+1, len(keys)):
        a, b = data[keys[i]], data[keys[j]]
        n = min(len(a), len(b), 64)
        same = sum(1 for x in range(n) if a[x] == b[x])
        print('  %s vs %s: 相同 %d/%d' % (keys[i], keys[j], same, n))
        print('     %s: %s' % (keys[i], a[:n].hex()))
        print('     %s: %s' % (keys[j], b[:n].hex()))
        print('     XOR: %s' % bytes(x^y for x,y in zip(a[:n],b[:n])).hex())
        print()
