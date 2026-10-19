# 生成《魔女兵器》角色图鉴 HTML
import io, os, sys, re, json, shutil, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

CFG   = r'G:\project\其他\game\配置表_解密版\怀旧服v128'
SITE  = r'G:\project\其他\game\提取资源\网络资源\13_官网日服witchs-weapon.net'
ART   = r'G:\project\其他\game\美术素材_分类'
OUT   = r'G:\project\其他\game\魔女兵器_角色图鉴.html'
IMGD  = r'G:\project\其他\game\assets\chara'
os.makedirs(IMGD, exist_ok=True)

def read_tsv(name):
    p = os.path.join(CFG, name + '.csv')
    if not os.path.exists(p): return []
    rows = [l.rstrip('\n').rstrip('\r').split('\t') for l in io.open(p, encoding='utf-8', errors='replace')]
    return rows

# ---- 1) 角色名表（dictionary）----
dic = read_tsv('dictionary')
names = {}
for r in dic[3:]:
    if len(r) >= 6 and r[0].strip():
        names[r[0].strip()] = {'zh': r[1], 'tw': r[2], 'jp': r[3], 'kr': r[4], 'en': r[5]}

# ---- 2) dictionarystatic：主角名 + 台词 ----
dstat = read_tsv('dictionarystatic')
static = {}
for r in dstat[3:]:
    if len(r) >= 6 and r[0].strip():
        static[r[0].strip()] = {'zh': r[1], 'tw': r[2], 'jp': r[3], 'kr': r[4], 'en': r[5]}

# ---- 3) 官网角色 ----
chars = json.load(io.open(os.path.join(SITE, 'characters.json'), encoding='utf-8'))

# 官网名 -> 中文名（含主角特例）
SPECIAL = {
    'レン': ('小怜', '小憐', 'レン', '렌', 'Ren', 'role02'),
    'マリル・フォン・ブラウン': ('莉琉', '莉琉', 'マリル', '마리루', 'Mariru', 'role11'),
}
jp2 = {}
for k, v in names.items():
    if v['jp']:
        jp2.setdefault(v['jp'], v)

for ch in chars:
    jp = ch['name']
    if jp in SPECIAL:
        zh, tw, j, kr, en, rid = SPECIAL[jp]
        ch.update({'zh': zh, 'tw': tw, 'kr': kr, 'en': en, 'dict_id': rid})
        continue
    row = jp2.get(jp)
    if not row:
        for k, v in jp2.items():
            if k and (k in jp or jp in k) and abs(len(k) - len(jp)) <= 3:
                row = v; break
    if row:
        ch.update({'zh': row['zh'], 'tw': row['tw'], 'kr': row['kr'], 'en': row['en'],
                   'dict_id': [k for k, v in names.items() if v is row][0]})

# ---- 4) 立绘：用 Servant00_Image_<client_id> 匹配 ----
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
heads = scan('12_角色头像')
loads = scan('04_加载图')

# 官网 idx -> 游戏内 client_id 前缀
IDX2CID = {
    '01': '101', '02': '102', '03': '106', '04': '104', '05': '112',
    '07': '129', '08': '114', '09': '116', '10': '127', '11': '113',
    '12': '120', '13': '107', '14': '108', '15': '110',
}

def stage(src, name):
    ext = os.path.splitext(src)[1].lower()
    dst = os.path.join(IMGD, name + ext)
    if not os.path.exists(dst):
        try: shutil.copy2(src, dst)
        except Exception: return ''
    return 'assets/chara/' + os.path.basename(dst)

for ch in chars:
    cid = IDX2CID.get(ch['idx'], '')
    # 卡面：Servant00_Image_<cid>
    ch['card'] = ''
    ch['head'] = ''
    ch['thumb'] = ''
    if cid:
        for p in cards:
            b = os.path.basename(p)
            if re.search(r'Servant00_Image_%s(?!\d)' % cid, b) and '_bg' not in b:
                ch['card'] = stage(p, 'card_%s' % ch['idx']); break
        for p in heads:
            b = os.path.basename(p)
            if re.search(r'Draw_Head_%s(?!\d)' % cid, b):
                ch['head'] = stage(p, 'head_%s' % ch['idx']); break
    # 官网名牌
    np_ = os.path.join(SITE, 'img', 'character_%s_name.png' % ch['idx'])
    if os.path.exists(np_):
        ch['thumb'] = stage(np_, 'name_%s' % ch['idx'])
    # 语音
    vp = os.path.join(SITE, 'voice', 'cv_%s.mp3' % ch['idx'])
    ch['voice'] = ('assets/chara/' + os.path.basename(stage(vp, 'cv_%s' % ch['idx']))) if os.path.exists(vp) else ''

print('角色匹配结果:')
for ch in chars:
    print('  %-3s %-12s %-22s card=%s head=%s voice=%s' % (
        ch['idx'], ch.get('zh', '?'), ch['name'],
        'Y' if ch['card'] else '-', 'Y' if ch['head'] else '-', 'Y' if ch['voice'] else '-'))

json.dump(chars, io.open(os.path.join(SITE, 'characters.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)

# ---- 5) 全部英灵名单（29 名）----
roster = []
for k, v in names.items():
    if re.match(r'^11101\d{3}101$', k):
        roster.append({'id': k, 'zh': v['zh'], 'tw': v['tw'], 'jp': v['jp'],
                       'kr': v['kr'], 'en': v['en']})
roster.sort(key=lambda x: x['id'])
print()
print('英灵名单: %d 名' % len(roster))
json.dump(roster, io.open(os.path.join(SITE, 'roster.json'), 'w', encoding='utf-8'),
          ensure_ascii=False, indent=1)
