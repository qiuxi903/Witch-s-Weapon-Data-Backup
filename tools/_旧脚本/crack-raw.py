import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()

# bytes 数据从 0x6AF+4 = 1715 开始，长度 0x1512 = 5394
start = 0x6AF + 4
ln = struct.unpack_from('<I', raw, 0x6AF)[0]
print('bytes 长度字段 = %d (0x%X)' % (ln, ln))
data = raw[start:start+ln]
print('实际取到 %d 字节' % len(data))
print('前 48 字节:', data[:48].hex())
print()

# 关键观察：F6 和 DF 像分隔符
print('=== 字节频率 ===')
c = collections.Counter(data)
for k, v in c.most_common(25):
    print('  0x%02X (%3d) x%-5d  %s' % (k, k, v, chr(k) if 32 <= k < 127 else '.'))

print()
print('=== 尝试：每个字节 XOR 0x80（翻转高位）===')
x = bytes(b ^ 0x80 for b in data[:120])
print('  ', x.hex())
print('  ', repr(x.decode('utf-8', errors='replace')))

print()
print('=== 尝试：UTF-8 中文，但每字节 XOR 0x80 ===')
# 中文 UTF-8: E4-E9 xx xx
# 密文: 64-69 xx xx (XOR 0x80) 或 64-69 高位
# 观察密文里 0x64-0x69 出现吗？
for lo, hi, name in [(0x64,0x69,'E4-E9 XOR 0x80'), (0xE4,0xE9,'E4-E9 原样')]:
    cnt = sum(1 for b in data if lo <= b <= hi)
    print('  0x%02X-0x%02X (%s): %d (%.1f%%)' % (lo, hi, name, cnt, 100*cnt/len(data)))

print()
print('=== 尝试各种单字节 XOR 后看 UTF-8 中文比例 ===')
best = []
for k in range(256):
    dec = bytes(b ^ k for b in data)
    try:
        s = dec.decode('utf-8')
        # 统计中文字符
        cn = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
        if cn > 50:
            best.append((cn, k, s[:80]))
    except UnicodeDecodeError:
        pass
best.sort(reverse=True)
print('  找到 %d 个候选:' % len(best))
for cn, k, s in best[:5]:
    print('    XOR 0x%02X: %d 个汉字  %r' % (k, cn, s))
