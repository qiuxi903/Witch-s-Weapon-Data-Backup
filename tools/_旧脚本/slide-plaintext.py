import io, sys, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
p = base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
i = raw.find(b'sentence_00001')
ln = struct.unpack_from('<H', raw, i+16)[0]
ct = raw[i+20:i+20+ln]

pt_str = '『异质物』旦满足特定条件，就能引发超常物理现象的信息或载体'
pt = pt_str.encode('utf-8')

print('=== 滑动明文，找 XOR 密钥重复的位置 ===')
# 如果 ct = pt XOR key(重复)，那么对某个对齐，ct[j]^pt[j] 应该周期重复
best = []
for off in range(0, min(400, len(ct)-len(pt))):
    x = bytes(ct[off+j] ^ pt[j] for j in range(len(pt)))
    # 检查是否有周期性（找最小周期）
    for klen in range(1, 33):
        if all(x[j] == x[j % klen] for j in range(len(x))):
            best.append((off, klen, x[:klen]))
            break
print('  找到 %d 个候选' % len(best))
for off, klen, key in best[:10]:
    print('    密文偏移 %d, 密钥长度 %d, key=%s' % (off, klen, key.hex()))

print()
print('=== 检查：密文是否是明文的反向（倒序）===')
pt_rev = pt[::-1]
for off in range(0, min(400, len(ct)-len(pt_rev))):
    x = bytes(ct[off+j] ^ pt_rev[j] for j in range(len(pt_rev)))
    for klen in range(1, 33):
        if all(x[j] == x[j % klen] for j in range(len(x))):
            print('    倒序: 偏移 %d, 密钥长度 %d' % (off, klen))
            break

print()
print('=== 检查：密文是否 = 明文的某种「字节重排」===')
# 统计明文的字节集合
pt_set = set(pt)
ct_set = set(ct)
print('  明文字节种类: %d' % len(pt_set))
print('  密文字节种类: %d' % len(ct_set))
print('  交集: %d' % len(pt_set & ct_set))
print('  明文有但密文无: %s' % sorted(pt_set - ct_set)[:20])
print('  密文有但明文无: %s' % sorted(ct_set - pt_set)[:20])

print()
print('=== 检查：密文是否 = 明文 XOR 固定 16 字节密钥（AES 前）===')
# 试所有可能的 16 字节密钥是不现实的，但可以看 XOR 差异是否有周期性
x = bytes(ct[j] ^ pt[j] for j in range(len(pt)))
print('  XOR 差异:', x.hex())
# 找重复
for klen in [4, 8, 16]:
    print('  周期 %d 检查: %s' % (klen, 'YES' if all(x[j]==x[j%klen] for j in range(len(x))) else 'no'))
