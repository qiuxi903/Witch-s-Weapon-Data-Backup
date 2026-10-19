# 为角色匹配游戏内立绘 / 卡面 / 头像
import io, os, re, sys, json, shutil

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

ART = r'G:\project\其他\game\美术素材_分类'
SITE = r'G:\project\其他\game\提取资源\网络资源\13_官网日服witchs-weapon.net'
OUTIMG = r'G:\project\其他\game\assets\chara'
os.makedirs(OUTIMG, exist_ok=True)

chars = json.load(io.open(os.path.join(SITE, 'characters.json'), encoding='utf-8'))

# 收集游戏内美术
def scan(sub):
    d = os.path.join(ART, sub)
    out = []
    if os.path.isdir(d):
        for dp, dn, fn in os.walk(d):
            for f in fn:
                if f.lower().endswith(('.png', '.jpg', '.jpeg')):
                    out.append(os.path.join(dp, f))
    return sorted(out)

cards = scan('01_角色卡面')
avatars = scan('12_角色头像')
weapons = scan('11_武器立绘')
portraits = scan('02_角色立绘部件')
loads = scan('04_加载图')

print('游戏内素材:')
for n, v in [('角色卡面', cards), ('角色头像', avatars), ('武器立绘', weapons),
             ('立绘部件', portraits), ('加载图', loads)]:
    print('  %-10s %5d' % (n, len(v)))

# 日文名 -> 可能的游戏内命名（拼音/英文）
NAME_MAP = {
    '01': ('レン', 'Ren', ['ren']),
    '02': ('マリル・フォン・ブラウン', 'Maril von Braun', ['maril', 'malil']),
    '03': ('アニー・バース', 'Annie Bath', ['annie', 'ani']),
    '04': ('ラファエル・デックス', 'Raphael Dex', ['raphael', 'rafael']),
    '05': ('イルカ', 'Iruka', ['iruka']),
    '07': ('リリヤ・トリグラファ', 'Lilia Triglav', ['lilia', 'liliya']),
    '08': ('ギン', 'Gin', ['gin']),
    '09': ('アストレイル', 'Astreil', ['astr']),
    '10': ('虎千代', 'Torachiyo', ['tora']),
    '11': ('クラウディア', 'Claudia', ['claudia']),
    '12': ('ソヤ・エンジェルス', 'Soya Angels', ['soya']),
    '13': ('スクルド・エクスロッド', 'Skuld Exrod', ['skuld']),
    '14': ('ニュクス・ストラッツィ', 'Nyx Stratzi', ['nyx', 'nyuks']),
    '15': ('ハインリッヒ・クンラート', 'Heinrich Kunrat', ['heinrich', 'hain']),
}

# 用头像做主力（195 个，命名可能含角色 id）
print()
print('=== 角色头像命名样例 ===')
for p in avatars[:20]:
    print('  ' + os.path.basename(p))

print()
print('=== 角色卡面命名样例 ===')
for p in cards[:20]:
    print('  ' + os.path.basename(p))
