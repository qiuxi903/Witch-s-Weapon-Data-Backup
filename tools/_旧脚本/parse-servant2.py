import io, os, sys, struct, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
exec(open(r'G:\project\其他\game\tools\parse-v3.py', encoding='utf-8').read().split("if __name__")[0])

D = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config\clientexel'
p = os.path.join(D, 'servant.ab')
d = decompress_bundle(p)

# m_Name 是 "clientexel/servant" @44612，结束在 44628
last = 44612
end = d.find(b'\x00', last)
print('m_Name @%d 结束 @%d' % (last, end))
print()
print('=== name_end 附近 ===')
for i in range(end - 6, min(end + 40, len(d)), 16):
    ch = d[i:i+16]
    print('  %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in ch),
          ''.join(chr(b) if 32<=b<127 else '.' for b in ch)))
print()
print('总长 %d, name_end=%d, 剩余 %d 字节' % (len(d), end, len(d) - end))
print()

# 从 name_end 后各偏移试各种解密
print('=== 从 name_end 后各偏移尝试 ===')
for delta in range(0, 20):
    off = end + 1 + delta
    if off + 60 > len(d): break
    seg = d[off:off+60]
    # 试 XOR 0xFF
    pt = bytes(b ^ 0xFF for b in seg)
    try:
        s = pt.decode('utf-8')
        cjk = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
        if cjk > 3:
            print('  delta=%2d XOR-FF CJK=%d: %s' % (delta, cjk, s[:50]))
            continue
    except UnicodeDecodeError:
        pass
    # 试直接 UTF-8
    try:
        s2 = seg.decode('utf-8')
        cjk2 = sum(1 for ch in s2 if '\u4e00' <= ch <= '\u9fff')
        if cjk2 > 3:
            print('  delta=%2d 明文 CJK=%d: %s' % (delta, cjk2, s2[:50]))
            continue
    except UnicodeDecodeError:
        pass
    print('  delta=%2d  %s' % (delta, ' '.join('%02X'%b for b in seg[:12])))

# 找 u32 LE 长度字段
print()
print('=== 搜索合理的长度字段 ===')
for lp in range(end, end + 20):
    if lp + 4 > len(d): break
    v = struct.unpack_from('<I', d, lp)[0]
    if 100 < v < len(d):
        print('  @%d (delta=%d): %d' % (lp, lp - end, v))
