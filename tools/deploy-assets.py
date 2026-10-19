# 把网站引用的素材转换成 Web 友好格式，集中复制到 部署/files/，
# 并输出 tools/_deploy_map.json 供 site_lib 在部署模式下解析路径。
#
#   python tools/deploy-assets.py images   # PNG/JPG → WebP
#   python tools/deploy-assets.py audio    # WAV → Opus(.ogg) + MP3(回退)
#   python tools/deploy-assets.py thumbs   # 缩略图 → WebP
#   python tools/deploy-assets.py copy     # 视频等不转换的直接复制
#   python tools/deploy-assets.py map      # 汇总生成 _deploy_map.json
import io, os, sys, re, json, shutil, hashlib, subprocess, urllib.parse
from collections import defaultdict

R      = r'G:\project\其他\game'
SITE   = os.path.join(R, '网站')
DEST   = os.path.join(R, '部署')
FILES  = os.path.join(DEST, 'files')
FFMPEG = os.path.join(R, 'tools', '_bin', 'ffmpeg.exe')
MAPF   = os.path.join(R, 'tools', '_deploy_map.json')

IMG_EXT = {'.png', '.jpg', '.jpeg', '.bmp', '.gif'}
AUD_EXT = {'.wav'}
VID_EXT = {'.mp4', '.ogv', '.webm'}
WEBP_Q  = 82          # 图片质量
OPUS_K  = '64k'       # Opus 码率
MP3_K   = '96k'       # MP3 回退码率

sys.stdout.reconfigure(encoding='utf-8', errors='replace')


def collect_refs():
    """扫出全部 HTML 里指向仓库其他目录的引用（../xxx）"""
    attr = re.compile(r'[a-zA-Z_:][-a-zA-Z0-9_:.]*="([^"]*)"')
    refs = set()
    for f in sorted(os.listdir(SITE)):
        if not f.endswith('.html'):
            continue
        txt = io.open(os.path.join(SITE, f), encoding='utf-8',
                      errors='replace').read()
        for m in attr.finditer(txt):
            u = m.group(1)
            if u.startswith('../'):
                refs.add(urllib.parse.unquote(u[3:]).replace('/', os.sep))
    return sorted(refs)


def classify(refs):
    """按扩展名分组，并处理输出名冲突"""
    img, aud, vid, other = [], [], [], []
    for rel in refs:
        ext = os.path.splitext(rel)[1].lower()
        (img if ext in IMG_EXT else
         aud if ext in AUD_EXT else
         vid if ext in VID_EXT else other).append(rel)

    # 转换后可能撞名（a.png 与 a.jpg 都变成 a.webp），用短哈希消歧
    def stem_out(rel, newext):
        d, b = os.path.split(rel)
        return os.path.join(d, os.path.splitext(b)[0] + newext)

    seen = defaultdict(list)
    for rel in img:
        seen[stem_out(rel, '.webp').lower()].append(rel)
    clash = {k for k, v in seen.items() if len(v) > 1}
    if clash:
        print('  [注意] %d 组图片转换后会撞名，加哈希后缀' % len(clash))

    out = {}
    for rel in img:
        base = stem_out(rel, '.webp')
        if base.lower() in clash:
            d, b = os.path.split(base)
            base = os.path.join(d, os.path.splitext(b)[0] + '_'
                                + hashlib.md5(rel.encode('utf-8')).hexdigest()[:6]
                                + '.webp')
        out[rel] = base
    return img, out, aud, vid, other


# ---------- 图片 ----------

def _img_job(args):
    rel, dst = args
    from PIL import Image, ImageFile
    ImageFile.LOAD_TRUNCATED_IMAGES = True      # 官网抓取的个别 PNG 是截断的
    src = os.path.join(R, rel)
    try:
        im = Image.open(src)
        im.load()
        if im.mode == 'P':
            im = im.convert('RGBA' if 'transparency' in im.info else 'RGB')
        elif im.mode not in ('RGB', 'RGBA'):
            im = im.convert('RGBA' if 'A' in im.getbands() else 'RGB')
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        im.save(dst, 'WEBP', quality=WEBP_Q, method=4)
        return (rel, os.path.getsize(src), os.path.getsize(dst), None)
    except Exception:
        # 兜底：实在转不了就按原格式复制，页面照样能显示
        try:
            alt = os.path.splitext(dst)[0] + os.path.splitext(rel)[1].lower()
            os.makedirs(os.path.dirname(alt), exist_ok=True)
            shutil.copy2(src, alt)
            return (rel, os.path.getsize(src), os.path.getsize(alt),
                    'fallback:' + os.path.basename(alt))
        except Exception as e:
            return (rel, os.path.getsize(src) if os.path.exists(src) else 0, 0,
                    '%s: %s' % (type(e).__name__, e))


def do_images(only_missing=False):
    from concurrent.futures import ProcessPoolExecutor
    refs = collect_refs()
    img, out, aud, vid, other = classify(refs)
    jobs = [(rel, os.path.join(FILES, out[rel])) for rel in img]
    if only_missing:
        jobs = [j for j in jobs
                if not os.path.exists(j[1])
                and not os.path.exists(os.path.splitext(j[1])[0]
                                       + os.path.splitext(j[0])[1].lower())]
        print('图片：只补缺失的 %d 个' % len(jobs))
    else:
        print('图片 %d 个 → WebP（质量 %d）' % (len(jobs), WEBP_Q))
    if not jobs:
        return
    so = sn = 0
    errs = []
    with ProcessPoolExecutor(max_workers=8) as ex:
        for i, (rel, s, n, err) in enumerate(ex.map(_img_job, jobs, chunksize=8), 1):
            so += s
            sn += n
            if err:
                errs.append((rel, err))
            if i % 500 == 0 or i == len(jobs):
                print('  %5d/%d  %.0f%%  %s → %s'
                      % (i, len(jobs), 100.0 * i / len(jobs),
                         '{:.0f}MB'.format(so / 1048576),
                         '{:.0f}MB'.format(sn / 1048576)))
    print('  完成：%.1f MB → %.1f MB（省 %.0f%%）'
          % (so / 1048576, sn / 1048576, 100 - 100.0 * sn / max(so, 1)))
    if errs:
        print('  未转换 %d 个（已按原格式复制）：%s' % (len(errs), errs[:3]))


# ---------- 音频 ----------

def _run_ff(args):
    p = subprocess.run([FFMPEG, '-hide_banner', '-loglevel', 'error', '-y'] + args,
                       capture_output=True)
    return p.returncode, p.stderr.decode('utf-8', 'replace')


def _aud_job(args):
    rel, dst_ogg, dst_mp3 = args
    src = os.path.join(R, rel)
    os.makedirs(os.path.dirname(dst_ogg), exist_ok=True)
    s = os.path.getsize(src)
    rc1, e1 = _run_ff(['-i', src, '-c:a', 'libopus', '-b:a', OPUS_K,
                       '-vbr', 'on', '-application', 'audio', dst_ogg])
    rc2, e2 = _run_ff(['-i', src, '-c:a', 'libmp3lame', '-b:a', MP3_K,
                       '-joint_stereo', '1', dst_mp3])
    if rc1 != 0 or rc2 != 0:
        return (rel, s, 0, 0, (e1 or e2)[:120])
    return (rel, s, os.path.getsize(dst_ogg), os.path.getsize(dst_mp3), None)


def do_audio():
    from concurrent.futures import ProcessPoolExecutor
    refs = collect_refs()
    img, out, aud, vid, other = classify(refs)
    jobs = []
    for rel in aud:
        d, b = os.path.split(rel)
        st = os.path.splitext(b)[0]
        jobs.append((rel, os.path.join(FILES, d, st + '.ogg'),
                     os.path.join(FILES, d, st + '.mp3')))
    print('音频 %d 个 → Opus %s + MP3 %s 回退' % (len(jobs), OPUS_K, MP3_K))
    so = sg = sm = 0
    errs = []
    with ProcessPoolExecutor(max_workers=6) as ex:
        for i, (rel, s, g, m, err) in enumerate(ex.map(_aud_job, jobs, chunksize=4), 1):
            so += s; sg += g; sm += m
            if err:
                errs.append((rel, err))
            if i % 100 == 0 or i == len(jobs):
                print('  %5d/%d  %.0f%%  %s → ogg %.0fMB + mp3 %.0fMB'
                      % (i, len(jobs), 100.0 * i / len(jobs),
                         '{:.0f}MB'.format(so / 1048576),
                         sg / 1048576, sm / 1048576))
    print('  完成：%.1f MB → ogg %.1f MB + mp3 %.1f MB（合计省 %.0f%%）'
          % (so / 1048576, sg / 1048576, sm / 1048576,
             100 - 100.0 * (sg + sm) / max(so, 1)))
    if errs:
        print('  失败 %d 个：%s' % (len(errs), errs[:5]))


# ---------- 缩略图 ----------

def _thumb_job(args):
    src, dst = args
    from PIL import Image
    try:
        im = Image.open(src); im.load()
        if im.mode not in ('RGB', 'RGBA'):
            im = im.convert('RGB')
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        im.save(dst, 'WEBP', quality=80, method=4)
        return (os.path.getsize(src), os.path.getsize(dst), None)
    except Exception as e:
        return (0, 0, str(e)[:80])


def do_thumbs():
    from concurrent.futures import ProcessPoolExecutor
    src_dir = os.path.join(SITE, 'thumbs')
    dst_dir = os.path.join(DEST, 'thumbs')
    files = [f for f in os.listdir(src_dir) if f.lower().endswith('.jpg')]
    jobs = [(os.path.join(src_dir, f),
             os.path.join(dst_dir, os.path.splitext(f)[0] + '.webp')) for f in files]
    print('缩略图 %d 张 → WebP' % len(jobs))
    so = sn = 0
    errs = 0
    with ProcessPoolExecutor(max_workers=8) as ex:
        for i, (s, n, err) in enumerate(ex.map(_thumb_job, jobs, chunksize=16), 1):
            so += s; sn += n
            if err:
                errs += 1
            if i % 1000 == 0 or i == len(jobs):
                print('  %5d/%d  %.0f%%  %s → %s'
                      % (i, len(jobs), 100.0 * i / len(jobs),
                         '{:.0f}MB'.format(so / 1048576),
                         '{:.0f}MB'.format(sn / 1048576)))
    print('  完成：%.1f MB → %.1f MB' % (so / 1048576, sn / 1048576))
    if errs:
        print('  失败 %d 张' % errs)


# ---------- 直接复制 ----------

def do_copy():
    """视频、以及已是 Web 格式的文件，原样复制"""
    refs = collect_refs()
    img, out, aud, vid, other = classify(refs)
    todo = [(rel, rel) for rel in vid + other]
    # 已经是 mp3/webp 的音频图片也不转换
    for rel in refs:
        e = os.path.splitext(rel)[1].lower()
        if e in ('.mp3', '.webp', '.ogg'):
            todo.append((rel, rel))
    n = s = 0
    for rel, o in todo:
        src = os.path.join(R, rel)
        dst = os.path.join(FILES, o)
        if not os.path.isfile(src):
            continue
        os.makedirs(os.path.dirname(dst), exist_ok=True)
        if not os.path.exists(dst):
            shutil.copy2(src, dst)
        n += 1; s += os.path.getsize(src)
    print('直接复制 %d 个文件，%.1f MB' % (n, s / 1048576))


# ---------- 映射表 ----------

def _real_out(rel, preferred):
    """转换失败时会按原格式复制，这里以磁盘上真实存在的为准"""
    for c in (preferred,
              os.path.splitext(preferred)[0] + os.path.splitext(rel)[1].lower()):
        if os.path.exists(os.path.join(FILES, c)):
            return c
    return preferred


def do_map():
    refs = collect_refs()
    img, out, aud, vid, other = classify(refs)
    m = {}
    for rel in img:
        m[rel.replace(os.sep, '/')] = \
            [('files/' + _real_out(rel, out[rel])).replace(os.sep, '/')]
    for rel in aud:
        d, b = os.path.split(rel)
        st = os.path.splitext(b)[0]
        r = lambda x: ('files/' + os.path.join(d, x)).replace(os.sep, '/')
        m[rel.replace(os.sep, '/')] = [r(st + '.ogg'), r(st + '.mp3')]
    for rel in vid + other:
        m[rel.replace(os.sep, '/')] = ['files/' + rel.replace(os.sep, '/')]
    for rel in refs:                      # 已是 mp3/webp/ogg
        e = os.path.splitext(rel)[1].lower()
        if e in ('.mp3', '.webp', '.ogg'):
            m[rel.replace(os.sep, '/')] = ['files/' + rel.replace(os.sep, '/')]
    io.open(MAPF, 'w', encoding='utf-8').write(
        json.dumps(m, ensure_ascii=False, indent=0))
    print('映射表：%d 条 → %s' % (len(m), MAPF))


if __name__ == '__main__':
    cmd = sys.argv[1] if len(sys.argv) > 1 else 'all'
    os.makedirs(FILES, exist_ok=True)
    if cmd in ('images', 'all'):
        do_images()
    if cmd == 'images-missing':
        do_images(only_missing=True)
    if cmd in ('audio', 'all'):
        if not os.path.exists(FFMPEG):
            print('缺少 ffmpeg：%s' % FFMPEG)
        else:
            do_audio()
    if cmd in ('thumbs', 'all'):
        do_thumbs()
    if cmd in ('copy', 'all'):
        do_copy()
    if cmd in ('map', 'all'):
        do_map()
