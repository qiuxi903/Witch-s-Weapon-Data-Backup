# 抓取官网四格漫画与所有栏目资源
import io, os, re, sys, subprocess, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

PROXY = 'http://127.0.0.1:7897'
UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'
OUT = r'G:\project\其他\game\提取资源\网络资源\13_官网日服witchs-weapon.net'
os.makedirs(OUT, exist_ok=True)

def fetch(url, dest=None):
    cmd = ['curl.exe', '-sL', '-x', PROXY, '-m', '40', '-A', UA]
    if dest:
        cmd += ['-o', dest, '-w', '%{http_code}|%{size_download}']
    cmd.append(url)
    r = subprocess.run(cmd, capture_output=True, text=True, errors='replace')
    return r.stdout

# 1) 抓栏目页
pages = ['', 'story', 'character', 'system', 'cartoon', 'news', 'pre_register']
for pg in pages:
    name = pg if pg else 'index'
    dest = os.path.join(OUT, name + '.html')
    res = fetch('https://witchs-weapon.net/' + pg, dest)
    print('  %-14s %s' % (name, res))

# 2) 从所有页面收集图片 URL
allimgs = set()
for pg in pages:
    name = pg if pg else 'index'
    p = os.path.join(OUT, name + '.html')
    if not os.path.exists(p):
        continue
    c = io.open(p, encoding='utf-8', errors='ignore').read()
    for m in re.finditer(r'(?:src|href|data-src)="([^"]+\.(?:png|jpg|jpeg|gif|webp))"', c, re.I):
        u = m.group(1)
        if u.startswith('//'):
            u = 'https:' + u
        elif u.startswith('/'):
            u = 'https://witchs-weapon.net' + u
        elif not u.startswith('http'):
            u = 'https://witchs-weapon.net/' + u.lstrip('./')
        allimgs.add(u)

print()
print('收集到 %d 个图片 URL' % len(allimgs))

# 3) 下载
imgdir = os.path.join(OUT, 'img')
os.makedirs(imgdir, exist_ok=True)
ok = 0; fail = 0
manifest = []
for u in sorted(allimgs):
    fn = re.sub(r'[^A-Za-z0-9._-]', '_', u.split('witchs-weapon.net/')[-1])
    if len(fn) > 120:
        fn = fn[-120:]
    dest = os.path.join(imgdir, fn)
    if os.path.exists(dest) and os.path.getsize(dest) > 500:
        ok += 1
        continue
    res = fetch(u, dest)
    try:
        code, sz = res.split('|')
        sz = int(float(sz))
    except Exception:
        code, sz = '?', 0
    if code == '200' and sz > 500:
        ok += 1
        manifest.append({'url': u, 'file': fn, 'bytes': sz})
    else:
        fail += 1
        if os.path.exists(dest):
            os.remove(dest)

print('下载完成: 成功 %d, 失败 %d' % (ok, fail))
with io.open(os.path.join(OUT, '_manifest.json'), 'w', encoding='utf-8') as f:
    json.dump(manifest, f, ensure_ascii=False, indent=1)

# 4) 列出四格漫画
comics = sorted([m for m in manifest if re.search(r'/\d{3}_01\.(png|jpg)', m['url'])],
                key=lambda x: x['url'])
print()
print('=== 四格漫画 %d 张 ===' % len(comics))
for m in comics:
    print('  %-58s %8d' % (m['file'][-58:], m['bytes']))
