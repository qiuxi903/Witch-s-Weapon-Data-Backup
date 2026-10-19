# 抓取官网 /cartoon/ 与 /news/ 剩余栏目
import io, os, sys, re, time, subprocess, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
BASE = os.path.join(R, '提取资源', '网络资源', '13_官网日服witchs-weapon.net')
OUT  = os.path.join(BASE, 'cartoon')
os.makedirs(OUT, exist_ok=True)
PROXY = 'http://127.0.0.1:7897'

def fetch(url, timeout=25):
    try:
        r = subprocess.run(['curl.exe', '-sL', '-x', PROXY, '--max-time', str(timeout),
                            '-w', '\n@@CODE@@%{http_code}', url],
                           capture_output=True, timeout=timeout + 15)
        out = r.stdout.decode('utf-8', 'replace')
        i = out.rfind('@@CODE@@')
        if i < 0: return None, 0
        return out[:i], int(out[i + 8:].strip() or 0)
    except Exception:
        return None, 0

# ---------- 1) 探测 /cartoon/ 全部 ID ----------
print('=== 探测 /cartoon/ ===')
found = []
for i in list(range(1, 60)) + list(range(100, 3000, 1)):
    pass  # 太慢，改用区间采样

# 先采样确定范围
sample = list(range(800, 1000, 10)) + list(range(1000, 1300, 10)) + \
         list(range(1700, 2300, 10))
alive = []
for i in sample:
    url = 'https://witchs-weapon.net/cartoon/%d.php' % i
    _, code = fetch(url, 12)
    if code == 200:
        alive.append(i)
print('  采样命中 %d 个: %s' % (len(alive), alive[:30]))

if not alive:
    print('  未发现 /cartoon/ 内容，跳过')
    sys.exit(0)

# ---------- 2) 在命中点附近细扫 ----------
cand = set()
for a in alive:
    for d in range(-12, 13):
        cand.add(a + d)
cand = sorted(c for c in cand if c > 0)
print('  细扫 %d 个候选' % len(cand))

ok = []
for i in cand:
    url = 'https://witchs-weapon.net/cartoon/%d.php' % i
    p = os.path.join(OUT, '%d.php' % i)
    if os.path.exists(p) and os.path.getsize(p) > 500:
        ok.append(i); continue
    body, code = fetch(url, 15)
    if code == 200 and body and len(body) > 500:
        io.open(p, 'w', encoding='utf-8').write(body)
        ok.append(i)
        print('    + %d (%d 字节)' % (i, len(body)))
    time.sleep(0.12)

print()
print('已抓 /cartoon/ %d 个' % len(ok))

# ---------- 3) 保存清单 ----------
man = [{'id': i, 'url': 'https://witchs-weapon.net/cartoon/%d.php' % i,
        'bytes': os.path.getsize(os.path.join(OUT, '%d.php' % i))} for i in ok]
json.dump(man, io.open(os.path.join(OUT, '_manifest.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
print('清单已保存')
