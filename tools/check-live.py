# 线上站点引用体检：把 12 个页面抓下来，抽出全部静态引用，逐个发请求看状态码
#
#   python tools/check-live.py https://witchweapon.hutaomu.cn
#   python tools/check-live.py https://witchweapon.hutaomu.cn --sample 40   # 每页抽样
#
# 只发 HEAD（带 Range: bytes=0-0），不下载正文，对服务器压力很小。
import collections, concurrent.futures as cf, io, re, sys, time
import urllib.error, urllib.parse, urllib.request

BASE = (sys.argv[1] if len(sys.argv) > 1 else '').rstrip('/')
if not BASE:
    print('用法: python tools/check-live.py <站点根URL> [--sample N]')
    sys.exit(2)
SAMPLE = 0
if '--sample' in sys.argv:
    SAMPLE = int(sys.argv[sys.argv.index('--sample') + 1])
CONC = 12
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

PAGES = ['index.html', 'story.html', 'characters.html', 'art.html',
         'manga.html', 'audio.html', 'video.html', 'config.html',
         'system.html', 'news.html', 'relics.html', 'archive.html']

URL_ATTR = re.compile(
    r'\b(src|href|data-src|data-full|poster|data-poster|data-orig)\s*=\s*"([^"]*)"',
    re.I)
CSSURL = re.compile(r'(?<![A-Za-z])url\(\s*[\'"]?([^\'")]+)[\'"]?\s*\)', re.I)
SKIP = ('http://', 'https://', '//', 'data:', 'mailto:', 'javascript:',
        '#', 'about:', 'blob:')


def fetch(url, timeout=30):
    req = urllib.request.Request(url, headers={'User-Agent': 'Mozilla/5.0'})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        return r.read().decode('utf-8', 'replace')


def probe(url, retries=2):
    """返回 (状态码, 内容类型)；只取前 1 字节。
    跑上万个请求时偶发超时/连接重置很正常，重试几次再判失败。"""
    last = ('ERR', 'unknown')
    for attempt in range(retries + 1):
        req = urllib.request.Request(
            url, method='GET',
            headers={'User-Agent': 'Mozilla/5.0', 'Range': 'bytes=0-0'})
        try:
            with urllib.request.urlopen(req, timeout=25) as r:
                return r.status, (r.headers.get('Content-Type') or '')
        except urllib.error.HTTPError as e:
            # 4xx/5xx 是服务器的明确答复，不重试
            return e.code, (e.headers.get('Content-Type') if e.headers else '')
        except Exception as e:
            last = ('ERR', type(e).__name__)
            if attempt < retries:
                time.sleep(1.5 * (attempt + 1))
    return last


def norm(u):
    u = u.strip()
    if not u or u.startswith(SKIP):
        return None
    u = u.split('#')[0].split('?')[0]
    if not u or any(c in u for c in "'+ ") or u.endswith('+') or '{' in u:
        return None
    if u.startswith('/'):
        return BASE + u
    return BASE + '/' + u


def main():
    t0 = time.time()
    per_page = {}
    all_urls = {}
    print('=== 抓取页面 ===')
    for p in PAGES:
        try:
            txt = fetch(BASE + '/' + p)
        except Exception as e:
            print('  !! %-16s 抓取失败 %s' % (p, e))
            per_page[p] = []
            continue
        urls = [m.group(2) for m in URL_ATTR.finditer(txt)]
        for m in CSSURL.finditer(txt):
            urls.append(m.group(1))
        normed = []
        seen = set()
        for u in urls:
            a = norm(u)
            if a and a not in seen:
                seen.add(a)
                normed.append(a)
        per_page[p] = normed
        for a in normed:
            all_urls[a] = None
        print('  %-16s %6d 处引用（去重后 %d）' % (p, len(urls), len(normed)))

    targets = list(all_urls)
    if SAMPLE:
        # 按页均匀抽样
        picked = []
        for p, lst in per_page.items():
            step = max(1, len(lst) // SAMPLE)
            picked += lst[::step][:SAMPLE]
        targets = sorted(set(picked))
    print()
    print('=== 探测 %d 个 URL（并发 %d，HEAD+Range 1 字节）===' % (len(targets), CONC))

    results = {}
    done = 0
    with cf.ThreadPoolExecutor(max_workers=CONC) as ex:
        futs = {ex.submit(probe, u): u for u in targets}
        for f in cf.as_completed(futs):
            u = futs[f]
            results[u] = f.result()
            done += 1
            if done % 500 == 0:
                print('    %d / %d  %.0f 秒' % (done, len(targets), time.time() - t0))

    # 汇总
    codes = collections.Counter(c for c, _ in results.values())
    print()
    print('=== 状态码分布 ===')
    for c, n in codes.most_common():
        print('  %-6s %6d' % (c, n))

    print()
    print('=== 按页面统计坏引用 ===')
    total_bad = 0
    for p in PAGES:
        lst = per_page.get(p, [])
        probed = [u for u in lst if u in results]
        if not probed:
            print('  %-16s （未探测）' % p)
            continue
        bad = [u for u in probed if results[u][0] not in (200, 206)]
        total_bad += len(bad)
        flag = 'OK  ' if not bad else 'BAD '
        print('  %s %-16s 探测 %5d / 引用 %5d   坏 %5d' %
              (flag, p, len(probed), len(lst), len(bad)))

    # 坏引用按目录分组，找出规律
    bad_all = collections.Counter()
    bad_examples = {}
    for u, (c, ct) in results.items():
        if c in (200, 206):
            continue
        path = urllib.parse.unquote(urllib.parse.urlparse(u).path)
        parts = [x for x in path.split('/') if x]
        key = '/'.join(parts[:2]) if len(parts) >= 2 else '/'.join(parts)
        bad_all[key] += 1
        bad_examples.setdefault(key, (u, c))

    print()
    print('=== 坏引用按路径前缀分组（Top 20）===')
    for k, n in bad_all.most_common(20):
        u, c = bad_examples[k]
        print('  %-40s %6d 个   (例 %s → %s)' % (k, n, c,
              urllib.parse.unquote(urllib.parse.urlparse(u).path)[:70]))

    # 好引用按前缀分组，做对照
    good_all = collections.Counter()
    for u, (c, ct) in results.items():
        if c not in (200, 206):
            continue
        path = urllib.parse.unquote(urllib.parse.urlparse(u).path)
        parts = [x for x in path.split('/') if x]
        key = '/'.join(parts[:2]) if len(parts) >= 2 else '/'.join(parts)
        good_all[key] += 1
    print()
    print('=== 正常引用按路径前缀分组（Top 12）===')
    for k, n in good_all.most_common(12):
        print('  %-40s %6d 个' % (k, n))

    # 关键结论：路径里含非 ASCII 的引用，成功率
    nonascii = [(u, results[u]) for u in results
                if any(ord(ch) > 127 for ch in
                       urllib.parse.unquote(urllib.parse.urlparse(u).path))]
    ascii_ = [(u, results[u]) for u in results
              if not any(ord(ch) > 127 for ch in
                         urllib.parse.unquote(urllib.parse.urlparse(u).path))]
    def rate(lst):
        ok = sum(1 for _, (c, _) in lst if c in (200, 206))
        return ok, len(lst)
    print()
    print('=== 关键对照：路径是否含非 ASCII 字符 ===')
    o, n = rate(nonascii)
    print('  含中文/特殊字符的引用： %5d / %5d 可访问' % (o, n))
    o2, n2 = rate(ascii_)
    print('  纯 ASCII 路径的引用：   %5d / %5d 可访问' % (o2, n2))

    # 按扩展名
    ext_bad = collections.Counter()
    ext_ok = collections.Counter()
    for u, (c, ct) in results.items():
        e = (urllib.parse.unquote(urllib.parse.urlparse(u).path)
             .rsplit('.', 1)[-1].lower() if '.' in u else '(无)')
        (ext_ok if c in (200, 206) else ext_bad)[e] += 1
    print()
    print('=== 按扩展名 ===')
    print('  %-8s %8s %8s' % ('扩展名', '正常', '坏'))
    for e in sorted(set(ext_ok) | set(ext_bad),
                    key=lambda x: -(ext_ok[x] + ext_bad[x]))[:14]:
        print('  %-8s %8d %8d' % (e, ext_ok[e], ext_bad[e]))

    print()
    print('  总耗时 %.0f 秒' % (time.time() - t0))
    return 0


if __name__ == '__main__':
    sys.exit(main())
