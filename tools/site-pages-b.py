# 配置表页已拆分到 site-config.py（多区服版，按版本懒加载数据文件）
#
# 运行顺序中本脚本保留为空操作，避免旧流水线调用时报错。
#   python tools/decrypt-config.py      # 解密 5 个区服的配置表 → 03_配置表/<区服>/
#   python tools/site-config.py         # 生成 网站/config.html + 网站/data/cfg-*.js
print('  (配置表页由 site-config.py 生成，本脚本跳过)')
