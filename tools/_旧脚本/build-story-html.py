# 生成《魔女兵器》剧情 HTML 电子书
import io, os, sys, re, json, html

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

SRC = r'G:\project\其他\game\剧情文本_解密版\国服v2.0.1'
OUT = r'G:\project\其他\game\魔女兵器_剧情全集.html'

# 章节命名：按 sentence 编号规则映射
# 00001-00999  系统/教学
# 10001-10999  第一章
# 20001-20999  第二章
# 30001-30999  第三章
# 31000+       活动
# 40000+       支线
def chapter_of(num):
    if num < 10000:
        return ('序章 · 系统与引导', 'sys')
    n = num // 10000
    if n == 1:
        return ('第一章 · 人生的终结、命运的开始', 'ch1')
    if n == 2:
        return ('第二章 · 想守护的她、被守护的你', 'ch2')
    if n == 3:
        if num >= 31000:
            return ('活动剧情', 'event')
        return ('第三章 · 神魂的治愈、身体的诅咒', 'ch3')
    if n == 4:
        return ('支线剧情', 'side')
    if n >= 9:
        return ('测试与其它', 'misc')
    return ('其它', 'misc')

# 收集
files = sorted(f for f in os.listdir(SRC) if f.endswith('.txt'))
entries = []
for f in files:
    m = re.match(r'sentence_(\d+)\.txt$', f)
    if not m:
        continue
    num = int(m.group(1))
    c = io.open(os.path.join(SRC, f), encoding='utf-8').read()
    lines = [l for l in c.split('\n') if l.strip()]
    if not lines:
        continue
    entries.append({'file': f, 'num': num, 'lines': lines, 'chars': len(c)})

print('收集 %d 个文件, %d 行' % (len(entries), sum(len(e['lines']) for e in entries)))

# 按章节分组
from collections import OrderedDict
groups = OrderedDict()
for e in entries:
    title, key = chapter_of(e['num'])
    groups.setdefault((title, key), []).append(e)

# 解析一行：序号 \t 说话人 \t 简中 \t 繁中 \t 日 \t 韩 \t 英
def parse_line(ln):
    parts = ln.split('\t')
    if len(parts) >= 3:
        idx = parts[0].strip()
        spk = parts[1].strip()
        zh = parts[2].strip()
        extra = parts[3:] if len(parts) > 3 else []
        return idx, spk, zh, extra
    return '', '', ln, []

def esc(s):
    return html.escape(s).replace('\\n', '<br>')

# 构建 HTML
out = []
out.append('''<!DOCTYPE html>
<html lang="zh-CN">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》剧情全集</title>
<style>
:root{
  --bg:#14161c; --panel:#1c1f28; --panel2:#232733; --line:#2f3543;
  --fg:#e8e6e3; --dim:#9aa0ad; --accent:#c9a227; --accent2:#7fb3d5;
  --spk:#8fb8d8; --nar:#a89f8c;
}
*{box-sizing:border-box}
html{scroll-behavior:smooth}
body{
  margin:0; background:var(--bg); color:var(--fg);
  font-family:"Noto Serif SC","Source Han Serif SC","Songti SC",serif;
  line-height:1.9; font-size:16px;
}
a{color:var(--accent2);text-decoration:none}
a:hover{text-decoration:underline}

/* 布局 */
.wrap{display:flex;min-height:100vh}
nav{
  width:290px;flex:0 0 290px;background:var(--panel);
  border-right:1px solid var(--line);position:sticky;top:0;height:100vh;
  overflow-y:auto;padding:22px 0;
}
nav h1{
  font-size:17px;margin:0 20px 6px;letter-spacing:.12em;color:var(--accent);
  font-weight:600;
}
nav .sub{font-size:11px;color:var(--dim);margin:0 20px 18px;letter-spacing:.06em}
nav .grp{margin:0 0 4px}
nav .grp>span{
  display:block;padding:9px 20px 5px;font-size:11px;letter-spacing:.1em;
  color:var(--dim);text-transform:uppercase;border-top:1px solid var(--line);
  margin-top:8px;
}
nav a{
  display:block;padding:5px 20px 5px 26px;font-size:12.5px;color:#b9bfc9;
  border-left:2px solid transparent;font-family:ui-monospace,monospace;
}
nav a:hover{background:var(--panel2);color:var(--fg);border-left-color:var(--accent);text-decoration:none}

main{flex:1;min-width:0;padding:0 0 80px}

header.hero{
  padding:64px 56px 44px;border-bottom:1px solid var(--line);
  background:linear-gradient(160deg,#1a1d26,#14161c 70%);
}
header.hero .eyebrow{
  font-size:11px;letter-spacing:.34em;color:var(--accent);margin-bottom:14px;
  font-family:ui-monospace,monospace;
}
header.hero h1{
  font-size:40px;margin:0 0 10px;letter-spacing:.08em;font-weight:600;
}
header.hero .en{
  font-size:12px;letter-spacing:.3em;color:var(--dim);margin-bottom:22px;
  font-family:ui-monospace,monospace;
}
header.hero .meta{font-size:13px;color:var(--dim);line-height:2}
header.hero .meta b{color:var(--fg);font-weight:600}
header.hero .quote{
  margin-top:24px;padding:14px 18px;border-left:3px solid var(--accent);
  background:#1a1d26;color:#cfc9bb;font-size:14px;max-width:720px;
}

section.ch{
  padding:44px 56px 10px;border-bottom:1px solid var(--line);
}
section.ch>h2{
  font-size:24px;margin:0 0 4px;letter-spacing:.06em;color:var(--accent);
  font-weight:600;
}
section.ch>.cnt{font-size:12px;color:var(--dim);margin-bottom:26px;
  font-family:ui-monospace,monospace}

article.ep{
  margin:0 0 34px;padding:0 0 26px;border-bottom:1px dashed var(--line);
}
article.ep:last-child{border-bottom:none}
article.ep>h3{
  font-size:14px;margin:0 0 16px;color:var(--accent2);letter-spacing:.1em;
  font-family:ui-monospace,monospace;font-weight:600;
}

.line{margin:0 0 11px;display:flex;gap:12px;align-items:baseline}
.line .no{
  flex:0 0 40px;text-align:right;font-size:11px;color:#5a6172;
  font-family:ui-monospace,monospace;padding-top:3px;
}
.line .body{flex:1;min-width:0}
.spk{
  display:inline-block;font-size:11.5px;color:var(--spk);
  background:#1e2530;border:1px solid #2b3646;border-radius:3px;
  padding:1px 7px;margin-right:9px;letter-spacing:.04em;
  font-family:ui-monospace,monospace;vertical-align:1px;
}
.spk.nar{color:var(--nar);background:#231f1a;border-color:#3a3228}
.txt{font-size:15.5px;color:#e2ded7}
.txt.narration{color:#b3aa9a;font-style:italic}
.more{
  font-size:11px;color:#5f6674;margin-top:5px;
  font-family:ui-monospace,monospace;
}
.more summary{cursor:pointer;color:#6b7484;list-style:none}
.more summary::-webkit-details-marker{display:none}
.more summary:hover{color:var(--accent2)}
.more .row{margin:5px 0 0;padding-left:10px;border-left:2px solid var(--line);color:#8d94a2}

footer{
  padding:40px 56px;color:var(--dim);font-size:12px;line-height:2;
  border-top:1px solid var(--line);
}
footer b{color:var(--fg)}
.top{
  position:fixed;right:22px;bottom:22px;background:var(--panel2);
  border:1px solid var(--line);color:var(--fg);width:40px;height:40px;
  border-radius:50%;display:flex;align-items:center;justify-content:center;
  cursor:pointer;font-size:16px;opacity:.75;
}
.top:hover{opacity:1;border-color:var(--accent)}
@media(max-width:900px){
  nav{display:none}
  header.hero,section.ch{padding-left:22px;padding-right:22px}
  header.hero h1{font-size:28px}
}
</style>
</head>
<body>
<div class="wrap">
<nav>
<h1>魔女兵器</h1>
<p class="sub">WITCH'S WEAPON · 剧情全集</p>
''')

# 导航
for (title, key), eps in groups.items():
    out.append('<div class="grp"><span>%s</span>' % esc(title))
    for e in eps:
        out.append('<a href="#%s">%s</a>' % (e['file'].replace('.txt', ''), e['file'].replace('sentence_', '').replace('.txt', '')))
    out.append('</div>')

out.append('</nav>\n<main>')
out.append('''<header class="hero">
<div class="eyebrow">WITCH'S WEAPON / ARCHIVE</div>
<h1>《魔女兵器》剧情全集</h1>
<div class="en">COMPLETE STORY TEXT · DECRYPTED</div>
<div class="meta">
<b>来源</b>：游戏客户端 <code>sentence_*.ab</code> 加密资源，独立逆向解密<br>
<b>加密算法</b>：逐字节取反（XOR 0xFF）<br>
<b>区服</b>：国服 v2.0.1<br>
<b>规模</b>：%d 个文本文件 · %d 行对话<br>
<b>语言</b>：简中 / 繁中 / 日 / 韩 / 英（五语对照）
</div>
<div class="quote">『异质物』又称『神迹』，指在特定情况下能引发超常物理现象的道具和工具的总称。</div>
</header>
''' % (len(entries), sum(len(e['lines']) for e in entries)))

# 正文
for (title, key), eps in groups.items():
    total = sum(len(e['lines']) for e in eps)
    out.append('<section class="ch"><h2>%s</h2><div class="cnt">%d 个文本 · %d 行</div>'
               % (esc(title), len(eps), total))
    for e in eps:
        out.append('<article class="ep" id="%s"><h3>%s</h3>'
                   % (e['file'].replace('.txt', ''), e['file'].replace('.txt', '')))
        for ln in e['lines']:
            idx, spk, zh, extra = parse_line(ln)
            if not zh:
                continue
            cls = 'nar' if ('N/A' in spk or not spk) else ''
            out.append('<div class="line"><div class="no">%s</div><div class="body">' % esc(idx))
            if spk:
                out.append('<span class="spk %s">%s</span>' % (cls, esc(spk)))
            out.append('<span class="txt %s">%s</span>' % ('narration' if cls else '', esc(zh)))
            if extra:
                others = [x for x in extra if x.strip()]
                if others:
                    out.append('<details class="more"><summary>其它语言 (%d)</summary>' % len(others))
                    for i, o in enumerate(others):
                        lbl = ['繁中', '日文', '韩文', '英文'][i] if i < 4 else '语言%d' % (i + 4)
                        out.append('<div class="row"><b>%s</b> %s</div>' % (lbl, esc(o)))
                    out.append('</details>')
            out.append('</div></div>')
        out.append('</article>')
    out.append('</section>')

out.append('''<footer>
<b>《魔女兵器》剧情全集</b><br>
数据来源：游戏客户端加密资源 <code>assets/assetbundle/config/lesson/sentence_*.ab</code><br>
解密方式：独立逆向（XOR 0xFF），详见 <code>剧��文本加密分析报告.md</code><br>
游戏开发：北京水琴铃（WaterBell）· 国服已于 2024-08-17 停服<br>
本档案仅供研究与保存用途。
</footer>
</main>
</div>
<div class="top" onclick="window.scrollTo({top:0,behavior:'smooth'})">↑</div>
</body>
</html>''')

with io.open(OUT, 'w', encoding='utf-8') as f:
    f.write('\n'.join(out))

print('已生成: %s (%.2f MB)' % (OUT, os.path.getsize(OUT) / 1024 / 1024))
