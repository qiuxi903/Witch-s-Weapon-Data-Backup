import io, sys, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

base = r'G:\project\其他\game\提取资源'
p = base + r'\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
i = raw.find(b'sentence_00001')
ln = struct.unpack_from('<H', raw, i+16)[0]
ct = raw[i+20:i+20+ln]

# 观察：0x00-0x13 频繁，0x20-0x3F 几乎不出现
# 这是「7-bit 打包」的典型特征！
# 7-bit 打包：每 8 字节存 7 个 7-bit 值
# 但那样不应该产生 0x00-0x13 的特殊分布...
#
# 另一个可能：这是「UTF-8 文本经过 XOR 后再做 base64 变体」
# 
# 关键测试：0x20-0x3F 缺失意味着什么？
# 如果明文是 UTF-8 中文（0xE4-0xE9, 0x80-0xBF），
# XOR 一个常数 k 后，0xE4^k 和 0x80^k 应该出现
# 我们观察到 0x00-0x1F 多，0x20-0x3F 少
# 
# 假设 k = 0xE4 ^ 0x0? = ... 让 0xE4 -> 0x0x
# 0xE4 ^ 0xE4 = 0x00, 0x80 ^ 0xE4 = 0x64
# 那么 0x64-0x69 应该多，但 0x60-0x7F 占 22%... 有可能

print('=== 测试：明文 UTF-8 中文 XOR 0xE4 ===')
# 假设密文 = 明文 ^ 0xE4 的某种变体
# 但我们已经测过所有单字节 XOR，无 UTF-8 可解码
# 
# 新假设：这是「每个 UTF-8 字节拆成两个 nibble 后重排」
print()
print('=== 检查 nibble 结构 ===')
hi = [b >> 4 for b in ct]
lo = [b & 0xF for b in ct]
import collections
print('  高 nibble:', sorted(collections.Counter(hi).items()))
print('  低 nibble:', sorted(collections.Counter(lo).items()))

# 如果密文是「明文 XOR 后」的，nibble 分布应该均匀
# 观察高 nibble: 0x0(14.4%) 0x1(16.7%) 0x2(2.0%) 0x3(1.8%) ...
# 0x2 和 0x3 极少 —— 这是关键！
# 
# 假设：明文 UTF-8 中文 = E4-E9 80-BF 80-BF
# 高 nibble: E, 8-B, 8-B
# 如果 XOR 0x? 后...
# 
# 试：明文 XOR 0x1? 让 E->F, 8->9
# 
# 关键：0x2 和 0x3 极少说明「明文高 nibble = 0x2 或 0x3 的字节」几乎不存在
# UTF-8 中文里，0x2? 和 0x3? 确实很少（只有 ASCII 标点）
# 所以密文可能 ≈ 明文！
print()
print('=== 检查：密文是否直接就是 UTF-8？（但被某种方式破坏）===')
try:
    s = ct.decode('utf-8')
    print('  可解码!', repr(s[:100]))
except UnicodeDecodeError as e:
    print('  解码失败 @%d: %s' % (e.start, e.reason))
    print('  失败位置前后:', ct[max(0,e.start-20):e.start+20].hex())

# 尝试「跳过某些字节」后解码
print()
print('=== 尝试：每 N 字节跳过 1 字节后解码 ===')
for skip in range(1, 8):
    for phase in range(skip):
        d = bytes(ct[j] for j in range(len(ct)) if j % skip != phase)
        try:
            s = d.decode('utf-8')
            cn = sum(1 for ch in s if '\u4e00' <= ch <= '\u9fff')
            if cn > 20:
                print('  skip=%d phase=%d: %d 汉字' % (skip, phase, cn))
        except UnicodeDecodeError:
            pass
