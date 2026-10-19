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
    ln = struct.unpack_from('<H', raw, i+16)[0]
    data[k] = raw[i+20:i+20+ln]

# 关键观察：CN 里有 "26 00" 分隔符，KR 里更多
# 26 00 = 38 (LE 16-bit)
# 检查是否是 UTF-16LE 的小值
print('=== 把数据当 UTF-16LE 解读，看 0x0026 等分隔符 ===')
a = data['CN']
u = [a[i] | (a[i+1] << 8) for i in range(0, len(a)-1, 2)]
print('  前 40 个 16-bit LE 单元:')
for i in range(0, 40, 8):
    print('    ', ' '.join('0x%04X' % x for x in u[i:i+8]))

print()
print('=== 统计 16-bit LE 单元频率 ===')
c = collections.Counter(u)
print('  最常见:')
for k, v in c.most_common(20):
    print('    0x%04X x%-5d' % (k, v))

print()
print('=== 关键：0x0026 和 0x0029 是否是分隔符 ===')
for sep in [0x0026, 0x0029, 0x0000, 0x03F5, 0x0001]:
    pos = [i for i, x in enumerate(u) if x == sep]
    if pos:
        gaps = [pos[i+1]-pos[i] for i in range(min(20, len(pos)-1))]
        print('  0x%04X: %d 次, 间隔: %s' % (sep, len(pos), gaps[:15]))

print()
print('=== 观察：0x26 0x00 出现的上下文（CN）===')
for i in range(len(a)-1):
    if a[i] == 0x26 and a[i+1] == 0x00:
        lo = max(0, i-8); hi = min(len(a), i+12)
        print('  @%d: %s' % (i, a[lo:hi].hex()))
