# 音频资源整理：按类别归档 + 用 sound.csv 建立索引 + 生成试听页
import io, os, sys, re, csv, json, shutil
from collections import Counter, OrderedDict

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
CFG  = os.path.join(R, '配置表_解密版', '怀旧服v128')
SRC  = os.path.join(R, '提取资源')          # 已导出的音频
MUS  = os.path.join(R, '音乐原声')
OUT  = os.path.join(R, '音频资源_整理')
os.makedirs(OUT, exist_ok=True)

# ---------- 1) 收集全部音频 ----------
EXTS = ('.wav', '.mp3', '.ogg', '.m4a')
files = []
for base in [SRC, MUS]:
    if not os.path.isdir(base):
        continue
    for dp, dn, fn in os.walk(base):
        for f in fn:
            if f.lower().endswith(EXTS):
                files.append(os.path.join(dp, f))
print('收集音频 %d 个' % len(files))

# ---------- 2) 分类 ----------
def classify(p):
    low = p.lower().replace('\\', '/')
    if '/cv/servant' in low or '/cv/player' in low:
        return 'CV语音'
    if '/bgm/' in low or '音乐原声' in p:
        return 'BGM原声'
    if '/fight/' in low:
        return '战斗音效'
    if '/mainui/' in low or '/ui/' in low:
        return '界面音效'
    if '/sounds/' in low:
        return '其它音效'
    return '其它'

buckets = OrderedDict()
for p in files:
    buckets.setdefault(classify(p), []).append(p)

print()
print('=== 分类 ===')
for k, v in buckets.items():
    sz = sum(os.path.getsize(x) for x in v)
    print('  %-10s %5d 个  %9.1f MB' % (k, len(v), sz / 1024 / 1024))

# ---------- 3) 归档（硬链接省空间，失败则复制）----------
def link(src, dst):
    if os.path.exists(dst):
        return True
    try:
        os.link(src, dst); return True
    except Exception:
        try:
            shutil.copy2(src, dst); return True
        except Exception:
            return False

manifest = []
for cat, items in buckets.items():
    cd = os.path.join(OUT, cat)
    os.makedirs(cd, exist_ok=True)
    for p in items:
        # CV 语音按角色分目录
        sub = ''
        m = re.search(r'cv[/\\](servant\d+|player)', p, re.I)
        if m:
            sub = m.group(1)
        dd = os.path.join(cd, sub) if sub else cd
        os.makedirs(dd, exist_ok=True)
        name = os.path.basename(p)
        dst = os.path.join(dd, name)
        # 重名加前缀
        if os.path.exists(dst) and os.path.getsize(dst) != os.path.getsize(p):
            stem, ext = os.path.splitext(name)
            dst = os.path.join(dd, '%s_%s%s' % (stem, abs(hash(p)) % 10000, ext))
        if link(p, dst):
            manifest.append({'cat': cat, 'sub': sub, 'file': os.path.relpath(dst, OUT).replace('\\', '/'),
                             'src': p, 'bytes': os.path.getsize(p)})

print()
print('归档 %d 个' % len(manifest))

# ---------- 4) sound.csv 索引 ----------
srows = [l.rstrip('\n').split('\t') for l in io.open(os.path.join(CFG, 'sound.csv'), encoding='utf-8', errors='replace')]
snd = []
for r in srows[3:]:
    if len(r) >= 2 and r[0].strip():
        snd.append({'id': r[0].strip(), 'path': r[1].strip() if len(r) > 1 else ''})
print('sound.csv 条目 %d' % len(snd))

# 用文件名匹配
byname = {}
for m in manifest:
    byname.setdefault(os.path.splitext(os.path.basename(m['file']))[0].lower(), []).append(m)
matched = 0
for s in snd:
    base = os.path.splitext(os.path.basename(s['path']))[0].lower()
    hit = byname.get(base)
    if hit:
        s['local'] = hit[0]['file']; matched += 1
    else:
        s['local'] = ''
print('sound.csv 匹配到本地文件 %d / %d' % (matched, len(snd)))

json.dump(manifest, io.open(os.path.join(OUT, '_manifest.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
json.dump(snd, io.open(os.path.join(OUT, '_sound_index.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)

print()
print('=== 归档结果 ===')
for cat in buckets:
    cd = os.path.join(OUT, cat)
    n = sum(len(f) for _, _, f in os.walk(cd))
    sz = sum(os.path.getsize(os.path.join(dp, f)) for dp, _, fs in os.walk(cd) for f in fs)
    print('  %-10s %5d 个  %9.1f MB' % (cat, n, sz / 1024 / 1024))
