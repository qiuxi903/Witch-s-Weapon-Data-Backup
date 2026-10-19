import io, sys, struct, re, collections

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

# 读取原始 .ab 里的 bytes 字段（不是 JSON 导出）
# 从 UnityFS 中提取 MonoBehaviour 的 bytes
p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()

print('文件大小:', len(raw))
# 找 bytes 数据：从之前分析，bytes[0] 字符串在 586
# MonoBehaviour 数据在文件后部
# 找 'sentence_00001' 在 1695
i = raw.find(b'sentence_00001')
print('m_Name 位置:', i)

# 打印 1695 之后 200 字节
print()
print('=== m_Name 之后的字节 ===')
for j in range(i, min(i+300, len(raw)), 16):
    chunk = raw[j:j+16]
    hexs = ' '.join('%02X' % b for b in chunk)
    asc = ''.join(chr(b) if 32 <= b < 127 else '.' for b in chunk)
    print('  %04X  %-47s  %s' % (j, hexs, asc))

# 找到 bytes 数组的起点：m_Name 之后应该有 4 字节长度 + 数据
print()
print('=== 分析 m_Name 之后的结构 ===')
after = i + len(b'sentence_00001')
# 对齐到 4 字节
pad = (4 - (after % 4)) % 4
after += pad
print('  对齐后位置: %d' % after)
ln = struct.unpack_from('<I', raw, after)[0]
print('  接下来 4 字节 = %d (0x%X)' % (ln, ln))
if 0 < ln < 1000000:
    print('  -> 可能是 bytes 长度')
    data = raw[after+4:after+4+ln]
    print('  数据前 32 字节:', data[:32].hex())
    # 保存
    out = r'G:\project\其他\game\提取资源\sentence_00001_bytes.bin'
    with open(out, 'wb') as f:
        f.write(data)
    print('  已保存到', out, len(data), 'bytes')
