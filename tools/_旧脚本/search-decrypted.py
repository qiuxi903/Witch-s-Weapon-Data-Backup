import io, os, sys, re
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

d = r'G:\project\其他\game\剧情文本_解密版\国服v2.0.1'
kws = ['超常物理现象', '异质物', '神迹', 'DA154', '学园都市']

files = [f for f in os.listdir(d) if f.endswith('.txt')]
print('国服解密文件: %d 个' % len(files))
print()

for kw in kws:
    hits = []
    for f in files:
        c = io.open(os.path.join(d, f), encoding='utf-8').read()
        if kw in c:
            hits.append(f)
    print("'%s' 命中 %d 个文件" % (kw, len(hits)))
    if hits:
        print('   ' + ', '.join(hits[:8]))

print()
print('=== 搜索已知明文行 ===')
for kw in ['一旦满足特定条件', '超常物理现象的信息或载体', '不受任何维度']:
    found = False
    for f in files:
        c = io.open(os.path.join(d, f), encoding='utf-8').read()
        if kw in c:
            print("'%s' -> %s" % (kw, f))
            for ln in c.split('\n'):
                if kw in ln:
                    print('   ' + ln[:250])
            found = True
            break
    if not found:
        print("'%s' -> 未找到" % kw)
