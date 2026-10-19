# 提取 clientexel 配置（可能是同样的 BytesAsset + XOR 0xFF）
import io, os, sys, struct, re, json
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

exec(open(r'G:\project\其他\game\tools\parse-v3.py', encoding='utf-8').read().split("if __name__")[0])

D = r'G:\project\其他\game\提取资源\怀旧服v128_完整解包\assets\assetbundle\config\clientexel'
OUT = r'G:\project\其他\game\提取资源\怀旧服v128_导出\config'
os.makedirs(OUT, exist_ok=True)

for n in ['dictionary', 'servant', 'servantimage', 'dictionarystatic', 'dictionarylibrary']:
    p = os.path.join(D, n + '.ab')
    if not os.path.exists(p):
        print('%s 不存在' % n); continue
    print('=' * 70)
    print(n)
    print('=' * 70)
    try:
        d = decompress_bundle(p)
        print('  解压 %d 字节' % len(d))
        # 找所有可读字符串
        strs = [s.decode('ascii') for s in re.findall(rb'[\x20-\x7e]{4,}', d)]
        print('  ASCII 串 %d 条, 前 12:' % len(strs))
        for s in strs[:12]:
            print('    ' + s[:90])
        # 试 XOR 0xFF 后找 UTF-8 中文
        pt = bytes(b ^ 0xFF for b in d)
        try:
            t = pt.decode('utf-8')
            cjk = re.findall(r'[\u4e00-\u9fff]{2,}', t)
            print('  取反后中文串 %d 条, 前 15:' % len(cjk))
            for s in cjk[:15]:
                print('    ' + s[:80])
            if cjk:
                io.open(os.path.join(OUT, n + '.decrypted.txt'), 'w', encoding='utf-8').write(t)
                print('  已保存 %s.decrypted.txt' % n)
        except UnicodeDecodeError as e:
            print('  取反后非 UTF-8: %s' % e)
    except Exception as e:
        print('  异常: %s' % e)
    print()
