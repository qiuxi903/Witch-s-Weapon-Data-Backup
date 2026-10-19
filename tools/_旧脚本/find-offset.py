import io, os, sys, struct, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
exec(open(r'G:\project\其他\game\tools\parse-v2.py', encoding='utf-8').read().split('d_lesson =')[0])

p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00002.ab'
d = decompress_bundle(p)

# m_Name 在 4440 附近
print('=== offset 4380 - 4480 ===')
for i in range(4380, min(4480, len(d)), 16):
    chunk = d[i:i+16]
    print('  %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in chunk),
          ''.join(chr(b) if 32<=b<127 else '.' for b in chunk)))
print()
print('总长 %d' % len(d))

# 找 "sentence_00002" 作为 m_Name 的那次出现（最后一次）
occ = [m.start() for m in re.finditer(rb'sentence_00002', d)]
print('sentence_00002 出现位置: %s' % occ)

# 取最后一次
last = occ[-1]
end = d.find(b'\x00', last)
print('最后一次 @%d, 结束于 %d' % (last, end))
print()
print('=== name_end 后 32 字节 ===')
for i in range(end - 4, min(end + 32, len(d)), 16):
    chunk = d[i:i+16]
    print('  %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in chunk),
          ''.join(chr(b) if 32<=b<127 else '.' for b in chunk)))

# 从 name_end 后各种偏移试解密
print()
print('=== 从 name_end 后各偏移试 XOR 0xFF ===')
for delta in range(0, 24):
    off = end + 1 + delta
    if off + 100 > len(d): break
    seg = d[off:off+120]
    pt = bytes(b ^ 0xFF for b in seg)
    try:
        s = pt.decode('utf-8')
        cjk = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
        flag = '  <<<<' if cjk > 10 else ''
        print('  delta=%2d  CJK=%3d  %s%s' % (delta, cjk, s[:50].replace('\n',' '), flag))
    except UnicodeDecodeError:
        print('  delta=%2d  解码失败' % delta)
