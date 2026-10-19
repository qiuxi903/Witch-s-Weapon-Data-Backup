import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()

start = 0x6AF + 4
ln = struct.unpack_from('<I', raw, 0x6AF)[0]
data = raw[start:start+ln]
print('数据长度:', len(data))

# 关键：找分隔符 26 00 / 29 00 / F5 03
# 这些看起来像 UTF-16LE 的小值
print()
print('=== 假设：UTF-16LE，每字符 2 字节 ===')
units_le = [data[i] | (data[i+1] << 8) for i in range(0, len(data)-1, 2)]
units_be = [(data[i] << 8) | data[i+1] for i in range(0, len(data)-1, 2)]

for name, units in [('LE', units_le), ('BE', units_be)]:
    cjk = sum(1 for u in units if 0x4E00 <= u <= 0x9FFF)
    asc = sum(1 for u in units if 0x20 <= u <= 0x7E)
    print('  %s: CJK=%d (%.1f%%)  ASCII=%d (%.1f%%)  total=%d' % (
        name, cjk, 100*cjk/len(units), asc, 100*asc/len(units), len(units)))

print()
print('=== 尝试 XOR 16-bit 常数 ===')
best = []
for k in range(0x10000):
    # 快速测试：只看前 200 个单元
    cnt = 0
    for u in units_be[:200]:
        v = u ^ k
        if 0x4E00 <= v <= 0x9FFF or 0x3000 <= v <= 0x303F or 0xFF00 <= v <= 0xFFEF:
            cnt += 1
    if cnt > 150:
        best.append((cnt, k))
best.sort(reverse=True)
print('  BE 候选 key: %s' % [(hex(k), c) for c, k in best[:10]])

best = []
for k in range(0x10000):
    cnt = 0
    for u in units_le[:200]:
        v = u ^ k
        if 0x4E00 <= v <= 0x9FFF or 0x3000 <= v <= 0x303F or 0xFF00 <= v <= 0xFFEF:
            cnt += 1
    if cnt > 150:
        best.append((cnt, k))
best.sort(reverse=True)
print('  LE 候选 key: %s' % [(hex(k), c) for c, k in best[:10]])

print()
print('=== 尝试 16-bit 减法 ===')
best = []
for k in range(0x10000):
    cnt = 0
    for u in units_be[:200]:
        v = (u - k) & 0xFFFF
        if 0x4E00 <= v <= 0x9FFF:
            cnt += 1
    if cnt > 150:
        best.append((cnt, k))
best.sort(reverse=True)
print('  BE 减法候选: %s' % [(hex(k), c) for c, k in best[:10]])

print()
print('=== 尝试 16-bit 加法 ===')
best = []
for k in range(0x10000):
    cnt = 0
    for u in units_be[:200]:
        v = (u + k) & 0xFFFF
        if 0x4E00 <= v <= 0x9FFF:
            cnt += 1
    if cnt > 150:
        best.append((cnt, k))
best.sort(reverse=True)
print('  BE 加法候选: %s' % [(hex(k), c) for c, k in best[:10]])
