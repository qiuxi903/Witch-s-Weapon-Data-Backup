# 把 部署/ 打包成一个可以直接丢给宝塔解压的 zip
#
#   python tools/make-archive.py                     # 全量（987 MB）
#   python tools/make-archive.py files               # 只打 files/（补传用）
#   python tools/make-archive.py files 补传包.zip     # 自定义输出名
#
# 关键点：Windows 自带的「压缩到 zip」用 GBK 编码文件名，Linux 解压后中文目录
# 全变乱码。这里用 Python 的 zipfile —— 非 ASCII 文件名会自动带上 UTF-8 标志位
# （general purpose bit 11），Windows 资源管理器、7-Zip、Linux unzip / 宝塔
# 文件管理器都能正确还原。
#
# 压缩策略：文本类（html/css/js/json/md）用 deflate，其余（webp/ogg/mp3/mp4）
# 本身已是压缩格式，直接 store，省掉几个小时的无效 CPU。
import io, os, sys, time, zipfile

R    = r'G:\project\其他\game'
SRC  = os.path.join(R, '部署')
TOP  = 'witchweapon'                 # zip 内的顶层目录名

SUBDIR = sys.argv[1].strip('/\\') if len(sys.argv) > 1 else ''
if SUBDIR:
    SRC = os.path.join(SRC, SUBDIR.replace('/', os.sep))
    TOP = TOP + '/' + SUBDIR.replace(os.sep, '/')
    DEFAULT_OUT = '魔女兵器档案站_%s补传包.zip' % SUBDIR.replace('/', '_')
else:
    DEFAULT_OUT = '魔女兵器档案站_部署包.zip'
OUT = os.path.join(R, sys.argv[2] if len(sys.argv) > 2 else DEFAULT_OUT)

TEXT_EXT = {'.html', '.htm', '.css', '.js', '.mjs', '.json', '.md',
            '.txt', '.xml', '.svg', '.csv'}

sys.stdout.reconfigure(encoding='utf-8', errors='replace')


def main():
    if not os.path.isdir(SRC):
        print('！ 找不到 %s' % SRC)
        return 1

    files = []
    for dp, dns, fs in os.walk(SRC):
        for f in fs:
            p = os.path.join(dp, f)
            files.append((p, os.path.relpath(p, SRC)))
    files.sort(key=lambda x: x[1])
    total = sum(os.path.getsize(p) for p, _ in files)
    print('  待打包 %d 个文件 / %.1f MB' % (len(files), total / 1048576))
    print('  输出   %s' % OUT)

    t0 = time.time()
    done = 0
    with zipfile.ZipFile(OUT, 'w', allowZip64=True) as z:
        for p, rel in files:
            arc = TOP + '/' + rel.replace(os.sep, '/')
            ext = os.path.splitext(rel)[1].lower()
            comp = (zipfile.ZIP_DEFLATED if ext in TEXT_EXT
                    else zipfile.ZIP_STORED)
            zi = zipfile.ZipInfo.from_file(p, arc)
            zi.compress_type = comp
            # 固定时间戳，保证同样内容打出的包字节一致
            zi.date_time = (2024, 8, 17, 0, 0, 0)
            zi.external_attr = (0o644 << 16)
            with open(p, 'rb') as fh, z.open(zi, 'w') as w:
                while True:
                    b = fh.read(1 << 20)
                    if not b:
                        break
                    w.write(b)
            done += 1
            if done % 2000 == 0:
                print('    %6d / %d  (%.0f%%)  %.0f 秒'
                      % (done, len(files), done * 100.0 / len(files),
                         time.time() - t0))

    size = os.path.getsize(OUT)
    print('  完成：%d 个文件 / %.1f MB / 耗时 %.0f 秒'
          % (len(files), size / 1048576, time.time() - t0))

    # 自检：文件名能正确读回，且非 ASCII 名带 UTF-8 标志位
    print()
    print('=== 自检 ===')
    with zipfile.ZipFile(OUT) as z:
        names = z.namelist()
        print('  条目数 %d' % len(names))
        cn = [n for n in names if any(ord(c) > 127 for c in n)]
        print('  含中文名的条目 %d 个' % len(cn))
        for n in cn[:3]:
            print('    例：%s' % n)
        bad = z.testzip()
        print('  CRC 校验：%s' % ('全部通过' if bad is None else ('损坏 ' + bad)))
        info = z.getinfo(cn[0]) if cn else None
        if info:
            print('  UTF-8 标志位(bit 11)：%s'
                  % ('已设置' if info.flag_bits & 0x800 else '未设置'))
    return 0


if __name__ == '__main__':
    sys.exit(main())
