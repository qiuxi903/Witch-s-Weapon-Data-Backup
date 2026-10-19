# 从 Godot 剧情编辑器源码中提取《魔女兵器》完整剧情文本
import io, os, re, sys, json, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

SRC = r'G:\project\其他\game\提取资源\网络资源\11_怀旧服witchweapon.wiki\src\Witch-Weapon-Godot--main\scripts\story'
OUT = r'G:\project\其他\game\剧情文本_完整版'
os.makedirs(OUT, exist_ok=True)

# 章节中文名映射
CHAPTER_NAMES = {
    'chapter1': '第一章_人生的终结命运的开始',
    'chapter2': '第二章_想守护的她被守护的你',
    'chapter3': '第三章_神魂的治愈身体的诅咒',
    'bathophobia': '活动_深潜症',
    'traumareflex': '活动_创伤反射',
    'apocalypse': '活动_启示录',
    'stardustdescends': '活动_星尘降临',
    'chaoscalculus': '活动_混沌演算',
    'deathconfession': '活动_死亡告白',
    'imperialpresence': '支线_少女与皇帝',
    'side01': '支线01',
    'side02': '支线02',
    'side03': '支线03',
}

# 提取 .gd 文件里的对话字符串
def extract_dialogs(path):
    with io.open(path, 'r', encoding='utf-8') as f:
        c = f.read()
    out = []
    # show_dialog("...","speaker")
    for m in re.finditer(r'show_dialog\(\s*"((?:[^"\\]|\\.)*)"\s*,\s*"((?:[^"\\]|\\.)*)"', c):
        text = m.group(1).replace('\\n', '\n').replace('\\"', '"')
        spk = m.group(2).replace('\\"', '"')
        out.append(('dialog', spk, text))
    # enter_center_performance_mode([...]) 里的旁白
    for m in re.finditer(r'enter_center_performance_mode\(\s*\[(.*?)\]\s*,', c, re.S):
        body = m.group(1)
        for s in re.finditer(r'"((?:[^"\\]|\\.)*)"', body):
            text = s.group(1).replace('\\n', '\n').replace('\\"', '"')
            out.append(('narration', '', text))
    # briefing
    for m in re.finditer(r'enter_briefing_performance_mode\(\s*"((?:[^"\\]|\\.)*)"\s*,\s*"((?:[^"\\]|\\.)*)"', c):
        out.append(('briefing', m.group(2), m.group(1)))
    return out

stats = []
total_dialogs = 0

for ch in sorted(os.listdir(SRC)):
    chdir = os.path.join(SRC, ch)
    if not os.path.isdir(chdir):
        continue
    zh_name = CHAPTER_NAMES.get(ch, ch)
    # 只取中文原版（无语言后缀）
    files = [f for f in os.listdir(chdir) if f.endswith('.gd') and not re.search(r'_[a-z]{2}\.gd$', f)]
    files.sort()
    lines = []
    lines.append('# 《魔女兵器》%s' % zh_name)
    lines.append('')
    lines.append('> 来源：Godot 剧情复刻项目 `YANG301/Witch-Weapon-Godot-`（witchweapon.wiki）')
    lines.append('> 共 %d 话' % len(files))
    lines.append('')
    lines.append('---')
    lines.append('')
    n_dlg = 0
    for fn in files:
        ep = fn[:-3]
        path = os.path.join(chdir, fn)
        dlg = extract_dialogs(path)
        if not dlg:
            continue
        lines.append('## %s' % ep)
        lines.append('')
        for kind, spk, text in dlg:
            if kind == 'dialog':
                lines.append('**%s**：%s' % (spk, text.replace('\n', '  \n')))
                lines.append('')
            elif kind == 'narration':
                lines.append('> %s' % text.replace('\n', '  \n> '))
                lines.append('')
            elif kind == 'briefing':
                lines.append('**【%s】** %s' % (spk, text))
                lines.append('')
            n_dlg += 1
        lines.append('')
    outfile = os.path.join(OUT, '%s.md' % zh_name)
    with io.open(outfile, 'w', encoding='utf-8') as f:
        f.write('\n'.join(lines))
    size = os.path.getsize(outfile)
    stats.append((zh_name, len(files), n_dlg, size))
    total_dialogs += n_dlg

print('=== 提取结果 ===')
print('%-34s %6s %8s %12s' % ('章节', '话数', '对话数', '大小'))
for name, nf, nd, sz in stats:
    print('%-34s %6d %8d %10.1f KB' % (name, nf, nd, sz/1024))
print()
print('总计: %d 章, %d 条对话' % (len(stats), total_dialogs))

# 合并总文件
allmd = os.path.join(OUT, '魔女兵器_完整剧情.md')
with io.open(allmd, 'w', encoding='utf-8') as out:
    out.write('# 《魔女兵器》完整剧情文本\n\n')
    out.write('> 来源：Godot 剧情复刻项目 `YANG301/Witch-Weapon-Godot-`（https://www.witchweapon.wiki/）\n')
    out.write('> 提取时间：2026-10-08\n')
    out.write('> 总计：%d 章 / %d 条对话\n\n' % (len(stats), total_dialogs))
    out.write('---\n\n')
    for name, nf, nd, sz in stats:
        p = os.path.join(OUT, '%s.md' % name)
        with io.open(p, 'r', encoding='utf-8') as f:
            out.write(f.read())
        out.write('\n\n---\n\n')
print('合并文件: %s (%.1f MB)' % (allmd, os.path.getsize(allmd)/1024/1024))
