import io, sys, re, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    data = f.read()

print('=== 搜索关键字段名 ===')
for kw in [b'isEncrypt', b'bytes', b'm_ClassName', b'lesson', b'sentence', b'script', b'Script']:
    idxs = []
    start = 0
    while True:
        i = data.find(kw, start)
        if i < 0: break
        idxs.append(i)
        start = i + 1
    print('  %-14s 出现 %d 次, 位置: %s' % (kw.decode(), len(idxs), idxs[:10]))

print()
print('=== isEncrypt 附近的字节 ===')
i = data.find(b'isEncrypt')
if i >= 0:
    lo = max(0, i - 64)
    hi = min(len(data), i + 128)
    print('  位置 %d, 上下文:' % i)
    for j in range(lo, hi, 16):
        chunk = data[j:j+16]
        hexs = ' '.join('%02X' % b for b in chunk)
        asc = ''.join(chr(b) if 32 <= b < 127 else '.' for b in chunk)
        mark = ' <-- ' if j <= i < j+16 else ''
        print('    %04X  %-47s  %s%s' % (j, hexs, asc, mark))

print()
print('=== 搜索所有可读字符串（长度>=3，含位置）===')
for m in re.finditer(rb'[\x20-\x7e]{3,}', data):
    s = m.group().decode('ascii')
    if not s.isdigit():
        print('  %6d  %s' % (m.start(), s))
