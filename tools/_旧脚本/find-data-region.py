import io, os, sys, struct, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
exec(open(r'G:\project\其他\game\tools\parse-v3.py', encoding='utf-8').read().split("if __name__")[0])

D = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config\clientexel'
p = os.path.join(D, 'servant.ab')
d = decompress_bundle(p)
print('总长 %d' % len(d))
print()

# 找所有 "bytes" 出现
print('=== "bytes" 出现位置 ===')
for m in re.finditer(rb'bytes', d):
    print('  @%d' % m.start())
print()

# 找非零数据段（连续 >200 字节非零）
print('=== 连续非零段 (>200 字节) ===')
runs = []
st = None
for i in range(len(d)):
    if d[i] != 0:
        if st is None: st = i
    else:
        if st is not None and i - st > 200:
            runs.append((st, i))
        st = None
if st is not None and len(d) - st > 200:
    runs.append((st, len(d)))
for a, b in runs:
    print('  %6d - %6d  (%d 字节)' % (a, b, b - a))
print()

# 打印最后一个非零段之后
print('=== 尾部 400 字节 ===')
for i in range(max(0, len(d) - 400), len(d), 16):
    ch = d[i:i+16]
    print('  %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in ch),
          ''.join(chr(b) if 32<=b<127 else '.' for b in ch)))
