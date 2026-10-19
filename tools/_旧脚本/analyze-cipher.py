import io, re, json, sys, collections

p = r'G:\project\其他\game\提取资源\导出_剧情文本_国服\assets\_temp_config\config\lesson\sentence_30219.json'
with io.open(p, 'r', encoding='utf-8') as f:
    txt = f.read()

m = re.search(r'"bytes":\s*\[([^\]]+)\]', txt)
nums = [int(x.strip()) for x in m.group(1).split(',')]
print('total bytes:', len(nums))

# 1) 检查是否所有字节都非零 —— 说明可能是 stream cipher 或 XOR
print('min =', min(nums), 'max =', max(nums))
print('zero count =', nums.count(0))

# 2) 尝试找重复片段（相同明文 -> 相同密文，说明是 ECB 或固定密钥流）
# 找长度 8 的重复 8-gram
from collections import defaultdict
seen = defaultdict(list)
for i in range(0, len(nums) - 8):
    key = bytes(nums[i:i+8])
    seen[key].append(i)

dups = {k: v for k, v in seen.items() if len(v) > 1}
print('repeated 8-grams:', len(dups))

# 3) 关键测试：如果这是 XOR 固定密钥流，���么重复片段的间隔应该等于密钥周期
if dups:
    gaps = []
    for k, v in list(dups.items())[:50]:
        for i in range(1, len(v)):
            gaps.append(v[i] - v[i-1])
    gc = collections.Counter(gaps)
    print('most common gaps between repeats:', gc.most_common(10))

# 4) 尝试检测 UTF-8 中文的 XOR 密钥
# 中文 UTF-8 是 3 字节 E4-E9 xx xx
# 如果密文 = 明文 XOR key[i % n]，我们可以用已知明文攻击
# 但先看：假设明文以 "{" 开头（JSON）或 protobuf field tag
print()
print('first 32 bytes:', [hex(x) for x in nums[:32]])

# 5) 尝试：密文是否 = 明文 + key （模 256）
# 中文 UTF-8 首字节 E4-E9，若密文常见 0x1C/0x1A，则 key ≈ 0x1C - 0xE4 = -0xC8 = 0x38
# 测试 key = 0x38 的减法
for k in [0x38, 0x37, 0x39, 0x36]:
    dec = bytes([(b - k) & 0xFF for b in nums[:80]])
    s = dec.decode('utf-8', errors='replace')
    printable = sum(1 for c in s if c.isprintable() or c in '\n\r\t')
    print('sub key=0x%02X printable=%d  %s' % (k, printable, repr(s[:60])))
