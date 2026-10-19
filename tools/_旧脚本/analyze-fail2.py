# 深入分析失败文件 sentence_00002 的结构
import io, os, sys, struct, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

exec(open(r'G:\project\其他\game\tools\parse-v2.py', encoding='utf-8').read().split('d_lesson =')[0])

p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00002.ab'
d = decompress_bundle(p)
print('解压 %d 字节' % len(d))

# 找所有可读字符串和它们的位置
print()
print('=== 所有可读字符串 (>=6) ===')
for m in re.finditer(rb'[\x20-\x7e]{6,}', d):
    print('  @%6d  %s' % (m.start(), m.group(0).decode('ascii')[:90]))

print()
print('=== 找 BytesAsset / isEncrypt 标记 ===')
for kw in [b'BytesAsset', b'isEncrypt', b'bytes', b'm_Name', b'_temp_config']:
    idxs = [m.start() for m in re.finditer(re.escape(kw), d)]
    print('  %-14s @ %s' % (kw.decode(), idxs[:10]))

# 假设：密文在文件末尾。找末尾大块"高熵"��据
print()
print('=== 尾部 256 字节 ===')
s = len(d) - 256
for i in range(s, len(d), 16):
    chunk = d[i:i+16]
    print('  %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in chunk),
          ''.join(chr(b) if 32<=b<127 else '.' for b in chunk)))

# 试：从各偏移开始 XOR 0xFF，看哪里开始出现大量中文
print()
print('=== 扫描：从哪个偏移开始用 XOR 0xFF 能解出中文 ===')
best = []
for start in range(0, len(d) - 2000, 1):
    seg = d[start:start+2000]
    pt = bytes(b ^ 0xFF for b in seg)
    try:
        s2 = pt.decode('utf-8')
        cjk = sum(1 for ch in s2 if '\u4e00' <= ch <= '\u9fff')
        if cjk > 300:
            best.append((start, cjk))
    except UnicodeDecodeError:
        pass
if best:
    print('  命中偏移: %s' % best[:10])
    st = best[0][0]
    print()
    print('  从 %d 开始解密:' % st)
    print('  ' + bytes(b ^ 0xFF for b in d[st:st+600]).decode('utf-8','replace')[:400])
else:
    print('  未找到')
