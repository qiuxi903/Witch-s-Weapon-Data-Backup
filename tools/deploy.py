# 生成自包含的部署目录：WW_DEPLOY=1 重建全部页面 → 输出到 部署/
#
# 目录结构：
#   部署/
#   ├── 12 个 html + logo.png + _说明.md
#   ├── css/ js/ data/      （样式、脚本、配置表数据）
#   ├── thumbs/             （7,410 张 WebP 缩略图）
#   └── files/              （全部素材：图片 WebP、音频 ogg+mp3、视频原样）
#
# 用法：
#   python tools/deploy-assets.py all    # 先转换素材（首次或素材变动时）
#   python tools/deploy.py               # 再重建页面
import io, os, sys, shutil, subprocess, time

R    = r'G:\project\其他\game'
PY   = sys.executable
DEST = os.path.join(R, '部署')
SRC  = os.path.join(R, '网站')
sys.stdout.reconfigure(encoding='utf-8', errors='replace')

STEPS = [
    ('site-css.py',         '样式表'),
    ('site-js.py',          '交互脚本'),
    ('site-characters.py',  '角色页'),
    ('site-story.py',       '剧情页'),
    ('site-index.py',       '首页'),
    ('site-pages-a.py',     '美术/音频/视频/漫画'),
    ('site-config.py',      '配置表'),
    ('site-pages-c.py',     '系统设计/全部文件'),
    ('site-news.py',        '官网公告'),
    ('site-relics.py',      '开发遗迹'),
]

EXTRA = []                    # 额外搬过去的文件（文档由 deploy-doc.py 生成）


def size_of(p):
    t = n = 0
    for dp, _, fs in os.walk(p):
        for f in fs:
            n += 1
            try:
                t += os.path.getsize(os.path.join(dp, f))
            except OSError:
                pass
    return t, n


def main():
    if not os.path.isdir(os.path.join(DEST, 'files')):
        print('！ 部署/files 不存在，请先运行：')
        print('    python tools/deploy-assets.py all')
        return 1

    env = dict(os.environ, WW_DEPLOY='1')
    os.makedirs(DEST, exist_ok=True)

    # 站点 LOGO
    for f in ['logo.png'] + EXTRA:
        s = os.path.join(SRC, f)
        if os.path.exists(s):
            shutil.copy2(s, os.path.join(DEST, f))
            print('  复制 %s' % f)

    t0 = time.time()
    for script, label in STEPS:
        p = os.path.join(R, 'tools', script)
        if not os.path.exists(p):
            print('  [跳过] %s（脚本不存在）' % script)
            continue
        r = subprocess.run([PY, '-X', 'utf8', p], env=env,
                           capture_output=True)
        out = r.stdout.decode('utf-8', 'replace').strip()
        err = r.stderr.decode('utf-8', 'replace').strip()
        tail = [x for x in out.split('\n') if x.strip()][-1:] if out else []
        status = 'OK ' if r.returncode == 0 else 'ERR'
        print('  %s %-12s %s' % (status, label, tail[0].strip() if tail else ''))
        if r.returncode != 0 or err:
            print('       %s' % (err[:400] if err else '（无输出）'))

    # 文档：部署版 _说明.md + 部署指南.md
    docp = os.path.join(R, 'tools', 'deploy-doc.py')
    if os.path.exists(docp):
        r = subprocess.run([PY, '-X', 'utf8', docp], capture_output=True)
        out = r.stdout.decode('utf-8', 'replace').strip()
        for line in [x for x in out.split('\n') if x.strip()]:
            print(line)
        if r.returncode != 0:
            print('  ERR 文档生成失败')
            print('      %s' % r.stderr.decode('utf-8', 'replace')[:400])

    # 汇总
    print()
    print('=== 部署目录构成 ===')
    tot = tn = 0
    for e in sorted(os.listdir(DEST)):
        p = os.path.join(DEST, e)
        if os.path.isdir(p):
            s, n = size_of(p)
        else:
            s, n = os.path.getsize(p), 1
        tot += s
        tn += n
        print('  %-18s %7d 个 %10.1f MB' % (e + ('/' if os.path.isdir(p) else ''),
                                            n, s / 1048576))
    print('  %-18s %7d 个 %10.1f MB' % ('合计', tn, tot / 1048576))
    print()
    print('  耗时 %.1f 秒' % (time.time() - t0))
    return 0


if __name__ == '__main__':
    sys.exit(main())
