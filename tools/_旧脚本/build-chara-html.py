# 生成《魔女兵器》角色图鉴 HTML（最终版）
import io, os, sys, re, json, shutil, csv

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

CFG  = r'G:\project\其他\game\配置表_解密版\怀旧服v128'
SITE = r'G:\project\其他\game\提取资源\网络资源\13_官网日服witchs-weapon.net'
ART  = r'G:\project\其他\game\美术素材_分类'
OUT  = r'G:\project\其他\game\魔女兵器_角色图鉴.html'
IMGD = r'G:\project\其他\game\assets\chara'
os.makedirs(IMGD, exist_ok=True)

def tsv(name):
    p = os.path.join(CFG, name + '.csv')
    return [l.rstrip('\n').rstrip('\r').split('\t') for l in io.open(p, encoding='utf-8', errors='replace')] if os.path.exists(p) else []

def csvr(name):
    p = os.path.join(CFG, name + '.csv')
    return list(csv.reader(io.open(p, encoding='utf-8', errors='replace'))) if os.path.exists(p) else []

# 名称表
names = {}
for r in tsv('dictionary')[3:]:
    if len(r) >= 6 and r[0].strip():
        names[r[0].strip()] = {'zh': r[1], 'tw': r[2], 'jp': r[3], 'kr': r[4], 'en': r[5]}

# 主角名
SPECIAL = {'レン': ('小怜','小憐','レン','렌','Ren'), 'マリル・フォン・ブラウン': ('莉琉','莉琉','マリル','마리루','Mariru')}

# servant 表：client_id -> 英灵ID
srows = csvr('servant')
shdr = srows[0]
ci = shdr.index('client_id'); ii = shdr.index('ID')
cid2sid = {}
for r in srows[3:]:
    if len(r) > max(ci, ii):
        c = r[ci].strip(); s = r[ii].strip()
        if c and s: cid2sid.setdefault(c, s)

# 英灵ID -> 名称：按序配对（servant 47 个 sid 与 dictionary 37 个 nameid 顺序一致）
_rows = tsv('dictionary')
nids = sorted(r[0].strip() for r in _rows[3:]
              if len(r) >= 6 and r[0].strip().startswith('11101') and r[0].strip().endswith('101'))
_sids = sorted(cid2sid.values())
SID2NAMEID = dict(zip(_sids, nids))

def sid2nameid(sid):
    return SID2NAMEID.get(sid)

# 美术
def scan(sub):
    d = os.path.join(ART, sub); out = []
    if os.path.isdir(d):
        for dp, dn, fn in os.walk(d):
            for f in fn:
                if f.lower().endswith(('.png','.jpg','.jpeg')): out.append(os.path.join(dp, f))
    return sorted(out)

cards = scan('01_角色卡面')

def stage(src, name):
    ext = os.path.splitext(src)[1].lower()
    dst = os.path.join(IMGD, name + ext)
    if not os.path.exists(dst):
        try: shutil.copy2(src, dst)
        except Exception: return ''
    return 'assets/chara/' + os.path.basename(dst)

# 官网角色
site_chars = json.load(io.open(os.path.join(SITE, 'characters.json'), encoding='utf-8'))

# 构建 47 名英灵 —— 用 servant 表的 client_id 直接对应卡面编号
roster = []
for cid, sid in sorted(cid2sid.items()):
    nid = sid2nameid(sid)
    nm = names.get(nid, {}) if nid else {}
    # client_id 形如 11010001 -> 卡面编号 100；11010201 -> 102
    m = re.match(r'^1101(\d{4})$', cid)
    num = ('%03d' % (100 + int(m.group(1)[:2]))) if m else ''
    card = ''
    if num:
        for p in cards:
            b = os.path.basename(p)
            if re.search(r'Servant00_Image_%s(?!\d)' % num, b) and '_bg' not in b:
                card = stage(p, 'card_%s' % num); break
    roster.append({
        'cid': cid, 'sid': sid, 'num': num,
        'zh': nm.get('zh',''), 'tw': nm.get('tw',''), 'jp': nm.get('jp',''),
        'kr': nm.get('kr',''), 'en': nm.get('en',''), 'card': card,
    })

# 官网 14 名（含 CV / 语音 / 台词）
site_by_num = {}
for ch in site_chars:
    # 官网 idx -> 卡面编号
    IDX2NUM = {'01':'101','02':'102','03':'106','04':'104','05':'112','07':'129',
               '08':'114','09':'116','10':'127','11':'113','12':'120','13':'107',
               '14':'108','15':'110'}
    n = IDX2NUM.get(ch['idx'])
    if n: site_by_num[n] = ch
    vp = os.path.join(SITE, 'voice', 'cv_%s.mp3' % ch['idx'])
    ch['voice'] = ('assets/chara/' + os.path.basename(stage(vp, 'cv_%s' % ch['idx']))) if os.path.exists(vp) else ''

for r in roster:
    s = site_by_num.get(r['num'])
    if s:
        r['cv'] = s.get('cv',''); r['quote'] = s.get('quote','')
        r['jp_full'] = s.get('name',''); r['voice'] = s.get('voice','')
        if not r['zh']:
            sp = SPECIAL.get(s.get('name',''))
            if sp:
                r['zh'], r['tw'], r['jp'], r['kr'], r['en'] = sp
    else:
        r['cv'] = ''; r['quote'] = ''; r['jp_full'] = ''; r['voice'] = ''

print('英灵 %d 名, 有卡面 %d, 有 CV %d, 有语音 %d' % (
    len(roster), sum(1 for r in roster if r['card']),
    sum(1 for r in roster if r['cv']), sum(1 for r in roster if r.get('voice'))))

json.dump(roster, io.open(os.path.join(SITE, 'roster.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)

# ---------- 生成 HTML ----------
def esc(s): return (s or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;')

cards_html = []
for r in roster:
    img = ('<img src="%s" loading="lazy" alt="">' % r['card']) if r['card'] else \
          '<div class="noimg">无立绘</div>'
    cv = ('<div class="cv">CV <b>%s</b></div>' % esc(r['cv'])) if r['cv'] else ''
    q = ('<div class="q">%s</div>' % esc(r['quote'])) if r['quote'] else ''
    vo = ('<audio controls preload="none" src="%s"></audio>' % r['voice']) if r.get('voice') else ''
    cards_html.append('''<article class="ch">
  <div class="pic">%s</div>
  <div class="info">
    <h3>%s</h3>
    <div class="jp">%s</div>
    <div class="alt">%s · %s · %s</div>
    %s%s%s
  </div>
</article>''' % (img, esc(r['zh'] or r['jp'] or r['en']), esc(r['jp_full'] or r['jp']),
                 esc(r['en']), esc(r['kr']), esc(r['tw']), cv, q, vo))

html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》角色图鉴</title>
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
main{padding:36px 48px 80px;max-width:1500px}
.grid{display:grid;grid-template-columns:repeat(auto-fill,minmax(340px,1fr));gap:18px}
.ch{background:var(--panel);border:1px solid var(--line);border-radius:6px;
overflow:hidden;display:flex;flex-direction:column}
.pic{background:#0b0d11;height:300px;display:flex;align-items:center;justify-content:center;overflow:hidden}
.pic img{width:100%;height:100%;object-fit:cover;transition:transform .4s}
.ch:hover .pic img{transform:scale(1.05)}
.noimg{color:#3a4150;font-size:12px;font-family:ui-monospace,monospace}
.info{padding:14px 16px 18px}
.info h3{margin:0 0 3px;font-size:19px;color:var(--accent);letter-spacing:.04em;font-weight:600}
.jp{font-size:12px;color:var(--dim);font-family:ui-monospace,monospace;margin-bottom:6px}
.alt{font-size:11px;color:#6b7484;font-family:ui-monospace,monospace;margin-bottom:10px}
.cv{font-size:12px;color:var(--accent2);margin-bottom:6px}
.cv b{color:#cfe4f5;font-weight:600}
.q{font-size:13px;color:#b8b0a2;font-style:italic;padding-left:10px;
border-left:2px solid var(--line);margin-bottom:10px}
audio{width:100%;height:32px;margin-top:4px}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}.grid{grid-template-columns:1fr}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / CHARACTERS</div>
<h1>《魔女兵器》角色图鉴</h1>
<div class="en">CHARACTER ARCHIVE · __COUNT__ ENTRIES</div>
<div class="meta">
<b>数据来源</b>：游戏客户端配置表 <code>servant.csv</code> + <code>dictionary.csv</code>（已解密）<br>
<b>立绘</b>：游戏内 <code>Servant00_Image_*</code> AssetBundle 导出<br>
<b>CV 与语音</b>：日服官网 <code>witchs-weapon.net/character/</code><br>
<b>语言</b>：简中 / 繁中 / 日 / 韩 / 英
</div></header>
<main><div class="grid">
__CARDS__
</div></main>
<footer>
<b>《���女兵器》角色图鉴</b><br>
配置表解密方式：XOR 0xFF（详见 <code>剧情文本加密分析报告.md</code>）<br>
游戏开发：北京水琴铃（WaterBell）· 日服发行：EXNOA LLC<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer></body></html>'''

html = html.replace('__COUNT__', str(len(roster))).replace('__CARDS__', '\n'.join(cards_html))

io.open(OUT, 'w', encoding='utf-8').write(html)
print('已生成: %s (%.2f MB)' % (OUT, os.path.getsize(OUT)/1024/1024))
