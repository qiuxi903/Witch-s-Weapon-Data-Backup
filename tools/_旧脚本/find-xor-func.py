import io, sys, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

so = r'G:\project\其他\game\提取资源\国服DLL\libil2cpp.so'
with open(so, 'rb') as f:
    data = f.read()

def decode(insn, addr):
    if insn == 0xD503201F: return 'nop'
    if insn == 0xD65F03C0: return 'ret'
    if (insn & 0xFC000000) == 0x14000000:
        imm = insn & 0x03FFFFFF
        if imm & 0x02000000: imm -= 0x04000000
        return 'b 0x%X' % (addr + imm*4)
    if (insn & 0xFC000000) == 0x94000000:
        imm = insn & 0x03FFFFFF
        if imm & 0x02000000: imm -= 0x04000000
        return 'bl 0x%X' % (addr + imm*4)
    if (insn & 0x9F000000) == 0x90000000:
        rd = insn & 0x1F
        immlo = (insn >> 29) & 3
        immhi = (insn >> 5) & 0x7FFFF
        imm = (immhi << 2) | immlo
        if imm & 0x100000: imm -= 0x200000
        return 'adrp x%d, 0x%X' % (rd, (addr & ~0xFFF) + (imm << 12))
    if (insn & 0x7F000000) == 0x11000000:
        rd = insn & 0x1F; rn = (insn >> 5) & 0x1F
        imm = (insn >> 10) & 0xFFF; sh = (insn >> 22) & 1
        return 'add x%d, x%d, #%d%s' % (rd, rn, imm, ', lsl 12' if sh else '')
    if (insn & 0xFFC00000) == 0xF9400000:
        rt = insn & 0x1F; rn = (insn >> 5) & 0x1F
        return 'ldr x%d, [x%d, #%d]' % (rt, rn, ((insn >> 10) & 0xFFF)*8)
    if (insn & 0xFFC00000) == 0xF9000000:
        rt = insn & 0x1F; rn = (insn >> 5) & 0x1F
        return 'str x%d, [x%d, #%d]' % (rt, rn, ((insn >> 10) & 0xFFF)*8)
    if (insn & 0xFFE0FFE0) == 0xAA0003E0:
        return 'mov x%d, x%d' % (insn & 0x1F, (insn >> 16) & 0x1F)
    if (insn & 0x7F800000) == 0x52800000:
        return 'movz x%d, #0x%X, lsl %d' % (insn & 0x1F, (insn >> 5) & 0xFFFF, ((insn >> 21) & 3)*16)
    if (insn & 0xFF000010) == 0x54000000:
        imm = (insn >> 5) & 0x7FFFF
        if imm & 0x40000: imm -= 0x80000
        cond = ['eq','ne','cs','cc','mi','pl','vs','vc','hi','ls','ge','lt','gt','le','al','nv'][insn & 0xF]
        return 'b.%s 0x%X' % (cond, addr + imm*4)
    if (insn & 0xFFE0001F) == 0x2A0003E0:
        return 'mov w%d, w%d' % (insn & 0x1F, (insn >> 16) & 0x1F)
    return '.word 0x%08X' % insn

# EncryptTools.Bind @ 0x20B4FE4
# 但那是 thunk。真正的 Bind 应该在别处。
# 观察：0x20B4FE4 处 ldr x8,[x2,#0]; str x8,[x0,#16]; ret
# 这是属性 getter/setter 模式，不是 Bind
# 
# 重新确认：方法 #70297 是 Bind，但 SymbolMap[70297] 可能不是 Bind
# 因为 SymbolMap 索引 ≠ 方法表索引（前者含所有函数，后者只含托管方法）

# 换思路：直接搜索 .so 中所有引用 metadata 字符串 "toDecrypt" 的地方
# 但该字符串在 metadata 文件里，不在 .so
# 
# 关键：IL2CPP 的 Il2CppCodeGenModule 有 methodPointer 数组
# 在 .so 的 .data.rel.ro 或 .data 节
# 找 metadata 的 registration 结构

# 实用方法：找 .so 中做「字节循环 + XOR」的函数
# 特征：ldrb/strb + eor 指令
print('=== 搜索含 eor 指令的密集区域（可能是 XOR 解密）===')
# eor (register): 0xCA000000 mask 0x7F200000
# eor (immediate): 0x52000000 mask 0x7F800000
count_eor = 0
eor_positions = []
a = 0x1198A80
end = 0x1198A80 + 0x2F14B90
step = 4
while a < end:
    insn = struct.unpack_from('<I', data, a)[0]
    # EOR (shifted register) 32/64-bit
    if (insn & 0x7F200000) == 0x4A000000:
        count_eor += 1
        if len(eor_positions) < 20:
            eor_positions.append(a)
    a += step
print('  .text 中 eor 指令数: %d' % count_eor)
print('  前 20 个位置:', [hex(x) for x in eor_positions])
