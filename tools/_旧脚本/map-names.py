# 用游戏内 dictionary.csv 建立角色名映射，匹配立绘
import io, os, sys, re, csv, json, shutil

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

CFG = r'G:\project\其他\game\配置表_解密版\怀旧服v128'
SITE = r'G:\project\其他\game\提取资源\网络资源\13_官网日服witchs-weapon.net'
ART = r'G:\project\其他\game\美术素材_分类'

# 1) 读 dictionary.csv（5 语名称表，制表符分隔）
dict_rows = []
with io.open(os.path.join(CFG, 'dictionary.csv'), encoding='utf-8') as f:
    rows = [l.rstrip('\n').rstrip('\r').split('\t') for l in f]
for r in rows[3:]:
    if len(r) >= 6 and r[0].strip():
        dict_rows.append({
            'id': r[0].strip(), 'zh': r[1].strip(), 'tw': r[2].strip(),
            'jp': r[3].strip(), 'kr': r[4].strip(), 'en': r[5].strip(),
        })
print('dictionary 条目: %d' % len(dict_rows))

# 2) 官网角色
chars = json.load(io.open(os.path.join(SITE, 'characters.json'), encoding='utf-8'))

# 3) 用日文名反查中文名
jp2row = {}
for r in dict_rows:
    if r['jp']:
        jp2row.setdefault(r['jp'], r)

print()
print('=== 官网角色 -> 游戏内名称 ===')
for ch in chars:
    jp = ch['name']
    row = jp2row.get(jp)
    if not row:
        # 模糊匹配
        for k, v in jp2row.items():
            if k and (k in jp or jp in k) and abs(len(k) - len(jp)) <= 2:
                row = v
                break
    ch['zh'] = row['zh'] if row else ''
    ch['tw'] = row['tw'] if row else ''
    ch['kr'] = row['kr'] if row else ''
    ch['en'] = row['en'] if row else ''
    ch['dict_id'] = row['id'] if row else ''
    print('  %-3s %-24s -> %-10s %-10s %s' % (ch['idx'], jp, ch['zh'] or '?', ch['en'] or '?', ch['dict_id']))

json.dump(chars, io.open(os.path.join(SITE, 'characters.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
print()
print('已更新 characters.json')
