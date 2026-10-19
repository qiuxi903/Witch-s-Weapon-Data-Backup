import io, sys, struct, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
start = 0x6AF + 4
ln = struct.unpack_from('<I', raw, 0x6AF)[0]
data = raw[start:start+ln]

units = [(data[i] << 8) | data[i+1] for i in range(0, len(data)-1, 2)]
print('单元数:', len(units))

# 观察：CJK 占 45%，说明很多单元已经是"看起来像汉字"的值
# 但真实文本应该 >90% 是汉字/标点
# 差异说明部分单元被变换了

# 关键：检查那些"已经是 CJK"的单元，看它们是否合理
cjk_units = [u for u in units if 0x4E00 <= u <= 0x9FFF]
print('CJK 单元数:', len(cjk_units))
c = collections.Counter(cjk_units)
print('最常见 CJK 单元:')
for k, v in c.most_common(20):
    print('  0x%04X %r x%d' % (k, chr(k), v))

print()
# 如果这些是真实汉字，最常见应该是 的(7684) 了(4E86) 是(662F)
# 观察实际最常见的
print('=== 对比：真实中文高频字 ===')
for ch in '的是了我你不在有个人这':
    print('  %s U+%04X' % (ch, ord(ch)))
