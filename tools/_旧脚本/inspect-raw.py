import io, sys, collections, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    data = f.read()

print('文件大小:', len(data))
print()
print('=== 前 256 字节 hex ===')
for i in range(0, min(256, len(data)), 16):
    chunk = data[i:i+16]
    hexs = ' '.join('%02X' % b for b in chunk)
    asc = ''.join(chr(b) if 32 <= b < 127 else '.' for b in chunk)
    print('  %04X  %-47s  %s' % (i, hexs, asc))

print()
print('=== 文件头 ===')
print('  前 16 字节:', data[:16].hex())
# UnityFS 头
if data[:8] == b'UnityFS\x00':
    print('  -> UnityFS 资源包')
else:
    print('  前 8 字节 ASCII:', repr(data[:8]))

print()
print('=== 字节分布 ===')
c = collections.Counter(data)
print('  不同字节值:', len(c))
print('  最常见:', [(hex(k), v) for k, v in c.most_common(10)])
print('  0x00 出现:', c.get(0, 0))
print('  范围: 0x%02X - 0x%02X' % (min(data), max(data)))

print()
print('=== 搜索可读字符串 ===')
import re
strings = re.findall(rb'[\x20-\x7e]{4,}', data)
for s in strings[:30]:
    print('  ', s.decode('ascii', errors='replace'))
