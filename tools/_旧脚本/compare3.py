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
    if i < 0:
        print('  未找到 sentence_00001')
        return None
    # m_Name 数据从 i 开始，长度 14
    # 之后对齐到 4 字节边界
    name_end = i + 14
    aligned = (name_end + 3) & ~3
    ln = struct.unpack_from('<I', raw, aligned)[0]
    print('  name@%d name_end=%d aligned=%d len=%d' % (i, name_end, aligned, ln))
    if not (0 < ln < 2000000):
        print('  长度不合理')
        return None
    return raw[aligned+4:aligned+4+ln]

data = {}
for k, p in regions.items():
    print('[%s]' % k)
    d = extract_bytes(p)
    data[k] = d
    if d:
        print('   -> %d bytes, 前 32: %s' % (len(d), d[:32].hex()))

print()
keys = [k for k in data if data[k]]
if len(keys) >= 2:
    print('=== 跨区服对比 ===')
    for i in range(len(keys)):
        for j in range(i+1, len(keys)):
            a, b = data[keys[i]], data[keys[j]]
            n = min(len(a), len(b), 64)
            same = sum(1 for x in range(n) if a[x] == b[x])
            print('  %s vs %s: 相同 %d/%d' % (keys[i], keys[j], same, n))
            if same < n:
                print('     %s: %s' % (keys[i], a[:n].hex()))
                print('     %s: %s' % (keys[j], b[:n].hex()))
                print('     XOR: %s' % bytes(x^y for x,y in zip(a[:n],b[:n])).hex())
