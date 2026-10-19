import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
p = base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
i = raw.find(b'sentence_00001')
ln = struct.unpack_from('<H', raw, i+16)[0]
a = raw[i+20:i+20+ln]

# 观察：0x1C 后跟 0x7C-0x7F
print('=== 0x1C 后的字节分布 ===')
nxt = collections.Counter()
for j in range(len(a)-1):
    if a[j] == 0x1C:
        nxt[a[j+1]] += 1
print('  ', [(hex(k), v) for k, v in nxt.most_common(15)])

print()
print('=== 0x13 后的字节分布 ===')
nxt = collections.Counter()
for j in range(len(a)-1):
    if a[j] == 0x13:
        nxt[a[j+1]] += 1
print('  ', [(hex(k), v) for k, v in nxt.most_common(15)])

print()
print('=== 0x1A 后的字节分布 ===')
nxt = collections.Counter()
for j in range(len(a)-1):
    if a[j] == 0x1A:
        nxt[a[j+1]] += 1
print('  ', [(hex(k), v) for k, v in nxt.most_common(15)])

print()
print('=== 假设：这是「每字节 XOR 0x6D」或类似，让 0x1C->0x71... ===')
# 观察高频字节：0x1C, 0xDF, 0x7E, 0x1A, 0x7F, 0x13, 0x19, 0x18
# 如果 XOR 后变成常见字符：
# 0x1C ^ k = 'e'(0x65) -> k = 0x79
# 0x7E ^ k = ' '? 
print()
print('=== 尝试：数据是否 = 明文 XOR 0x79 (让 0x1C->e) ===')
d = bytes(b ^ 0x79 for b in a[:200])
print('  ', repr(d.decode('latin1')))

print()
print('=== 检查字节对的规律：0x1C 0x7E / 0x1C 0x7D / 0x1C 0x7F ===')
# 这些可能是「字符 + 长度」或「高频词」
for pat in [(0x1C,0x7E), (0x1C,0x7D), (0x1C,0x7F), (0xDF,0x13), (0x1A,0x46)]:
    cnt = sum(1 for j in range(len(a)-1) if a[j]==pat[0] and a[j+1]==pat[1])
    print('  %02X %02X: %d 次' % (pat[0], pat[1], cnt))

print()
print('=== 关键：查看 0x1C 0x7E 的上下文 ===')
cnt = 0
for j in range(len(a)-1):
    if a[j]==0x1C and a[j+1]==0x7E:
        lo=max(0,j-6); hi=min(len(a),j+14)
        print('  @%d: %s' % (j, a[lo:hi].hex()))
        cnt += 1
        if cnt >= 8: break
