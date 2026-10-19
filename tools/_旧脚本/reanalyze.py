# 重新审视：密文可能是"小整数序列"而非加密文本
import io, os, sys, struct
from collections import Counter

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

d = open(r'G:\project\其他\game\提取资源\怀旧服v128_导出\新剧情\sentence_30319.bytes', 'rb').read()
print('数据 %d 字节' % len(d))
print('前 64: %s' % d[:64].hex())
print()

# 观察：0x00-0x1F 占 30%，像是"控制码/长度"
# 高半字节分布显示 1,4,5,6,7 主导 —— 这像是 UTF-8 的延续字节区(0x80-0xBF)被减去了什么
# 
# 关键洞察：UTF-8 中文是 3 字节 E4-E9 xx xx，其中 xx 在 0x80-0xBF
# 如果每个字节 >> 1 或 & 0x7F...

print('=== 假设：每字节是原始字节的某种变换 ===')
print()

# 试：如果这是 UTF-8 中文，第一字节应是 E4-E9 (228-233)
# 密文前几字节: ce f6 b1 d0 be bf 1a 42 ...
# 0xce=206, 0xf6=246, 0xb1=177, 0xd0=208, 0xbe=190, 0xbf=191
# 对比 UTF-8 中文 "『异质���』" = e3 80 8e e5 bc 82 e8 b4 a8 e7 89 a9 e3 80 8f
# 密文长度 31246，如果明文是 UTF-8，长度应相近

# 试各种简单变换
tests = {
    'raw': lambda x: x,
    'xor_ff': lambda x: x ^ 0xFF,
    'not': lambda x: 255 - x,
    'rshift1': lambda x: x >> 1,
    'lshift1': lambda x: (x << 1) & 0xFF,
    'sub_0x80': lambda x: (x - 0x80) & 0xFF,
    'add_0x80': lambda x: (x + 0x80) & 0xFF,
    'swap_nibble': lambda x: ((x & 0x0F) << 4) | (x >> 4),
}

for name, fn in tests.items():
    t = bytes(fn(b) for b in d)
    try:
        s = t.decode('utf-8')
        cjk = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
        print('  %-14s CJK=%6d / %6d 字符' % (name, cjk, len(s)))
        if cjk > 50:
            print('      ' + s[:150].replace('\n',' '))
    except UnicodeDecodeError as e:
        print('  %-14s 解码失败' % name)

print()
print('=== 字节值分布（前 20 高频）===')
c = Counter(d)
for b, n in c.most_common(20):
    print('  0x%02X (%3d): %6d  %.2f%%' % (b, b, n, n*100/len(d)))

print()
print('=== 是否所有字节都 < 0x80？ ===')
print('  最大字节: 0x%02X' % max(d))
print('  >= 0x80 的字节数: %d' % sum(1 for b in d if b >= 0x80))
