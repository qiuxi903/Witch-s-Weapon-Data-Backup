# 生成《魔女兵器》角色设定集（37 名角色完整档案）
import io, os, sys, re, json, csv, shutil

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
CFG  = os.path.join(R, '配置表_解密版', '怀旧服v128')
SITE = os.path.join(R, '提取资源', '网络资源', '13_官网日服witchs-weapon.net')
ART  = os.path.join(R, '美术素材_分类')
STORY= os.path.join(R, '剧情文本_解密版', '国服v2.0.1')
OUT  = os.path.join(R, '魔女兵器_角色设定集.html')
IMGD = os.path.join(R, 'assets', 'chara')
os.makedirs(IMGD, exist_ok=True)

def tsv(name):
    p = os.path.join(CFG, name + '.csv')
    return [l.rstrip('\n').rstrip('\r').split('\t') for l in io.open(p, encoding='utf-8', errors='replace')] if os.path.exists(p) else []

def csvr(name):
    p = os.path.join(CFG, name + '.csv')
    return list(csv.reader(io.open(p, encoding='utf-8', errors='replace'))) if os.path.exists(p) else []

# ---------- 1) dictionary：按 ID 建索引 ----------
dic = {}
for r in tsv('dictionary')[3:]:
    if len(r) >= 6 and r[0].strip():
        dic[r[0].strip()] = {'zh': r[1], 'tw': r[2], 'jp': r[3], 'kr': r[4], 'en': r[5]}

# ---------- 2) dictionarystatic：role* 映射 ----------
role = {}
for r in tsv('dictionarystatic')[2:]:
    if len(r) >= 2 and r[0].strip().startswith('role'):
        role[r[0].strip()] = r[1].strip()

# ---------- 3) servant：client_id -> sid ----------
srows = csvr('servant')
shdr = srows[0]
ci = shdr.index('client_id'); ii = shdr.index('ID')
cid2sid = {}
for r in srows[3:]:
    if len(r) > max(ci, ii):
        c = r[ci].strip(); s = r[ii].strip()
        if c and s: cid2sid.setdefault(c, s)

# ---------- 4) 按序配对 nameid ----------
nids = sorted(k for k, v in dic.items()
              if k.startswith('11101') and k.endswith('101') and v['zh'])
_sids = sorted(cid2sid.values())
SID2NID = dict(zip(_sids, nids))

# ---------- 5) 剧情台词统计 ----------
speak = {}
for f in sorted(os.listdir(STORY)):
    if not f.endswith('.txt'): continue
    for ln in io.open(os.path.join(STORY, f), encoding='utf-8').read().split('\n'):
        p = ln.split('\t')
        if len(p) >= 3 and p[1].strip():
            s = re.sub(r'^N/A@', '', p[1].strip())
            if s and len(s) <= 20:
                speak[s] = speak.get(s, 0) + 1

# ---------- 6) 美术 ----------
def scan(sub):
    d = os.path.join(ART, sub); out = []
    if os.path.isdir(d):
        for dp, dn, fn in os.walk(d):
            for f in fn:
                if f.lower().endswith(('.png', '.jpg', '.jpeg')): out.append(os.path.join(dp, f))
    return sorted(out)

cards = scan('01_角色卡面')
def stage(src, name):
    ext = os.path.splitext(src)[1].lower()
    dst = os.path.join(IMGD, name + ext)
    if not os.path.exists(dst):
        try: shutil.copy2(src, dst)
        except Exception: return ''
    return 'assets/chara/' + os.path.basename(dst)

# 官网角色（CV / 语音）
site = json.load(io.open(os.path.join(SITE, 'characters.json'), encoding='utf-8'))
IDX2NUM = {'01':'101','02':'102','03':'106','04':'104','05':'112','07':'129','08':'114',
           '09':'116','10':'127','11':'113','12':'120','13':'107','14':'108','15':'110'}
site_by_num = {}
for ch in site:
    n = IDX2NUM.get(ch['idx'])
    if n: site_by_num[n] = ch

# ---------- 7) 组装角色档案 ----------
chars = []
for cid, sid in sorted(cid2sid.items()):
    nid = SID2NID.get(sid)
    if not nid: continue
    base = nid[:-3]           # 11101000
    m = re.match(r'^1101(\d{4})$', cid)
    num = ('%03d' % (100 + int(m.group(1)[:2]))) if m else ''

    nm   = dic.get(base + '101', {})
    full = dic.get(base + '105', {})
    intro= dic.get(base + '106', {})
    wdesc= dic.get(base + '104', {})
    if not nm.get('zh'): continue

    # 卡面
    card = ''
    if num:
        for p in cards:
            b = os.path.basename(p)
            if re.search(r'Servant00_Image_%s(?!\d)' % num, b) and '_bg' not in b:
                card = stage(p, 'card_%s' % num); break
    # 官网
    s = site_by_num.get(num, {})
    voice = ''
    vp = os.path.join(SITE, 'voice', 'cv_%s.mp3' % s.get('idx', '')) if s else ''
    if s and os.path.exists(vp):
        voice = 'assets/chara/' + os.path.basename(stage(vp, 'cv_%s' % s['idx']))

    chars.append({
        'num': num, 'sid': sid, 'nid': nid,
        'zh': nm.get('zh',''), 'tw': nm.get('tw',''), 'jp': nm.get('jp',''),
        'kr': nm.get('kr',''), 'en': nm.get('en',''),
        'full_zh': full.get('zh',''), 'full_jp': full.get('jp',''), 'full_en': full.get('en',''),
        'intro_zh': intro.get('zh',''), 'intro_jp': intro.get('jp',''), 'intro_en': intro.get('en',''),
        'weapon': wdesc.get('zh',''),
        'card': card, 'voice': voice,
        'cv': s.get('cv',''), 'quote': s.get('quote',''),
        'lines': speak.get(nm.get('zh',''), 0),
    })

print('角色档案 %d 名' % len(chars))
print('  有卡面 %d, 有语音 %d, 有 CV %d, 有自我介绍 %d' % (
    sum(1 for c in chars if c['card']), sum(1 for c in chars if c['voice']),
    sum(1 for c in chars if c['cv']), sum(1 for c in chars if c['intro_zh'])))

json.dump(chars, io.open(os.path.join(R, '角色设定集.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)

# ---------- 8) HTML ----------
def esc(s):
    return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')
def br(s):
    return esc(s).replace('\\n', '<br>').replace('\n', '<br>')

blocks = []
for c in chars:
    img = ('<img src="%s" loading="lazy" alt="">' % c['card']) if c['card'] else '<div class="noimg">无立绘</div>'
    vo = ('<audio controls preload="none" src="%s"></audio>' % c['voice']) if c['voice'] else ''
    cv = ('<span class="cv">CV %s</span>' % esc(c['cv'])) if c['cv'] else ''
    q = ('<div class="q">%s</div>' % br(c['quote'])) if c['quote'] else ''
    intro = ('<div class="intro">%s</div>' % br(c['intro_zh'])) if c['intro_zh'] else ''
    intro_o = ''
    if c['intro_jp'] or c['intro_en']:
        intro_o = ('<details class="more"><summary>原文（日 / 英）</summary>'
                   + ('<div class="row"><b>日</b> %s</div>' % br(c['intro_jp']) if c['intro_jp'] else '')
                   + ('<div class="row"><b>英</b> %s</div>' % br(c['intro_en']) if c['intro_en'] else '')
                   + '</details>')
    wp = ('<div class="wp">武器：%s</div>' % esc(c['weapon'])) if c['weapon'] else ''
    full = c['full_zh'] if c['full_zh'] and c['full_zh'] != c['zh'] else ''
    blocks.append('''<article class="ch">
  <div class="pic">%s<div class="badge">%s</div></div>
  <div class="info">
    <h3>%s</h3>
    <div class="jp">%s</div>
    <div class="alt">%s · %s · %s</div>
    <div class="meta2">%s<span class="lines">台词 %d 句</span></div>
    %s%s%s%s
  </div>
</article>''' % (img, esc(c['num']), esc(c['zh']),
                 esc(full or c['jp']),
                 esc(c['en']), esc(c['kr']), esc(c['tw']),
                 cv, c['lines'], q, intro, intro_o, wp))

html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》角色设定集</title>
<style>
:root{--bg:#0f1116;--panel:#171a21;--panel2:#1e222b;--line:#2a2f3a;
--fg:#e6e3de;--dim:#8f96a3;--accent:#c9a227;--accent2:#7fb3d5}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);line-height:1.8;
font-family:"Noto Serif SC","Source Han Serif SC","Songti SC",serif}
header{padding:56px 48px 36px;border-bottom:1px solid var(--line);
background:linear-gradient(160deg,#1a1d26,#0f1116 70%)}
.eyebrow{font-size:11px;letter-spacing:.34em;color:var(--accent);margin-bottom:12px;
font-family:ui-monospace,monospace}
h1{font-size:38px;margin:0 0 8px;letter-spacing:.08em;font-weight:600}
.en{font-size:11.5px;letter-spacing:.3em;color:var(--dim);margin-bottom:18px;
font-family:ui-monospace,monospace}
.meta{font-size:13px;color:var(--dim);line-height:2}
.meta b{color:var(--fg)}
main{padding:36px 48px 80px;max-width:1560px}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(400px,1fr));gap:20px}
.ch{background:var(--panel);border:1px solid var(--line);border-radius:7px;
overflow:hidden;display:flex;flex-direction:column}
.pic{position:relative;background:#0b0d11;height:330px;display:flex;
align-items:center;justify-content:center;overflow:hidden}
.pic img{width:100%;height:100%;object-fit:cover;transition:transform .45s}
.ch:hover .pic img{transform:scale(1.06)}
.badge{position:absolute;top:10px;left:10px;background:rgba(15,17,22,.82);
border:1px solid var(--line);border-radius:3px;padding:2px 8px;font-size:11px;
color:var(--accent);font-family:ui-monospace,monospace}
.noimg{color:#3a4150;font-size:12px;font-family:ui-monospace,monospace}
.info{padding:16px 18px 20px;flex:1;display:flex;flex-direction:column}
.info h3{margin:0 0 3px;font-size:22px;color:var(--accent);letter-spacing:.04em;font-weight:600}
.jp{font-size:12.5px;color:var(--dim);font-family:ui-monospace,monospace;margin-bottom:5px}
.alt{font-size:11px;color:#6b7484;font-family:ui-monospace,monospace;margin-bottom:9px}
.meta2{display:flex;gap:10px;align-items:center;margin-bottom:10px;flex-wrap:wrap}
.cv{font-size:12px;color:var(--accent2)}
.lines{font-size:11px;color:#5f6674;font-family:ui-monospace,monospace}
.q{font-size:13.5px;color:#b8b0a2;font-style:italic;padding-left:11px;
border-left:2px solid var(--line);margin-bottom:10px}
.intro{font-size:14px;color:#d8d3ca;margin-bottom:9px}
.wp{font-size:11.5px;color:#6b7484;font-family:ui-monospace,monospace;margin-top:auto;padding-top:8px}
.more{font-size:11.5px;color:#6b7484;font-family:ui-monospace,monospace;margin-bottom:8px}
.more summary{cursor:pointer;color:#7f8797;list-style:none}
.more summary::-webkit-details-marker{display:none}
.more summary:hover{color:var(--accent2)}
.more .row{margin:5px 0 0;padding-left:10px;border-left:2px solid var(--line);color:#8d94a2}
audio{width:100%;height:32px;margin-bottom:10px}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}.grid{grid-template-columns:1fr}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / CHARACTER PROFILES</div>
<h1>《魔女兵器》角色设定集</h1>
<div class="en">CHARACTER PROFILES · __N__ ENTRIES</div>
<div class="meta">
<b>数据来源</b>：游戏配置表 <code>dictionary.csv</code>（五语名称 / 全名 / 自我介绍 / 武器描述）<br>
<b>立绘</b>：<code>Servant00_Image_*</code> AssetBundle 导出 · <b>CV 语音</b>：日服官网<br>
<b>台词统计</b>：解密剧情 16,687 行 · <b>语言</b>：简中 / 繁中 / 日 / 韩 / 英
</div></header>
<main><div class="grid">
__BODY__
</div></main>
<footer>
<b>《魔女兵器》角色设定集</b><br>
配置表解密：XOR 0xFF · 游戏开发：北京水琴铃（WaterBell）· 日服发行：EXNOA LLC<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer></body></html>'''

html = html.replace('__N__', str(len(chars))).replace('__BODY__', '\n'.join(blocks))
io.open(OUT, 'w', encoding='utf-8').write(html)
print('已生成: %s (%.2f MB)' % (OUT, os.path.getsize(OUT) / 1024 / 1024))
