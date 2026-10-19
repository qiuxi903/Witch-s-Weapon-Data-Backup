import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
p = base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
i = raw.find(b'sentence_00001')
ln = struct.unpack_from('<H', raw, i+16)[0]
a = raw[i+20:i+20+ln]

def rol8(b, n): return ((b << n) | (b >> (8-n))) & 0xFF
def ror8(b, n): return ((b >> n) | (b << (8-n))) & 0xFF

print('=== 测试 8-bit 循环移位 ===')
for n in range(1, 8):
    for name, fn in [('rol', rol8), ('ror', ror8)]:
        d = bytes(fn(b, n) for b in a)
        try:
            s = d.decode('utf-8')
            cn = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
            print('  %s%d: UTF-8 可解码, 汉字 %d' % (name, n, cn))
        except UnicodeDecodeError as e:
            # 统计合法前��
            pass

print()
print('=== 测试 8-bit 移位（非循环）===')
for n in range(1, 8):
    d = bytes((b << n) & 0xFF for b in a)
    try:
        s = d.decode('utf-8')
        cn = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
        print('  shl%d: OK, 汉字 %d' % (n, cn))
    except UnicodeDecodeError:
        pass
    d = bytes(b >> n for b in a)
    try:
        s = d.decode('utf-8')
        cn = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
        print('  shr%d: OK, 汉字 %d' % (n, cn))
    except UnicodeDecodeError:
        pass

print()
print('=== 测试 16-bit 循环移位（BE/LE）===')
units_be = [(a[j] << 8) | a[j+1] for j in range(0, len(a)-1, 2)]
for n in range(1, 16):
    d = [((u << n) | (u >> (16-n))) & 0xFFFF for u in units_be]
    cjk = sum(1 for u in d if 0x4E00 <= u <= 0x9FFF)
    r = cjk/len(d)
    if r > 0.7:
        print('  rol16(%d): CJK %.1f%%' % (n, r*100))
    d = [((u >> n) | (u << (16-n))) & 0xFFFF for u in units_be]
    cjk = sum(1 for u in d if 0x4E00 <= u <= 0x9FFF)
    r = cjk/len(d)
    if r > 0.7:
        print('  ror16(%d): CJK %.1f%%' % (n, r*100))

print()
print('=== 关键：测试「高字节与低字节互换 + XOR」===')
# 观察 0x1C7E: 高字节 0x1C, 低字节 0x7E
# 如果明文是 0x4E2D (中), 那么...
# 0x1C ^ k1 = 0x4E -> k1 = 0x52
# 0x7E ^ k2 = 0x2D -> k2 = 0x53
# 试 k1=0x52, k2=0x53
print('  试 高字节^0x52, 低字节^0x53:')
d = bytes(((a[j] ^ 0x52) if j % 2 == 0 else (a[j] ^ 0x53)) for j in range(len(a)))
print('    ', repr(d[:60].decode('utf-8', errors='replace')))

# 更系统：对奇偶位置分别暴力 XOR
print()
print('=== 奇偶位置分别暴力 XOR ===')
best = []
for k1 in range(256):
    for k2 in range(256):
        d = bytes((a[j] ^ (k1 if j % 2 == 0 else k2)) for j in range(min(400, len(a))))
        try:
            s = d.decode('utf-8')
            cn = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
            if cn > 100:
                best.append((cn, k1, k2, s[:60]))
        except UnicodeDecodeError:
            pass
best.sort(reverse=True)
print('  候选数: %d' % len(best))
for cn, k1, k2, s in best[:5]:
    print('    k1=0x%02X k2=0x%02X: %d 汉字  %r' % (k1, k2, cn, s))
