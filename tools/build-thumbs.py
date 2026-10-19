# 生成全站图片缩略图（Pillow）
# - 640px 宽 JPEG q82，白底合成透明 PNG
# - 命名 = 相对路径 md5，避免编码问题
# - 跳过已存在的
import io, os, sys, json, hashlib

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

R    = r'G:\project\其他\game'
SITE = os.path.join(R, '网站')
THD  = os.path.join(SITE, 'thumbs')
os.makedirs(THD, exist_ok=True)

from PIL import Image, ImageOps
Image.MAX_IMAGE_PIXELS = 400_000_000  # 防 decompression-bomb 误杀大图

ASSETS = json.load(io.open(os.path.join(R, 'tools', '_asset_index.json'), encoding='utf-8'))
IMETA  = json.load(io.open(os.path.join(R, 'tools', '_image_meta.json'), encoding='utf-8'))

imgs = [a for a in ASSETS if a['k'] == 'image']
print('待处理 %d 张' % len(imgs))

MAP = {}   # relpath -> thumb filename
skip = 0; fail = 0; done = 0

for i, a in enumerate(imgs):
    rel = a['p']
    src = os.path.join(R, rel.replace('/', os.sep))
    h = hashlib.md5(rel.encode('utf-8')).hexdigest()[:16]
    tname = h + '.jpg'
    MAP[rel] = tname
    tpath = os.path.join(THD, tname)
    if os.path.exists(tpath) and os.path.getsize(tpath) > 0:
        skip += 1
        continue
    if not os.path.exists(src):
        fail += 1
        continue
    try:
        im = Image.open(src)
        im = ImageOps.exif_transpose(im)
        has_alpha = im.mode in ('RGBA', 'LA', 'P') and (
            im.mode != 'P' or 'transparency' in im.info)
        if has_alpha:
            im = im.convert('RGBA')
            bg = Image.new('RGB', im.size, (250, 250, 251))
            bg.paste(im, mask=im.split()[3])
            im = bg
        else:
            im = im.convert('RGB')
        w, hh = im.size
        if w > 640:
            nh = max(1, round(hh * 640.0 / w))
            im = im.resize((640, nh), Image.LANCZOS)
        im.save(tpath, 'JPEG', quality=82, optimize=True)
        done += 1
    except Exception as e:
        fail += 1
        MAP[rel] = None
    if (i + 1) % 500 == 0:
        print('  %d / %d (完成 %d, 跳过 %d, 失败 %d)' % (i + 1, len(imgs), done, skip, fail))

json.dump(MAP, io.open(os.path.join(R, 'tools', '_thumb_map.json'), 'w', encoding='utf-8'),
          separators=(',', ':'))
n_files = len([f for f in os.listdir(THD) if f.endswith('.jpg')])
sz = sum(os.path.getsize(os.path.join(THD, f)) for f in os.listdir(THD))
print('完成 %d, 跳过 %d, 失败 %d' % (done, skip, fail))
print('缩略图 %d 个 / %.1f MB' % (n_files, sz / 1024 / 1024))