import io, sys, re, struct, subprocess, os

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

so = r'G:\project\其他\game\提取资源\国服DLL\libil2cpp.so'
print('查找 libil2cpp.so ...')
if not os.path.exists(so):
    # 从 APK 提取
    apk = r'G:\project\其他\game\安装包\魔女兵器_WitchsWeapon_v2.0.1_国服_九游版_com.shuiqinling.ww.android.cn00.apk'
    import zipfile
    with zipfile.ZipFile(apk) as z:
        with z.open('lib/arm64-v8a/libil2cpp.so') as src, open(so, 'wb') as dst:
            dst.write(src.read())
    print('  已从 APK 提取')
else:
    print('  已存在')

with open(so, 'rb') as f:
    data = f.read()
print('libil2cpp.so 大小:', len(data))
print()

print('=== 在 .so 中搜索 toDecrypt / EncryptTools ===')
for kw in [b'toDecrypt', b'toEncrypt', b'EncryptTools', b'useMD5', b'bytesEncrypt']:
    idxs = []
    start = 0
    while True:
        i = data.find(kw, start)
        if i < 0: break
        idxs.append(i); start = i+1
        if len(idxs) > 30: break
    print('  %-14s x%-4d 位置: %s' % (kw.decode(), len(idxs), [hex(x) for x in idxs[:10]]))

print()
print('=== 搜索 .so 中的可读字符串（含 Decrypt）===')
found = set()
for m in re.finditer(rb'[\x20-\x7e]{5,80}', data):
    s = m.group().decode('ascii')
    if 'ecrypt' in s or 'ncrypt' in s:
        found.add(s)
for s in sorted(found)[:60]:
    print('  ', s)
