import io, sys, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
p = base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
i = raw.find(b'sentence_00001')
ln = struct.unpack_from('<H', raw, i+16)[0]
ct = raw[i+20:i+20+ln]
print('密文 %d 字节' % len(ct))

# 已知明文（从日文博客的中文原文）
pt_str = '『异质物』旦满足特定条件，就能引发超常物理现象的信息或载体'
pt = pt_str.encode('utf-8')
print('明文 %d 字节: %s' % (len(pt), pt.hex()))

print()
print('=== 密文前 64 字节 ===')
print(' ', ct[:64].hex())

print()
print('=== 明文前 64 字节 ===')
print(' ', pt[:64].hex())

print()
print('=== 直接对比（假设密文从偏移 0 对应明文偏移 0）===')
n = min(len(ct), len(pt))
for off in range(0, 16):
    if off + 8 > n: break
    xor = bytes(ct[off+j] ^ pt[j] for j in range(8))
    print('  密文偏移 %2d: XOR = %s' % (off, xor.hex()))

print()
print('=== 搜索明文片段在密文中的位置（XOR 密钥重复检测）===')
# 如果密文 = 明文 XOR 重复密钥，那么 (ct[i] ^ pt[j]) 对相同密钥位置应一致
# 先假设简单 XOR，找密钥长度
for klen in range(1, 33):
    # 假设密文从 0 开始对应明文从 0
    key = bytearray(klen)
    ok = True
    for j in range(min(len(pt), len(ct))):
        k = ct[j] ^ pt[j]
        if key[j % klen] == 0:
            key[j % klen] = k
        elif key[j % klen] != k:
            ok = False
            break
    if ok:
        print('  密钥长度 %d 可行! key = %s' % (klen, bytes(key).hex()))
