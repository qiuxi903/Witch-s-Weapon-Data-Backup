import io, sys, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

p = r'G:\project\其他\game\提取资源\国服v2.0.1_完整解包\assets\assetbundle\config\lesson\sentence_00001.ab'
with open(p, 'rb') as f:
    raw = f.read()
print('文件大小:', len(raw))

i = raw.find(b'sentence_00001')
print('sentence_00001 位置:', i)
print('  该处字节:', raw[i:i+20].hex())
print('  ASCII:', repr(raw[i:i+20]))

# 看看 00001 附近
for off in range(max(0,i-8), min(len(raw), i+24)):
    print('  %d (0x%X): 0x%02X %s' % (off, off, raw[off], chr(raw[off]) if 32 <= raw[off] < 127 else '.'))

print()
print('=== 检查 m_Name 之后的实际布局 ===')
# Unity 的 MonoBehaviour 序列化：
#   m_GameObject (PPtr: 4+8=12 bytes, 对齐到4)
#   m_Enabled (1 byte + 3 padding)
#   m_Script (PPtr: 12 bytes)
#   m_Name (string: 4字节长度 + 数据 + 对齐)
#   bytes (数组: 4字节长度 + 数据)
#   isEncrypt (bool)
# 但我们看到 m_Name �� 1695，前面是 "sentence_00001\0\0"
# 实际 m_Name 的 4 字节长度在 1691
ln_name = struct.unpack_from('<I', raw, 1691)[0]
print('  m_Name 长度字段 @1691 = %d' % ln_name)
# 数据从 1695 开始，14 字节 'sentence_00001'，然后对齐到 4
name_end = 1695 + ln_name
print('  m_Name 数据结束 @%d' % name_end)
pad = (4 - (name_end % 4)) % 4
nxt = name_end + pad
print('  对齐后 @%d' % nxt)
b = raw[nxt:nxt+16]
print('  接下来 16 字节:', b.hex())
ln_bytes = struct.unpack_from('<I', raw, nxt)[0]
print('  解释为长度 = %d (0x%X)' % (ln_bytes, ln_bytes))
