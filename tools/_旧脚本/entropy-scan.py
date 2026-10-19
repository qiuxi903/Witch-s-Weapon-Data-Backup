import io, os, sys, struct, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
exec(open(r'G:\project\其他\game\tools\parse-v3.py', encoding='utf-8').read().split("if __name__")[0])

D = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config\clientexel'
p = os.path.join(D, 'servant.ab')
d = decompress_bundle(p)

# 全文件扫描：找高熵区域（数据区）
print('=== 熵分布（每 1024 字节）===')
import math
for st in range(0, len(d), 1024):
    seg = d[st:st+1024]
    if not seg: break
    from collections import Counter
    c = Counter(seg)
    ent = -sum((n/len(seg)) * math.log2(n/len(seg)) for n in c.values())
    if ent > 6.5:
        print('  %6d - %6d  熵 %.2f  <== 高熵' % (st, st+len(seg), ent))

print()
# 找 bytes 字段区：bytes[0]..bytes[15] 在 978-1128，说明是 Hash128 序列化
# 真正的 bytes 数组应该在 m_Name 之前或之后
# 打印 1600-3100 区间
print('=== 1600 - 2400 区间 ===')
for i in range(1600, 2400, 16):
    ch = d[i:i+16]
    print('  %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in ch),
          ''.join(chr(b) if 32<=b<127 else '.' for b in ch)))
