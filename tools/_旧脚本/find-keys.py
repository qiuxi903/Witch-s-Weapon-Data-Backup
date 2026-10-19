import io, sys, re, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

so = r'G:\project\其他\game\提取资源\国服DLL\libil2cpp.so'
with open(so, 'rb') as f:
    data = f.read()
print('libil2cpp.so:', len(data), 'bytes')

# 搜索可能是密钥的字符串
print()
print('=== 搜索可疑密钥字符串 ===')
pats = [
    rb'[A-Za-z0-9+/]{16,64}={0,2}',   # base64
    rb'[0-9a-fA-F]{32}',               # MD5 hex
    rb'[0-9a-fA-F]{16}',               # 16 hex
    rb'[0-9a-fA-F]{64}',               # SHA256 hex
]
found = collections.Counter()
for pat in pats:
    for m in re.finditer(pat, data):
        s = m.group().decode('ascii')
        found[s] += 1

print('  找到 %d 个候选字符串' % len(found))
for s, c in found.most_common(40):
    print('    %-70s x%d' % (s, c))
