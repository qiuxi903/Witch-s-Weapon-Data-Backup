# 解析 BytesAsset：定位 bytes 数组并尝试用已知密钥解密
import io, os, sys, struct, re, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

outdir = r'G:\project\其他\game\提取资源\怀旧服v128_导出\新剧情'

def parse_bytes_asset(d):
    """在解压数据中定位 BytesAsset 的 bytes 字段"""
    # 找 m_Name + 资源名
    nm = re.search(rb'sentence_\d+', d)
    if not nm:
        return None
    end = d.find(b'\x00', nm.end())
    # m_Name 字符串后：对齐到 4，然后是 bytes 数组长度(int32 LE)
    o = end + 1
    o = o + ((4 - o % 4) % 4)
    # 尝试几个偏移
    results = []
    for delta in range(0, 24, 4):
        p = o + delta
        if p + 4 > len(d):
            continue
        cnt = struct.unpack_from('<i', d, p)[0]
        if 100 < cnt < 200000 and p + 4 + cnt <= len(d):
            results.append((delta, cnt, p + 4))
    return {'name': nm.group(0).decode(), 'name_end': end, 'candidates': results}

for n in ['sentence_30319', 'sentence_303190', 'sentence_30320', 'sentence_30321']:
    p = os.path.join(outdir, n + '.decompressed')
    d = open(p, 'rb').read()
    print('=' * 72)
    print('%s  (%d 字节)' % (n, len(d)))
    print('=' * 72)
    info = parse_bytes_asset(d)
    if not info:
        print('  未找到资源名')
        continue
    print('  资源名: %s  (结束于 offset %d)' % (info['name'], info['name_end']))
    if not info['candidates']:
        print('  未找到合理的 bytes 数组长度')
        # 强制打印 name_end 后 48 字节
        s = info['name_end']
        print('  name_end 后 48 字节: %s' % d[s:s+48].hex())
    for delta, cnt, dataoff in info['candidates']:
        print('  [候选] delta=%d 长度=%d 数据起始=%d' % (delta, cnt, dataoff))
        payload = d[dataoff:dataoff+cnt]
        print('    前 32 字节: %s' % payload[:32].hex())
        # 统计
        from collections import Counter
        c = Counter(payload)
        print('    不同字节值: %d' % len(c))
        hx = Counter(b >> 4 for b in payload)
        print('    高半字节分布: ' + ' '.join('%X:%.1f%%' % (k, v*100/len(payload)) for k, v in sorted(hx.items())))
        # 保存
        outp = os.path.join(outdir, '%s.bytes' % n)
        open(outp, 'wb').write(payload)
        print('    已保存 %s' % outp)
    print()
