import io, sys, struct

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
    ln = struct.unpack_from('<H', raw, i+16)[0]
    data[k] = raw[i+20:i+20+ln]

a = data['CN']
print('=== CN 前 128 字节 ===')
for i in range(0, 128, 16):
    print('  %3d  %s' % (i, a[i:i+16].hex()))

print()
print('=== 找 CN 与 JP 第一个不同的位置 ===')
b = data['JP']
for i in range(min(len(a), len(b))):
    if a[i] != b[i]:
        print('  首个差异 @%d: CN=0x%02X JP=0x%02X' % (i, a[i], b[i]))
        break
else:
    print('  前 %d 字节相同' % min(len(a), len(b)))

print()
print('=== 找 CN 与 TW 第一个不同的位置 ===')
c = data['TW']
for i in range(min(len(a), len(c))):
    if a[i] != c[i]:
        print('  首个差异 @%d: CN=0x%02X TW=0x%02X' % (i, a[i], c[i]))
        break

print()
print('=== 找 CN 与 KR 第一个不同的位置 ===')
d = data['KR']
for i in range(min(len(a), len(d))):
    if a[i] != d[i]:
        print('  首个差异 @%d: CN=0x%02X KR=0x%02X' % (i, a[i], d[i]))
        break

print()
print('=== 对比前 64 字节逐字节 ===')
print('  idx  CN   JP   TW   KR')
for i in range(64):
    vals = [data[k][i] if i < len(data[k]) else None for k in ['CN','JP','TW','KR']]
    mark = '' if len(set(v for v in vals if v is not None)) == 1 else '  <-- 不同'
    print('  %3d  %s%s' % (i, '  '.join('%02X' % v if v is not None else '--' for v in vals), mark))
