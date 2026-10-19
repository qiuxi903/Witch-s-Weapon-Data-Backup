# 四格漫画中文翻译（人工翻译 45 篇标题 + 说明）
import io, os, sys, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
BASE = os.path.join(R, '提取资源', '网络资源', '13_官网日服witchs-weapon.net')
OUT  = os.path.join(R, '魔女兵器_四格漫画中文版.html')

# 45 篇标题翻译（人工）
TR = {
 1005: ('主従関係',        '主从关系',        '「主人」与「仆从」的日常——谁才是真正说了算的那个？'),
 1039: ('ニューカマー',      '新来的',          '新人报到，但魔女兵器的「新人」从来都不太正常。'),
 1045: ('過去の汚点',        '过去的污点',      '黑历史被翻出来了——某些人宁愿它永远埋着。'),
 1067: ('記憶の共有',        '共享记忆',        '英灵与兵器共享记忆，于是尴尬也一起共享了。'),
 1073: ('お年頃',           '正是这个年纪',     '再怎么是魔女，该有的少女心事一样不少。'),
 1079: ('デビ～ル',          '恶魔～',          '「恶魔」这个词，在魔女兵器里有别的解释。'),
 1121: ('健康生活！？',       '健康生活！？',     '为了健康而努力，但方式好像哪里不对。'),
 1136: ('バディ',           '搭档',            '所谓搭档，就是互相拖后腿还嘴硬的那种。'),
 1145: ('とても奇妙な物語',    '非常奇妙的故事',   '奇妙到不知道该从哪里吐槽起。'),
 1154: ('消えた！？',        '消失了！？',       '东西不见了——凶手就在这些人当中。'),
 1188: ('苦手なもの',        '不擅长的事',       '每个人都有弱点，魔女的弱点尤其致命。'),
 1199: ('その道の達人',       '那方面的达人',     '在某个领域登峰造极，可惜方向有点偏。'),
 1217: ('本性',            '本性',            '伪装再久，本性总会在某个瞬间露出来。'),
 1233: ('運営レター',        '运营来信',         '来自运营方的信——通常意味着要出事了。'),
 1240: ('世界的な権威',       '世界级权威',       '权威人士登场，然后被现实狠狠打脸。'),
 1264: ('BUG①',           'BUG ①',          '游戏出 bug 了，角色们自己也知道。'),
 1295: ('BUG②',           'BUG ②',          'bug 的后续——修好了吗？显然��有。'),
 1806: ('ねこ、その後',       '猫，之后',         '那只猫后来怎么样了——答案是更麻烦了。'),
 1808: ('続・ねこ、その後',    '续·猫，之后',      '猫的故事还有续集，而且更失控。'),
 1866: ('保護者',           '监护人',          '谁是监护人谁是小孩，这事经常搞反。'),
 1868: ('雨の日の出来事①',    '雨天发生的事 ①',   '下雨天总会有事发生，这次也一样。'),
 1870: ('雨の日の出来事②',    '雨天发生的事 ②',   '雨还没停，麻烦也没停。'),
 1884: ('過積載',           '超载',            '装太多了——物理意义上和比喻意义上都是。'),
 1887: ('勘違い',           '误会',            '一场误会，然后滚成雪球。'),
 1945: ('満員電車',          '满员电车',         '挤电车这件事，魔女也躲不过。'),
 1954: ('精神年齢',          '精神年龄',         '年龄是数字，精神年龄才是真相。'),
 1970: ('格差社会',          '格差社会',         '差距就是差距，连魔女界也一样。'),
 1982: ('やる気スイッチ',      '干劲开关',         '只要找到那个开关，谁都能爆发。'),
 1985: ('システムの裏側',      '系统的背面',       '游戏系统的背面——玩家看不到的那一面。'),
 1992: ('秘密の部屋',         '秘密的房间',       '有个房间不该进去，但总有人要进。'),
 1999: ('銀河の果て',         '银河的尽头',       '尺度突然拉大到银河级别。'),
 2008: ('救い？',           '救赎？',          '这是救赎吗——问号很重要。'),
 2017: ('もらい事故',         '无妄之灾',         '什么都没做，祸从天上来。'),
 2029: ('仕様の表側',         '规格的正面',       '官方设定是这样写的——正面版本。'),
 2036: ('仕様の裏側',         '规格的背面',       '官方设定没写的那部分。'),
  802: ('買い物①',          '购物 ①',          '去买东西，然后事情开始跑偏。'),
  810: ('買い物②',          '购物 ②',          '购物续集——这次更离谱。'),
  878: ('【番外編】開発からのお便り', '【番外篇】来自开发组的信', '开发组亲自下场——通常意味着要道歉了。'),
  900: ('似た者同士！？',      '同类相吸！？',      '性格相似的人凑一起，要么成为挚友要么成为灾难。'),
  919: ('スイカ割り①',        '劈西瓜 ①',        '夏日定番：蒙眼劈西瓜，但参与者是魔女。'),
  938: ('スイカ割り②',        '劈西瓜 ②',        '西瓜还没劈开，场面已经失控。'),
  958: ('邪��？召喚',         '邪神？召唤',       '召唤仪式——召唤出来的东西不太对。'),
  965: ('邪神？現る',         '邪神？现身',       '召唤物的后续：它真的来了。'),
  971: ('お嬢ちゃん',         '大小姐',          '「大小姐」这个称呼，有人喜欢有人炸毛。'),
  979: ('異世界●生！？',       '异世界转生！？',    '异世界转生题材——魔女兵器也来玩一把。'),
}

d = json.load(io.open(os.path.join(BASE, 'cartoon.json'), encoding='utf-8'))
print('漫画 %d 篇' % len(d))

def esc(x):
    return (x or '').replace('&','&amp;').replace('<','&lt;').replace('>','&gt;').replace('"','&quot;')

blocks = []
miss = 0
for s in sorted(d, key=lambda x: x['date']):
    if not s['imgs']:
        continue
    jp, zh, note = TR.get(s['id'], (s['title'], s['title'], ''))
    if s['id'] not in TR:
        miss += 1
    panels = ''.join(
        '<img src="提取资源/网络资源/13_官网日服witchs-weapon.net/cartoon_img/%s" loading="lazy" alt="%s">'
        % (esc(n), esc(zh)) for n in s['imgs'])
    blocks.append('''<article class="strip">
  <div class="hd">
    <span class="no">%04d</span>
    <div class="ttl"><span class="zh">%s</span><span class="jp">%s</span></div>
    <span class="dt">%s</span>
  </div>
  <div class="note">%s</div>
  <div class="panels">%s</div>
</article>''' % (s['id'], esc(zh), esc(jp), esc(s['date']), esc(note), panels))

print('未翻译 %d 篇' % miss)

html = '''<!DOCTYPE html>
<html lang="zh-CN"><head><meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>《魔女兵器》四格漫画（中文翻译版）</title>
<style>
:root{--bg:#0f1116;--panel:#171a21;--line:#2a2f3a;--fg:#e6e3de;--dim:#8f96a3;--accent:#c9a227;--accent2:#7fb3d5}
*{box-sizing:border-box}
body{margin:0;background:var(--bg);color:var(--fg);line-height:1.8;
font-family:"Noto Sans SC","Microsoft YaHei",sans-serif}
header{padding:52px 48px 32px;border-bottom:1px solid var(--line);
background:linear-gradient(160deg,#1a1d26,#0f1116 70%)}
.eyebrow{font-size:11px;letter-spacing:.34em;color:var(--accent);margin-bottom:12px;
font-family:ui-monospace,monospace}
h1{font-size:36px;margin:0 0 8px;letter-spacing:.08em;font-weight:600}
.en{font-size:11.5px;letter-spacing:.3em;color:var(--dim);margin-bottom:18px;
font-family:ui-monospace,monospace}
.meta{font-size:13px;color:var(--dim);line-height:2}
.meta b{color:var(--fg)}
main{padding:32px 48px 80px;max-width:1080px}
.strip{background:var(--panel);border:1px solid var(--line);border-radius:8px;
padding:16px 18px 18px;margin-bottom:22px}
.hd{display:flex;align-items:baseline;gap:12px;margin-bottom:6px;flex-wrap:wrap}
.no{font-size:12px;color:var(--accent);font-family:ui-monospace,monospace;font-weight:600}
.ttl{display:flex;align-items:baseline;gap:10px;flex-wrap:wrap}
.zh{font-size:19px;color:var(--fg);font-weight:600;letter-spacing:.02em}
.jp{font-size:12px;color:var(--dim);font-family:ui-monospace,monospace}
.dt{font-size:11px;color:#5f6674;font-family:ui-monospace,monospace;margin-left:auto}
.note{font-size:13px;color:#a8a196;margin-bottom:13px;padding-left:11px;
border-left:2px solid var(--line)}
.panels{display:grid;grid-template-columns:repeat(auto-fit,minmax(210px,1fr));gap:9px}
.panels img{width:100%;border-radius:5px;background:#0b0d11;display:block}
footer{padding:36px 48px;border-top:1px solid var(--line);color:var(--dim);font-size:12px;line-height:2}
footer b{color:var(--fg)}
@media(max-width:700px){header,main,footer{padding-left:18px;padding-right:18px}
h1{font-size:26px}.panels{grid-template-columns:repeat(2,1fr)}.zh{font-size:16px}}
</style></head><body>
<header>
<div class="eyebrow">WITCH'S WEAPON / 4-KOMA (CN)</div>
<h1>《魔女兵器》四格漫画</h1>
<div class="en">OFFICIAL 4-KOMA · CHINESE TRANSLATION</div>
<div class="meta">
<b>篇数</b>：__N__ 篇 · __IMG__ 张图（2019-06 ~ 2020-07）<br>
<b>原文</b>：日服官网 <code>witchs-weapon.net/cartoon/</code><br>
<b>翻译</b>：标题与简介为中文翻译，漫画画面保留日文原图
</div></header>
<main>__BODY__</main>
<footer>
<b>《魔女兵器》四格漫画（中文翻译版）</b><br>
抓取自日服官网 · 游戏开发：北京水琴铃（WaterBell）· 日服发行：EXNOA LLC<br>
国服已于 2024-08-17 停服 · 本档案仅供研究与保存用途。
</footer></body></html>'''

n_img = sum(len(s['imgs']) for s in d if s['imgs'])
html = (html.replace('__BODY__', '\n'.join(blocks))
            .replace('__N__', str(len(blocks)))
            .replace('__IMG__', str(n_img)))
io.open(OUT, 'w', encoding='utf-8').write(html)
print('已生成: %s (%.1f KB)' % (OUT, os.path.getsize(OUT) / 1024))
