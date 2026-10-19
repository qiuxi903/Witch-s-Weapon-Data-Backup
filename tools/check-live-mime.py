# 线上站点 MIME 体检：把部署目录里出现的每种扩展名挑一个代表文件，实测 Content-Type
#
#   python tools/check-live-mime.py https://witchweapon.hutaomu.cn
#
# 会顺带检查缓存头（Cache-Control / Expires），并标出与期望值不符的扩展名。
import os, sys, urllib.error, urllib.parse, urllib.request

if len(sys.argv) < 2:
    print('用法: python tools/check-live-mime.py <站点根URL>')
    sys.exit(2)
BASE = sys.argv[1].rstrip('/')
SRC = r'G:\project\其他\game\部署'
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# 期望的 MIME（None 表示没有通用标准，不做判定）
EXPECT = {
    '.html': 'text/html', '.htm': 'text/html',
    '.css': 'text/css',
    '.js': 'application/javascript', '.mjs': 'application/javascript',
    '.json': 'application/json',
    '.webp': 'image/webp', '.png': 'image/png',
    '.jpg': 'image/jpeg', '.jpeg': 'image/jpeg',
    '.gif': 'image/gif', '.svg': 'image/svg+xml',
    '.ogg': 'audio/ogg', '.oga': 'audio/ogg', '.opus': 'audio/ogg',
    '.mp3': 'audio/mpeg', '.wav': 'audio/x-wav', '.m4a': 'audio/mp4',
    '.mp4': 'video/mp4', '.ogv': 'video/ogg', '.webm': 'video/webm',
    '.zip': 'application/zip', '.gz': 'application/gzip',
    '.md': 'text/markdown', '.txt': 'text/plain',
    '.xml': 'application/xml', '.csv': 'text/csv',
    '.woff2': 'font/woff2', '.woff': 'font/woff',
    '.ico': 'image/x-icon',
}
# 这些扩展名本来就该长缓存
LONG_CACHE = {'.webp', '.png', '.jpg', '.jpeg', '.gif', '.svg', '.ico',
              '.mp4', '.ogv', '.webm', '.ogg', '.oga', '.opus', '.mp3',
              '.wav', '.m4a', '.zip'}


def probe(rel):
    url = BASE + '/' + '/'.join(
        urllib.parse.quote(x, safe='') for x in rel.split('/'))
    req = urllib.request.Request(
        url, headers={'User-Agent': 'Mozilla/5.0', 'Range': 'bytes=0-0'})
    try:
        with urllib.request.urlopen(req, timeout=25) as r:
            h = {k.lower(): v for k, v in r.headers.items()}
            return (r.status, h.get('content-type', ''),
                    h.get('cache-control', ''), h.get('expires', ''))
    except urllib.error.HTTPError as e:
        return e.code, '', '', ''
    except Exception as e:
        return 'ERR:' + type(e).__name__, '', '', ''


def main():
    byext = {}
    for dp, dns, fs in os.walk(SRC):
        for f in fs:
            e = os.path.splitext(f)[1].lower()
            rel = os.path.relpath(os.path.join(dp, f), SRC).replace(os.sep, '/')
            byext.setdefault(e, []).append(rel)

    print('=== 部署目录里出现的全部扩展名，逐个实测 ===')
    print('  %-8s %7s %-6s %-30s %-24s %-8s %s'
          % ('扩展名', '文件数', '状态', 'Content-Type', 'Cache-Control',
             'Expires', '判定'))
    mime_bad = []
    cache_bad = []
    cache_soft = []
    for e in sorted(byext, key=lambda x: -len(byext[x])):
        rel = sorted(byext[e])[0]
        s, ct, cc, ex = probe(rel)
        exp = EXPECT.get(e)
        if s not in (200, 206):
            verdict = '!! 状态异常'
        elif exp is None:
            verdict = '(无参考标准)'
        elif ct == exp:
            verdict = 'OK'
        else:
            verdict = '!! 应为 %s' % exp
            mime_bad.append((e, ct, exp, len(byext[e])))
        if e in LONG_CACHE and 'max-age' not in cc and not ex:
            cache_bad.append((e, cc or '(无)', len(byext[e])))
        elif e in LONG_CACHE and 'max-age' not in cc and ex:
            # add_header Cache-Control 会顶掉 expires 生成的 max-age，
            # 但只要 Expires 在，新鲜度仍然成立（RFC 9111 §5.3），可以接受
            cache_soft.append((e, cc, len(byext[e])))
        print('  %-8s %7d %-6s %-30s %-24s %-8s %s'
              % (e or '(无)', len(byext[e]), s, ct or '-',
                 cc or '(无)', '有' if ex else '(无)', verdict))

    print()
    if mime_bad:
        print('=== MIME 不对的扩展名 ===')
        for e, ct, exp, n in mime_bad:
            print('  %-8s 现在 %-28s 应为 %-18s 影响 %d 个文件'
                  % (e, ct, exp, n))
        print()
        print('  修法（宝塔 → 网站 → 设置 → 配置文件，加在 server { } 里）：')
        print('    include /www/server/nginx/conf/mime.types;')
        print('    types {')
        for e, ct, exp, n in mime_bad:
            print('        %-16s %s;' % (exp, e.lstrip('.')))
        print('    }')
        print('  ⚠️ 改完必须回头确认 .css / .webp 等没被带成 application/octet-stream')
    else:
        print('  ✓ 所有扩展名的 MIME 都正确')

    print()
    if cache_bad:
        print('=== 缺长缓存的扩展名 ===')
        for e, cc, n in cache_bad:
            print('  %-8s Cache-Control: %-20s 影响 %d 个文件' % (e, cc, n))
    else:
        print('  ✓ 该长缓存的扩展名都有缓存头')

    if cache_soft:
        print()
        print('=== 缓存头可以再规范一点（不影响功能）===')
        for e, cc, n in cache_soft:
            print('  %-8s Cache-Control: %-24s 影响 %d 个文件' % (e, cc, n))
        print('  现在靠 Expires 提供新鲜度，是有效的（RFC 9111 §5.3）；')
        print('  但 add_header 顶掉了 expires 生成的 max-age，写成下面这样更标准：')
        print('    add_header Cache-Control "public, max-age=2592000, immutable";')

    return 1 if (mime_bad or cache_bad) else 0


if __name__ == '__main__':
    sys.exit(main())
