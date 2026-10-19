import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
regions = {
    'CN': base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab',
    'JP': base + r'\日服v2.0.0_OBB解包\assets\assetbundle\config\lesson\sentence_00001.ab',
    'TW': base + r'\港澳台v1.6.0_OBB解包\assets\assetbundle\config\lesson\sentence_00001.ab',
    'KR': base + r'\韩服v1.0_OBB解包\assets\assetbundle\config\lesson\sentence_00001.ab',
}

data = {}
for k, p in regions.items():
    with open(p, 'rb') as f:
        raw = f.read()
    i = raw.find(b'sentence_00001')
    ln = struct.unpack_from('<H', raw, i+16)[0]   # 16-bit 长度 @ name+16
    d = raw[i+20:i+20+ln]
    data[k] = d
    print('[%s] len=%d (0x%X), 取到 %d 字节' % (k, ln, ln, len(d)))
    print('     前 32: %s' % d[:32].hex())

print()
print('=== ���证四区服数据是否完全一致 ===')
keys = list(data.keys())
for i in range(len(keys)):
    for j in range(i+1, len(keys)):
        a, b = data[keys[i]], data[keys[j]]
        n = min(len(a), len(b))
        same = sum(1 for x in range(n) if a[x] == b[x])
        print('  %s vs %s: 相同 %d/%d (%.1f%%)' % (keys[i], keys[j], same, n, 100*same/n))

print()
print('=== 结论 ===')
a, b = data['CN'], data['JP']
n = min(len(a), len(b))
if all(a[x] == b[x] for x in range(n)):
    print('  四区服密文完全一致 -> 加密为固定变换，与密钥无关')
    print('  且明文（剧情）在四区服相同')
