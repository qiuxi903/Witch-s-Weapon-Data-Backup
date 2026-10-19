import io, os, sys, struct, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
exec(open(r'G:\project\其他\game\tools\parse-v3.py', encoding='utf-8').read().split("if __name__")[0])

D = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config\clientexel'
p = os.path.join(D, 'servant.ab')
d = decompress_bundle(p)
print('servant.ab 解压 %d 字节' % len(d))
print()
print('=== 所有字符串 ===')
for m in re.finditer(rb'[\x20-\x7e]{3,}', d):
    print('  @%6d  %s' % (m.start(), m.group(0).decode('ascii')[:80]))
print()
print('=== 尾部 200 字节 ===')
s = max(0, len(d) - 200)
for i in range(s, len(d), 16):
    ch = d[i:i+16]
    print('  %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in ch),
          ''.join(chr(b) if 32<=b<127 else '.' for b in ch)))
print()
print('=== 扫描：哪个偏移取反后是合法 UTF-8 ===')
for st in range(0, min(3000, len(d))):
    seg = d[st:st+400]
    pt = bytes(b ^ 0xFF for b in seg)
    try:
        t = pt.decode('utf-8')
        cjk = sum(1 for ch in t if '\u4e00' <= ch <= '\u9fff')
        if cjk > 20:
            print('  偏移 %d: CJK=%d' % (st, cjk))
            print('    ' + t[:150].replace('\n',' '))
            break
    except UnicodeDecodeError:
        pass
else:
    print('  未找到')
