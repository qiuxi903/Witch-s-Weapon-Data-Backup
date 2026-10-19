import io, os, re, sys, unicodedata
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

SRC = r'G:\project\其他\game\剧情文本_解密版\国服v2.0.1'
bad = {}
for f in sorted(os.listdir(SRC)):
    if not f.endswith('.txt'): continue
    c = io.open(os.path.join(SRC, f), encoding='utf-8').read()
    for ch in c:
        o = ord(ch)
        # XML 1.0 合法范围
        ok = (o == 0x9 or o == 0xA or o == 0xD or
              0x20 <= o <= 0xD7FF or
              0xE000 <= o <= 0xFFFD or
              0x10000 <= o <= 0x10FFFF)
        if not ok:
            bad.setdefault(o, []).append(f)

print('=== XML 非法字符 ===')
if not bad:
    print('  无')
for o, files in sorted(bad.items()):
    print('  U+%04X  %d 次  例: %s' % (o, len(files), files[0]))

# 也检查代理对 / 非字符
print()
print('=== 其它可疑字符 ===')
susp = {}
for f in sorted(os.listdir(SRC)):
    if not f.endswith('.txt'): continue
    c = io.open(os.path.join(SRC, f), encoding='utf-8').read()
    for ch in c:
        o = ord(ch)
        if 0xD800 <= o <= 0xDFFF or o in (0xFFFE, 0xFFFF):
            susp.setdefault(o, 0)
            susp[o] += 1
if susp:
    for o, n in sorted(susp.items()):
        print('  U+%04X  %d 次' % (o, n))
else:
    print('  无')

# 找最长的行，测试 lxml
print()
print('=== 测试 lxml 写入 ===')
try:
    from lxml import etree
    e = etree.Element('a')
    for f in sorted(os.listdir(SRC))[:5]:
        c = io.open(os.path.join(SRC, f), encoding='utf-8').read()
        for ln in c.split('\n'):
            for part in ln.split('\t'):
                try:
                    e.text = part
                except Exception as ex:
                    print('  失败于 %s: %r' % (f, part[:60]))
                    print('    %s' % ex)
                    raise SystemExit
    print('  前 5 个文件全部 OK')
except Exception as ex:
    print('  %s' % ex)
