# 直接从 .ab 中提取 MonoBehaviour 的原始字节（跳过 AssetStudio 的类型解析）
import io, os, sys, struct, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

def read_cstr(b, o):
    e = b.find(b'\x00', o)
    return b[o:e].decode('utf-8', 'replace'), e + 1

def align(b, o, n=4):
    r = o % n
    return o if r == 0 else o + (n - r)

def parse_bundle(path):
    with open(path, 'rb') as f:
        raw = f.read()
    o = 0
    sig, o = read_cstr(raw, o)
    ver = struct.unpack_from('>I', raw, o)[0]; o += 4
    unity, o = read_cstr(raw, o)
    uver, o = read_cstr(raw, o)
    size = struct.unpack_from('>q', raw, o)[0]; o += 8
    cib = struct.unpack_from('>I', raw, o)[0]; o += 4
    uib = struct.unpack_from('>I', raw, o)[0]; o += 4
    flags = struct.unpack_from('>I', raw, o)[0]; o += 4
    o = align(raw, o, 16) if ver >= 7 else o
    print('  签名=%s 版本=%d Unity=%s 数据大小=%d' % (sig, ver, uver, size))
    print('  压缩���信息=%d 未压缩块信息=%d flags=0x%X' % (cib, uib, flags))
    # 压缩类型在 flags 低 6 位
    comp = flags & 0x3F
    print('  压缩类型=%d (0=无 1=LZMA 2=LZ4 3=LZ4HC)' % comp)
    return raw, o, comp, cib, uib, size, ver

for name in ['preserved_stage_manifest.ab', 'community_notice_image.ab']:
    p = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config' + '\\' + name
    print('=' * 70)
    print(name)
    print('=' * 70)
    if not os.path.exists(p):
        print('  不存在')
        continue
    parse_bundle(p)
    print()
