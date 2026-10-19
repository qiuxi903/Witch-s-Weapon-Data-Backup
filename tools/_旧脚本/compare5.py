import io, sys, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
regions = {
    'CN': base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab',
    'JP': base + r'\日服v2.0.0_OBB解包\assets\assetbundle\config\lesson\sentence_00001.ab',
    'TW': base + r'\港澳台v1.6.0_OBB解包\assets\assetbundle\config\lesson\sentence_00001.ab',
    'KR': base + r'\韩服v1.0_OBB解包\assets\assetbundle\config\lesson\sentence_00001.ab',
}

for k, p in regions.items():
    with open(p, 'rb') as f:
        raw = f.read()
    i = raw.find(b'sentence_00001')
    print('[%s] 文件 %d 字节, name@%d' % (k, len(raw), i))
    if i < 0: continue
    # 打印 name 之后 24 字节
    seg = raw[i+14:i+14+24]
    print('   name 后 24 字节: %s' % seg.hex())
    for j, b in enumerate(seg):
        print('     +%d (abs %d): 0x%02X' % (j, i+14+j, b))
    print()
