# 官网公告页 v3 —— 从 php 提取标题/日期/正文
import io, os, sys, re, html as H

sys.path.insert(0, r'G:\project\其他\game\tools')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')
from site_lib import (R, SITE, ASSETS, page, U, T, esc, fmt, find_image)

BASE = '02_客户端解包/网络资源/05_文本/官网公告/'


def strip_tags(s):
    s = re.sub(r'<script.*?</script>', ' ', s, flags=re.S | re.I)
    s = re.sub(r'<style.*?</style>', ' ', s, flags=re.S | re.I)
    s = re.sub(r'<br\s*/?>', '\n', s, flags=re.I)
    s = re.sub(r'</(p|div|li|h\d)>', '\n', s, flags=re.I)
    s = re.sub(r'<[^>]+>', ' ', s)
    s = H.unescape(s)
    s = re.sub(r'[ \t\u3000]+', ' ', s)
    s = re.sub(r'\n\s*\n+', '\n', s)
    return s.strip()


def parse(fp):
    raw = io.open(fp, 'rb').read()
    for enc in ('utf-8', 'cp932', 'shift_jis', 'euc-jp'):
        try:
            t = raw.decode(enc)
            break
        except Exception:
            t = raw.decode('utf-8', 'replace')
    title = ''
    m = re.search(r'<h1[^>]*>(.*?)</h1>', t, re.S | re.I)
    if m:
        title = strip_tags(m.group(1))
    if not title or title.strip().upper() == 'NEWS':
        m = re.search(r'<title>(.*?)</title>', t, re.S | re.I)
        if m:
            title = strip_tags(m.group(1)).replace('| Witch’s Weapon -魔女兵器-', '').strip()
    date = ''
    m = re.search(r'(\d{4})[年/\.\-](\d{1,2})[月/\.\-](\d{1,2})', t)
    if m:
        date = '%s-%02d-%02d' % (m.group(1), int(m.group(2)), int(m.group(3)))
    # 正文：取 main / article / body
    body = ''
    m = re.search(r'<main[^>]*>(.*?)</main>', t, re.S | re.I)
    if not m:
        m = re.search(r'<article[^>]*>(.*?)</article>', t, re.S | re.I)
    if not m:
        m = re.search(r'<body[^>]*>(.*?)</body>', t, re.S | re.I)
    if m:
        body = strip_tags(m.group(1))
    # 去掉导航噪声
    body = re.sub(r'^(NEWS|TOP|CHARACTER|STORY|MOVIE|SPECIAL|Twitter|Facebook)\s*', '', body)
    return title, date, body


def build():
    items = sorted([a for a in ASSETS
                    if a['p'].startswith(BASE) and a['p'].endswith('.php')],
                   key=lambda x: x['p'])
    news = []
    for a in items:
        fp = os.path.join(R, a['p'].replace('/', os.sep))
        try:
            title, date, body = parse(fp)
        except Exception:
            continue
        kind = '维护' if 'maintenance' in os.path.basename(a['p']) else '公告'
        news.append({'file': a['p'], 'name': os.path.basename(a['p']),
                     'title': title or os.path.basename(a['p']),
                     'date': date, 'body': body, 'kind': kind, 'size': a['b']})
    # 按日期倒序
    news.sort(key=lambda x: (x['date'] or '', x['name']), reverse=True)

    cards = []
    for i, n in enumerate(news):
        body = n['body']
        more = ''
        if len(body) > 300:
            more = ('<details><summary>展开全文</summary>'
                    '<div class="in" style="white-space:pre-wrap">%s</div></details>'
                    % esc(body))
            body = body[:300] + '…'
        cards.append(
            '<div class="card" style="animation-delay:%dms">'
            '<div class="body">'
            '<div class="sub" style="display:flex;gap:12px;align-items:center">'
            '<span class="ctag" style="font-size:11px;padding:3px 10px;'
            'border-radius:100px;background:rgba(79,216,232,.13);'
            'border:1px solid rgba(79,216,232,.32);color:var(--cyan)">%s</span>'
            '<span class="mono">%s</span></div>'
            '<div class="ttl" style="font-size:16px;line-height:1.5">%s</div>'
            '<div class="sub" style="white-space:pre-wrap;line-height:1.8">%s</div>'
            '%s'
            '</div></div>'
            % (min(i * 18, 600), esc(n['kind']), esc(n['date'] or '—'),
               esc(n['title']), esc(body), more))

    body = ('<section class="rv"><h2 class="sec">官网公告</h2>'
            '<div class="cnt">%d 条 · 日服官网存档 · 按日期倒序</div>'
            '<div class="grid g2">%s</div></section>'
            % (len(news), ''.join(cards)))
    meta = ('<b>官网公告</b>：%d 条 · 日文原文<br>'
            '<b>来源</b>：witchs-weapon.net 官网存档' % len(news))
    html = page('news.html', '官网公告', "WITCH'S WEAPON / NEWS",
                'NEWS · %d ITEMS' % len(news), meta, body)
    p = os.path.join(SITE, 'news.html')
    io.open(p, 'w', encoding='utf-8').write(html)
    print('  news.html  %s  (%d 条)' % (fmt(os.path.getsize(p)), len(news)))


build()
