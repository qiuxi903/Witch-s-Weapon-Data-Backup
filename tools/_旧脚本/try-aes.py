# 用 Il2CppDumper 找到的密钥测试解密
import io, os, sys, struct, hashlib, base64

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

KEY = b'sfe023f_9fd&fwfl'   # 16 字节 = AES-128

d = open(r'G:\project\其他\game\提取资源\怀旧服v128_导出\新剧情\sentence_30319.bytes', 'rb').read()
print('密文 %d 字节' % len(d))
print('前 48: %s' % d[:48].hex())
print()

# --- 1) AES-128 各种模式（纯 Python 实现，无外部依赖）---
# 先试：密钥直接做 key，IV = 0
try:
    from Crypto.Cipher import AES
    HAVE = True
except ImportError:
    HAVE = False
print('pycryptodome 可用: %s' % HAVE)

if HAVE:
    for mode_name, mode in [('ECB', AES.MODE_ECB), ('CBC', AES.MODE_CBC)]:
        for key in [KEY, hashlib.md5(KEY).digest(), hashlib.sha256(KEY).digest()[:16]]:
            for iv in [b'\x00'*16, key]:
                try:
                    if mode == AES.MODE_ECB:
                        c = AES.new(key, mode)
                    else:
                        c = AES.new(key, mode, iv)
                    # 密文长度需为 16 倍数
                    n = len(d) - (len(d) % 16)
                    pt = c.decrypt(d[:n])
                    # 检查是否像 UTF-8 中文
                    try:
                        s = pt.decode('utf-8')
                        cjk = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
                        if cjk > 10:
                            print('*** 命中! mode=%s key=%s iv=%s CJK=%d' % (mode_name, key[:8].hex(), iv[:8].hex(), cjk))
                            print(s[:300])
                    except UnicodeDecodeError:
                        pass
                except Exception as e:
                    pass
    print('AES 测试完成')

# --- 2) 尝试自定义 Base64 变体解码 ---
print()
print('=== 尝试作为 Base64 变体 ===')
# 密文里有很多 0x00-0x1F，不像标准 base64
# 但如果先 XOR 再 base64 呢？
for k in range(256):
    x = bytes(b ^ k for b in d[:64])
    if all(32 <= b < 127 for b in x):
        print('  XOR %02X -> 可打印: %s' % (k, x.decode('ascii', 'replace')[:60]))

# --- 3) 统计：是否像 UTF-16 ---
print()
print('=== UTF-16 检查 ===')
for enc in ['utf-16-le', 'utf-16-be']:
    try:
        s = d.decode(enc, 'replace')
        cjk = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
        print('  %s: CJK=%d / %d 字符' % (enc, cjk, len(s)))
        if cjk > 20:
            print('    ' + s[:200])
    except Exception as e:
        print('  %s: %s' % (enc, e))

# --- 4) 与已知 sentence_00001 密文对比结构 ---
print()
print('=== 与国服 sentence_00001 密文对比 ===')
cn = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
print('  (国服密文需另行提取，此处仅记录长度对比)')
print('  怀旧 30319 密文长度: %d' % len(d))
