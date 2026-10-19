# 用找到的密钥做完整的 AES 测试
import io, os, sys, struct, hashlib, itertools

sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from Crypto.Cipher import AES
from Crypto.Util.Padding import unpad

KEYSTR = b'sfe023f_9fd&fwfl'

d = open(r'G:\project\其他\game\提取资源\怀旧服v128_导出\新剧情\sentence_30319.bytes', 'rb').read()
print('密文 %d 字节' % len(d))

def score(pt):
    """评分：像不像 UTF-8 中文文本"""
    try:
        s = pt.decode('utf-8')
    except UnicodeDecodeError:
        return -1, ''
    cjk = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
    # 常见中文标点
    punct = sum(1 for ch in s if ch in '，。！？、：；「」『』（）…—')
    return cjk + punct * 2, s

keys = {
    'raw16': KEYSTR,
    'md5': hashlib.md5(KEYSTR).digest(),
    'sha256[:16]': hashlib.sha256(KEYSTR).digest()[:16],
    'utf16le[:16]': KEYSTR.decode().encode('utf-16-le')[:16],
    'pad16': KEYSTR + b'\x00' * 0,
    'base64[:16]': __import__('base64').b64encode(KEYSTR)[:16],
}

best = (-1, None, None, None)
for kname, key in keys.items():
    if len(key) not in (16, 24, 32):
        continue
    for mode_name in ['ECB', 'CBC', 'CFB', 'OFB']:
        for ivname, iv in [('zero', b'\x00'*16), ('key', key[:16]), ('keyrev', key[:16][::-1])]:
            try:
                if mode_name == 'ECB':
                    c = AES.new(key, AES.MODE_ECB)
                    n = len(d) - (len(d) % 16)
                    pt = c.decrypt(d[:n])
                elif mode_name == 'CBC':
                    c = AES.new(key, AES.MODE_CBC, iv)
                    n = len(d) - (len(d) % 16)
                    pt = c.decrypt(d[:n])
                elif mode_name == 'CFB':
                    c = AES.new(key, AES.MODE_CFB, iv, segment_size=128)
                    pt = c.decrypt(d)
                else:
                    c = AES.new(key, AES.MODE_OFB, iv)
                    pt = c.decrypt(d)
                sc, s = score(pt)
                if sc > best[0]:
                    best = (sc, kname, '%s/%s' % (mode_name, ivname), s)
            except Exception:
                pass

print()
print('=== 最佳结果 ===')
print('  评分: %d' % best[0])
print('  参数: key=%s mode=%s' % (best[1], best[2]))
if best[3]:
    print('  文本前 400 字符:')
    print('  ' + best[3][:400].replace('\n', ' | '))
else:
    print('  (无有效 UTF-8 输出)')

# 也试试：密文可能先被 base64 变体编码
print()
print('=== 密文是否含大量非 ASCII？===')
print('  0x00-0x1F 占比: %.1f%%' % (sum(1 for b in d if b < 0x20) * 100 / len(d)))
print('  0x80+ 占比:    %.1f%%' % (sum(1 for b in d if b >= 0x80) * 100 / len(d)))
