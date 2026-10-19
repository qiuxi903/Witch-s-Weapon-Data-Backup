import io, os, sys, struct, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
exec(open(r'G:\project\其他\game\tools\parse-v3.py', encoding='utf-8').read().split("if __name__")[0])

d_lesson = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson'
for f in ['sentence_00140.ab', 'sentence_31003.ab', 'sentence_99902.ab']:
    p = os.path.join(d_lesson, f)
    d = decompress_bundle(p)
    print('=' * 72)
    print('%s  解压 %d 字节' % (f, len(d)))
    print('=' * 72)
    occ = [m for m in re.finditer(rb'sentence_\d+', d)]
    print('  资源名出现 %d 次: %s' % (len(occ), [m.start() for m in occ]))
    # 打印最后一次之后的内容
    if occ:
        last = occ[-1].start()
        end = d.find(b'\x00', occ[-1].end())
        print('  最后一次 @%d 结束 %d' % (last, end))
        for i in range(max(0,last-8), min(last + 64, len(d)), 16):
            chunk = d[i:i+16]
            print('    %06X  %s  |%s|' % (i, ' '.join('%02X'%b for b in chunk),
                  ''.join(chr(b) if 32<=b<127 else '.' for b in chunk)))
    # 全局扫描：找能解出中文的偏移
    hits = []
    for st in range(0, len(d) - 500):
        seg = d[st:st+500]
        pt = bytes(b ^ 0xFF for b in seg)
        try:
            s = pt.decode('utf-8')
            cjk = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
            if cjk > 80: hits.append(st)
        except UnicodeDecodeError: pass
    if hits:
        print('  可解密偏移: %s' % hits[:5])
        print('  内容: ' + bytes(b ^ 0xFF for b in d[hits[0]:hits[0]+300]).decode('utf-8','replace')[:200])
    else:
        print('  未找到可解密区域（可能是空文件或纯英文）')
    print()
