# 抓取官网角色页的语音试听与角色立绘
import io, os, re, sys, subprocess, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

PROXY = 'http://127.0.0.1:7897'
UA = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'
OUT = r'G:\project\其他\game\提取资源\网络资源\13_官网日服witchs-weapon.net'

def fetch(url, dest=None):
    cmd = ['curl.exe', '-sL', '-x', PROXY, '-m', '40', '-A', UA]
    if dest:
        cmd += ['-o', dest, '-w', '%{http_code}|%{size_download}']
    cmd.append(url)
    r = subprocess.run(cmd, capture_output=True, text=True, errors='replace')
    return r.stdout

c = io.open(os.path.join(OUT, 'character.html'), encoding='utf-8', errors='ignore').read()

# 找音频
audios = set()
for m in re.finditer(r'(?:src|href|data-src|data-voice)="([^"]+\.(?:mp3|ogg|wav|m4a))"', c, re.I):
    u = m.group(1)
    if u.startswith('/'):
        u = 'https://witchs-weapon.net' + u
    elif not u.startswith('http'):
        u = 'https://witchs-weapon.net/' + u.lstrip('./')
    audios.add(u)

print('找到 %d 个音频 URL' % len(audios))
for u in sorted(audios):
    print('  ' + u)

# 也扫描页面里所有可能的路径模式
print()
print('=== 页面中所有含 voice/character 的路径 ===')
paths = set()
for m in re.finditer(r'["\']([^"\']*(?:voice|character|chara)[^"\']*)["\']', c, re.I):
    p = m.group(1)
    if len(p) < 120 and not p.startswith('http') or 'witchs-weapon' in p:
        paths.add(p)
for p in sorted(paths)[:40]:
    print('  ' + p)

# 下载音频
if audios:
    adir = os.path.join(OUT, 'voice')
    os.makedirs(adir, exist_ok=True)
    ok = 0
    for u in sorted(audios):
        fn = re.sub(r'[^A-Za-z0-9._-]', '_', u.split('witchs-weapon.net/')[-1])
        dest = os.path.join(adir, fn)
        res = fetch(u, dest)
        print('  %-50s %s' % (fn[-50:], res))
        try:
            code, sz = res.split('|')
            if code == '200' and int(float(sz)) > 500:
                ok += 1
            elif os.path.exists(dest):
                os.remove(dest)
        except Exception:
            pass
    print('音频下载成功 %d' % ok)
