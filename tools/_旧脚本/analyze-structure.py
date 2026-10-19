import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()

start = 0x6AF + 4
ln = struct.unpack_from('<I', raw, 0x6AF)[0]
data = raw[start:start+ln]

print('=== 观察：数据里 0x00 很多，且小值频繁 ===')
print('=== 这像是「长度前缀的字符串表」或「二进制序列化」 ===')
print()

# 打印前 200 字节，标出可打印字符
print('=== 前 200 字节（标注）===')
for i in range(0, min(200, len(data)), 16):
    chunk = data[i:i+16]
    hexs = ' '.join('%02X' % b for b in chunk)
    asc = ''.join(chr(b) if 32 <= b < 127 else '.' for b in chunk)
    print('  %04X  %-47s  %s' % (i, hexs, asc))

print()
# 关键：找 0x00 的位置，看是否是字符串终止符
zeros = [i for i, b in enumerate(data) if b == 0]
print('0x00 位置（前 40）:', zeros[:40])
print('0x00 间隔（前 30）:', [zeros[i+1]-zeros[i] for i in range(min(30, len(zeros)-1))])

print()
# 假设：这是 [长度][UTF-8 字符串] 的序列
print('=== 尝试解析为 长度前缀字符串 ===')
pos = 0
strings = []
while pos < len(data) and len(strings) < 20:
    # 试 1 字节长度
    l = data[pos]
    if 0 < l < 200 and pos+1+l <= len(data):
        s = data[pos+1:pos+1+l]
        try:
            t = s.decode('utf-8')
            if any('\u4e00' <= ch <= '\u9fff' for ch in t):
                strings.append((pos, l, t))
                print('  @%d len=%d: %r' % (pos, l, t[:50]))
                pos += 1 + l
                continue
        except Exception:
            pass
    pos += 1
print('  找到 %d 个可能的字符串' % len(strings))
