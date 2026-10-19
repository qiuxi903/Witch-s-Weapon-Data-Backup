import io, os, sys, struct, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
exec(open(r'G:\project\其他\game\tools\parse-v3.py', encoding='utf-8').read().split("if __name__")[0])

D = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config\clientexel'
p = os.path.join(D, 'servant.ab')
d = decompress_bundle(p)

# 数据区 4236 - 44445
# 找长度字段：在 4236 之前
print('=== 4220 - 4260 ===')
for i in range(4220, 4260, 16):
    ch = d[i:i+16]
    print('  %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in ch),
          ''.join(chr(b) if 32<=b<127 else '.' for b in ch)))
print()

data = d[4236:44445]
print('数据区 %d 字节' % len(data))
print()

# 试 XOR 0xFF
pt = bytes(b ^ 0xFF for b in data)
print('=== XOR 0xFF 后前 400 字节 ===')
print(repr(pt[:400]))
print()
try:
    s = pt.decode('utf-8')
    print('=== UTF-8 解码成功 ===')
    print(s[:1200])
except UnicodeDecodeError as e:
    print('UTF-8 失败: %s' % e)
    print('前 200 字节 repr: %r' % pt[:200])
