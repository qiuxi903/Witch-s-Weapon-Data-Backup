# 生成《魔女兵器》剧情 + 美术 图文电子书（带插图）
import io, os, sys, re, html, json, base64, random

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

STORY = r'G:\project\其他\game\剧情文本_解密版\国服v2.0.1'
ART   = r'G:\project\其他\game\美术素材_分类'
OUT   = r'G:\project\其他\game\魔女兵器_剧情图鉴.html'
IMGDIR= r'G:\project\其他\game\assets\img'
os.makedirs(IMGDIR, exist_ok=True)

# 收集插图候选（角色卡面 / 加载图 / 官方壁纸）
def collect(d, pats, limit=None):
    out = []
    if not os.path.isdir(d):
        return out
    for dp, dn, fn in os.walk(d):
        for f in fn:
            if f.lower().endswith(('.png', '.jpg', '.jpeg')):
                out.append(os.path.join(dp, f))
    out.sort()
    return out[:limit] if limit else out

cands = {}
for name, sub, lim in [
    ('card',   '01_角色卡面', 40),
    ('load',   '04_加载图',   30),
    ('wall',   '18_官方壁纸', 27),
    ('event',  '05_活动图',   40),
    ('bg',     '07_背景场景', 30),
]:
    cands[name] = collect(os.path.join(ART, sub), None, lim)
    print('%-8s %d 张' % (name, len(cands[name])))

# 复制图片到 assets/img 并生成相对路径
def stage(paths, prefix):
    rels = []
    for i, p in enumerate(paths):
        ext = os.path.splitext(p)[1].lower()
        dst = os.path.join(IMGDIR, '%s_%03d%s' % (prefix, i, ext))
        if not os.path.exists(dst):
            try:
                import shutil
                shutil.copy2(p, dst)
            except Exception:
                continue
        rels.append('assets/img/' + os.path.basename(dst))
    return rels

staged = {}
for k, v in cands.items():
    staged[k] = stage(v, k)
    print('  staged %-8s %d' % (k, len(staged[k])))

# 收集剧情
files = sorted(f for f in os.listdir(STORY) if f.endswith('.txt'))
entries = []
for f in files:
    m = re.match(r'sentence_(\d+)\.txt$', f)
    if not m: continue
    num = int(m.group(1))
    c = io.open(os.path.join(STORY, f), encoding='utf-8').read()
    lines = [l for l in c.split('\n') if l.strip()]
    if lines:
        entries.append({'file': f, 'num': num, 'lines': lines})

def chapter_of(num):
    if num < 10000: return ('序章 · 系统与引导', 'sys')
    n = num // 10000
    if n == 1: return ('第一章 · 人生的终结、命运的开始', 'ch1')
    if n == 2: return ('第二章 · 想守护的她、被守护的你', 'ch2')
    if n == 3:
        if num >= 31000: return ('活动剧情', 'event')
        return ('第三章 · 神魂的治愈、身体的诅咒', 'ch3')
    if n == 4: return ('支线剧情', 'side')
    return ('测试与其它', 'misc')

from collections import OrderedDict
groups = OrderedDict()
for e in entries:
    t, k = chapter_of(e['num'])
    groups.setdefault((t, k), []).append(e)

def parse_line(ln):
    p = ln.split('\t')
    if len(p) >= 3:
        return p[0].strip(), p[1].strip(), p[2].strip(), [x for x in p[3:] if x.strip()]
    return '', '', ln, []

def esc(s):
    return html.escape(s).replace('\\n', '<br>')

TOTAL_LINES = sum(len(e['lines']) for e in entries)

out = []
out.append('''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》剧情图鉴</title>
<style>
:root{
  --bg:#0f1116; --panel:#171a21; --panel2:#1e222b; --line:#2a2f3a;
  --fg:#e6e3de; --dim:#8f96a3; --accent:#c9a227; --accent2:#7fb3d5;
  --spk:#8fb8d8; --nar:#a89f8c;
}
*{box-sizing:border-box}
html{scroll-behavior:smooth}
body{margin:0;background:var(--bg);color:var(--fg);
  font-family:"Noto Serif SC","Source Han Serif SC","Songti SC",serif;
  line-height:1.9;font-size:16px}
a{color:var(--accent2);text-decoration:none}
a:hover{text-decoration:underline}
.wrap{display:flex;min-height:100vh}
nav{width:270px;flex:0 0 270px;background:var(--panel);border-right:1px solid var(--line);
  position:sticky;top:0;height:100vh;overflow-y:auto;padding:20px 0}
nav h1{font-size:16px;margin:0 18px 4px;letter-spacing:.12em;color:var(--accent);font-weight:600}
nav .sub{font-size:10.5px;color:var(--dim);margin:0 18px 16px;letter-spacing:.06em}
nav .grp>span{display:block;padding:9px 18px 5px;font-size:10.5px;letter-spacing:.1em;
  color:var(--dim);border-top:1px solid var(--line);margin-top:8px}
nav a{display:block;padding:4px 18px 4px 24px;font-size:12px;color:#b9bfc9;
  border-left:2px solid transparent;font-family:ui-monospace,monospace}
nav a:hover{background:var(--panel2);color:var(--fg);border-left-color:var(--accent);text-decoration:none}
main{flex:1;min-width:0;padding-bottom:80px}

.hero{position:relative;min-height:520px;display:flex;align-items:flex-end;
  border-bottom:1px solid var(--line);overflow:hidden}
.hero .bgimg{position:absolute;inset:0;background-size:cover;background-position:center;
  filter:brightness(.42) saturate(.9)}
.hero .grad{position:absolute;inset:0;
  background:linear-gradient(to top,#0f1116 6%,rgba(15,17,22,.6) 55%,rgba(15,17,22,.25))}
.hero .inner{position:relative;padding:56px;width:100%}
.hero .eyebrow{font-size:11px;letter-spacing:.34em;color:var(--accent);
  margin-bottom:12px;font-family:ui-monospace,monospace}
.hero h1{font-size:44px;margin:0 0 8px;letter-spacing:.08em;font-weight:600;
  text-shadow:0 2px 24px rgba(0,0,0,.8)}
.hero .en{font-size:11.5px;letter-spacing:.3em;color:#b9bfc9;margin-bottom:20px;
  font-family:ui-monospace,monospace}
.hero .meta{font-size:13px;color:#c3c8d1;line-height:2;text-shadow:0 1px 8px #000}
.hero .meta b{color:#fff}
.hero .quote{margin-top:20px;padding:13px 17px;border-left:3px solid var(--accent);
  background:rgba(20,23,30,.82);color:#ddd6c8;font-size:14px;max-width:700px;
  backdrop-filter:blur(3px)}

section.ch{padding:44px 56px 8px;border-bottom:1px solid var(--line)}
section.ch>h2{font-size:24px;margin:0 0 4px;letter-spacing:.06em;color:var(--accent);font-weight:600}
section.ch>.cnt{font-size:12px;color:var(--dim);margin-bottom:26px;font-family:ui-monospace,monospace}

.gallery{display:grid;grid-template-columns:repeat(auto-fill,minmax(190px,1fr));
  gap:10px;margin:22px 0 34px}
.gallery figure{margin:0;background:var(--panel);border:1px solid var(--line);
  border-radius:4px;overflow:hidden}
.gallery img{width:100%;height:150px;object-fit:cover;display:block;
  transition:transform .35s,filter .35s;filter:brightness(.88)}
.gallery figure:hover img{transform:scale(1.06);filter:brightness(1.05)}
.gallery figcaption{font-size:10.5px;color:var(--dim);padding:6px 9px;
  font-family:ui-monospace,monospace;white-space:nowrap;overflow:hidden;text-overflow:ellipsis}

article.ep{margin:0 0 32px;padding:0 0 24px;border-bottom:1px dashed var(--line)}
article.ep:last-child{border-bottom:none}
article.ep>h3{font-size:13.5px;margin:0 0 14px;color:var(--accent2);
  letter-spacing:.1em;font-family:ui-monospace,monospace;font-weight:600}
.line{margin:0 0 10px;display:flex;gap:11px;align-items:baseline}
.line .no{flex:0 0 38px;text-align:right;font-size:11px;color:#5a6172;
  font-family:ui-monospace,monospace;padding-top:3px}
.line .body{flex:1;min-width:0}
.spk{display:inline-block;font-size:11px;color:var(--spk);background:#1a212b;
  border:1px solid #27313f;border-radius:3px;padding:1px 6px;margin-right:8px;
  letter-spacing:.04em;font-family:ui-monospace,monospace;vertical-align:1px}
.spk.nar{color:var(--nar);background:#201d18;border-color:#332d24}
.txt{font-size:15.5px;color:#e0dcd5}
.txt.narration{color:#b0a898;font-style:italic}
.more{font-size:11px;color:#5f6674;margin-top:4px;font-family:ui-monospace,monospace}
.more summary{cursor:pointer;color:#6b7484;list-style:none}
.more summary::-webkit-details-marker{display:none}
.more summary:hover{color:var(--accent2)}
.more .row{margin:4px 0 0;padding-left:9px;border-left:2px solid var(--line);color:#8d94a2}

footer{padding:40px 56px;color:var(--dim);font-size:12px;line-height:2;
  border-top:1px solid var(--line)}
footer b{color:var(--fg)}
.top{position:fixed;right:20px;bottom:20px;background:var(--panel2);border:1px solid var(--line);
  color:var(--fg);width:40px;height:40px;border-radius:50%;display:flex;
  align-items:center;justify-content:center;cursor:pointer;font-size:16px;opacity:.75}
.top:hover{opacity:1;border-color:var(--accent)}
@media(max-width:900px){nav{display:none}
  .hero .inner,section.ch{padding-left:20px;padding-right:20px}
  .hero h1{font-size:28px}}
</style></head><body>
<div class="wrap">
<nav><h1>魔女兵器</h1><p class="sub">WITCH'S WEAPON · 剧情图鉴</p>
''')

for (t, k), eps in groups.items():
    out.append('<div class="grp"><span>%s</span>' % esc(t))
    for e in eps:
        out.append('<a href="#%s">%s</a>' % (e['file'][:-4], e['file'][7:-4]))
    out.append('</div>')
out.append('</nav><main>')

hero_bg = staged['wall'][0] if staged['wall'] else (staged['load'][0] if staged['load'] else '')
out.append('''<div class="hero">
<div class="bgimg" style="background-image:url('%s')"></div><div class="grad"></div>
<div class="inner">
<div class="eyebrow">WITCH'S WEAPON / ARCHIVE</div>
<h1>《魔女兵器》剧情图鉴</h1>
<div class="en">COMPLETE STORY · DECRYPTED · ILLUSTRATED</div>
<div class="meta">
<b>来源</b>：游戏客户端加密资源，独立逆向解密（XOR 0xFF）<br>
<b>规模</b>：%d 个文本 · %d 行对话 · 五语对照（简中/繁中/日/韩/英）<br>
<b>插图</b>：%d 张（角色卡面 / 加载图 / 官方壁纸 / 活动图 / 场景）
</div>
<div class="quote">『异质物』又称『神迹』，指在特定情况下能引发超常物理现象的道具和工具的总称。</div>
</div></div>
''' % (hero_bg, len(entries), TOTAL_LINES,
       sum(len(v) for v in staged.values())))

# 每章前放一个图廊
GAL = {
    'sys':   ('load',  '加载图'),
    'ch1':   ('card',  '角色卡面'),
    'ch2':   ('card',  '角色卡面'),
    'ch3':   ('card',  '角色卡面'),
    'event': ('event', '活动图'),
    'side':  ('bg',    '背景场景'),
    'misc':  ('wall',  '官方壁纸'),
}
used = set()
for (t, k), eps in groups.items():
    total = sum(len(e['lines']) for e in eps)
    out.append('<section class="ch"><h2>%s</h2><div class="cnt">%d 个文本 · %d 行</div>'
               % (esc(t), len(eps), total))
    gk, glabel = GAL.get(k, ('card', '插图'))
    imgs = [x for x in staged.get(gk, []) if x not in used][:12]
    for x in imgs: used.add(x)
    if imgs:
        out.append('<div class="gallery">')
        for x in imgs:
            out.append('<figure><img src="%s" loading="lazy" alt=""><figcaption>%s</figcaption></figure>'
                       % (x, esc(os.path.basename(x))))
        out.append('</div>')
    for e in eps:
        out.append('<article class="ep" id="%s"><h3>%s</h3>' % (e['file'][:-4], e['file'][:-4]))
        for ln in e['lines']:
            idx, spk, zh, extra = parse_line(ln)
            if not zh: continue
            cls = 'nar' if ('N/A' in spk or not spk) else ''
            out.append('<div class="line"><div class="no">%s</div><div class="body">' % esc(idx))
            if spk: out.append('<span class="spk %s">%s</span>' % (cls, esc(spk)))
            out.append('<span class="txt %s">%s</span>' % ('narration' if cls else '', esc(zh)))
            if extra:
                out.append('<details class="more"><summary>其它语言 (%d)</summary>' % len(extra))
                for i, o in enumerate(extra):
                    lbl = ['繁中', '日文', '韩文', '英文'][i] if i < 4 else '语言%d' % (i + 4)
                    out.append('<div class="row"><b>%s</b> %s</div>' % (lbl, esc(o)))
                out.append('</details>')
            out.append('</div></div>')
        out.append('</article>')
    out.append('</section>')

out.append('''<footer>
<b>《魔女兵器》剧情图鉴</b><br>
数据来源：客户端加密资源 <code>sentence_*.ab</code>，独立逆向解密（XOR 0xFF）<br>
美术素材：游戏内 AssetBundle 导出（AssetStudioModCLI）<br>
游戏开发：北京水琴铃（WaterBell）· 国服已于 2024-08-17 停服<br>
本档案仅供研究与保存用途。
</footer></main></div>
<div class="top" onclick="window.scrollTo({top:0,behavior:'smooth'})">↑</div>
</body></html>''')

with io.open(OUT, 'w', encoding='utf-8') as f:
    f.write('\n'.join(out))
print()
print('已生成: %s (%.2f MB)' % (OUT, os.path.getsize(OUT) / 1024 / 1024))
