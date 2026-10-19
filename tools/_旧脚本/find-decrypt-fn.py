import io, sys, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

def ctx(pos, back=120, fwd=200):
    lo = max(0, pos - back); hi = min(len(md), pos + fwd)
    raw = md[lo:hi]
    # 提取可读 ASCII 串
    parts = re.findall(rb'[\x20-\x7e]{3,}', raw)
    return ' | '.join(p.decode('ascii') for p in parts)

print('=== isEncrypt 上下文 ===')
for pos in [2332763, 1955385]:
    print('  @%d: %s' % (pos, ctx(pos)))
    print()

print('=== Rijndael 上下文 ===')
for pos in [737882, 1027096, 1510903]:
    print('  @%d: %s' % (pos, ctx(pos, 200, 300)))
    print()

print('=== 搜索可能的解密类名 ===')
for kw in [b'EncryptUtil', b'EncryptHelper', b'DecryptUtil', b'CryptoUtil', b'SecurityUtil',
           b'Encryption', b'Decryption', b'AesHelper', b'AESHelper', b'XXTEAUtil',
           b'LessonConfig', b'SentenceConfig', b'TempConfig', b'ConfigUtil']:
    i = md.find(kw)
    if i >= 0:
        print('  %-16s @%d  %s' % (kw.decode(), i, ctx(i, 60, 120)))

print()
print('=== 提取所有含 Decrypt/Encrypt 的完整标识符 ===')
found = set()
for m in re.finditer(rb'[A-Za-z_][A-Za-z0-9_]{2,60}', md):
    s = m.group().decode('ascii')
    if ('ecrypt' in s or 'ncrypt' in s) and len(s) > 6:
        found.add(s)
for s in sorted(found):
    print('  ', s)
