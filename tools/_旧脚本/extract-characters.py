# 从官网角色页提取角色数据，并关联游戏内立绘
import io, os, re, sys, json

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

SITE = r'G:\project\其他\game\提取资源\网络资源\13_官网日服witchs-weapon.net'
c = io.open(os.path.join(SITE, 'character.html'), encoding='utf-8').read()

chars = []
for m in re.finditer(
    r'<h2><img src="/img/character/(\d+)/name\.png" alt="([^"]*)"></h2>'
    r'[\s\S]{0,400}?'
    r'<p><img src="/img/character/\d+/voice\.png" alt="([^"]*)"></p>'
    r'[\s\S]{0,300}?'
    r'<dd>([^<]*)</dd>'
    r'[\s\S]{0,200}?'
    r'data-voice="([^"]*)"', c):
    idx, name, quote, cv, voice = m.groups()
    chars.append({
        'idx': idx, 'name': name, 'quote': quote, 'cv': cv, 'voice': voice,
        'name_png': '/img/character/%s/name.png' % idx,
    })

print('提取到 %d 名角色' % len(chars))
for ch in chars:
    print('  %-3s %-26s CV: %-14s %s' % (ch['idx'], ch['name'], ch['cv'], ch['quote'][:34]))

with io.open(os.path.join(SITE, 'characters.json'), 'w', encoding='utf-8') as f:
    json.dump(chars, f, ensure_ascii=False, indent=1)
print()
print('已保存 characters.json')
