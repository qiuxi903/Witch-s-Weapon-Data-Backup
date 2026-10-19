# 为所有图片建立尺寸索引（用于自适应布局）
import io, os, sys, struct, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R = r'G:\project\其他\game'
OUT = os.path.join(R, 'tools', '_image_meta.json')

def png_size(p):
    try:
        with open(p, 'rb') as f:
            h = f.read(33)
        if h[:8] != b'\x89PNG\r\n\x1a\n' or h[12:16] != b'IHDR':
            return None
        return struct.unpack('>II', h[16:24])
    except Exception:
        return None

def jpg_size(p):
    try:
        with open(p, 'rb') as f:
            d = f.read()
        i = 2
        while i < len(d) - 9:
            if d[i] != 0xFF:
                i += 1; continue
            m = d[i+1]
            if m in (0xC0,0xC1,0xC2,0xC3,0xC5,0xC6,0xC7,0xC9,0xCA,0xCB,0xCD,0xCE,0xCF):
                h, w = struct.unpack('>HH', d[i+5:i+9])
                return w, h
            if m in (0xD8,0xD9) or 0xD0 <= m <= 0xD7:
                i += 2; continue
            ln = struct.unpack('>H', d[i+2:i+4])[0]
            i += 2 + ln
    except Exception:
        pass
    return None

meta = {}
n = 0
for dp, dn, fn in os.walk(R):
    if '_重复文件_待删' in dp or '\\tools\\' in dp + '\\':
        continue
    for f in fn:
        e = os.path.splitext(f)[1].lower()
        if e not in ('.png', '.jpg', '.jpeg'):
            continue
        p = os.path.join(dp, f)
        rel = os.path.relpath(p, R).replace('\\', '/')
        s = png_size(p) if e == '.png' else jpg_size(p)
        if s:
            meta[rel] = [s[0], s[1]]
        n += 1
        if n % 2000 == 0:
            print('  %d ...' % n)

print('图片 %d 个, 拿到尺寸 %d 个' % (n, len(meta)))
json.dump(meta, io.open(OUT, 'w', encoding='utf-8'), separators=(',', ':'))
print('已保存 %s (%.1f MB)' % (OUT, os.path.getsize(OUT) / 1024 / 1024))

# 统计
from collections import Counter
ar = Counter()
for v in meta.values():
    if v[1]:
        ar[round(v[0] / v[1], 1)] += 1
print()
print('宽高比分布:')
for k, v in ar.most_common(12):
    print('  %.1f : %d' % (k, v))
