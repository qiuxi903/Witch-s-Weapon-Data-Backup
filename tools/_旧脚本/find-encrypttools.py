import io, sys, re

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

mp = r'G:\project\其他\game\提取资源\国服DLL\global-metadata.dat'
with open(mp, 'rb') as f:
    md = f.read()

def ctx(pos, back=300, fwd=600):
    lo = max(0, pos - back); hi = min(len(md), pos + fwd)
    raw = md[lo:hi]
    parts = re.findall(rb'[\x20-\x7e]{2,}', raw)
    return ' | '.join(p.decode('ascii') for p in parts)

print('=== EncryptTools 类上下文 ===')
for m in re.finditer(rb'EncryptTools', md):
    print('  @%d: %s' % (m.start(), ctx(m.start(), 400, 800)))
    print()

print()
print('=== BytesAsset 类上下文 ===')
for m in re.finditer(rb'BytesAsset', md):
    print('  @%d: %s' % (m.start(), ctx(m.start(), 200, 400)))
    print()
