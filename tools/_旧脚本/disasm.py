import io, sys, struct

sys.stdout.reconfigure(encoding='utf-8', errors='replace')

so = r'G:\project\其他\game\提取资源\国服DLL\libil2cpp.so'
with open(so, 'rb') as f:
    data = f.read()

# .text: addr == file offset (addr=0x1198A80, off=0x1198A80)
def read_at(addr, n):
    return data[addr:addr+n]

# 简单 ARM64 反汇编（关键指令）
def disasm(addr, count=40):
    out = []
    for i in range(count):
        a = addr + i*4
        if a + 4 > len(data): break
        insn = struct.unpack_from('<I', data, a)[0]
        out.append((a, insn, decode_arm64(insn, a)))
    return out

def decode_arm64(insn, addr):
    # 关键指令解码
    if insn == 0xD503201F: return 'nop'
    if insn == 0xD65F03C0: return 'ret'
    # B (unconditional branch)
    if (insn & 0xFC000000) == 0x14000000:
        imm = insn & 0x03FFFFFF
        if imm & 0x02000000: imm -= 0x04000000
        return 'b 0x%X' % (addr + imm*4)
    # BL
    if (insn & 0xFC000000) == 0x94000000:
        imm = insn & 0x03FFFFFF
        if imm & 0x02000000: imm -= 0x04000000
        return 'bl 0x%X' % (addr + imm*4)
    # ADRP
    if (insn & 0x9F000000) == 0x90000000:
        rd = insn & 0x1F
        immlo = (insn >> 29) & 3
        immhi = (insn >> 5) & 0x7FFFF
        imm = (immhi << 2) | immlo
        if imm & 0x100000: imm -= 0x200000
        page = (addr & ~0xFFF) + (imm << 12)
        return 'adrp x%d, 0x%X' % (rd, page)
    # ADD imm
    if (insn & 0x7F000000) == 0x11000000:
        rd = insn & 0x1F; rn = (insn >> 5) & 0x1F
        imm = (insn >> 10) & 0xFFF
        sh = (insn >> 22) & 1
        return 'add x%d, x%d, #%d%s' % (rd, rn, imm, ', lsl 12' if sh else '')
    # LDR (immediate, unsigned offset)
    if (insn & 0xFFC00000) == 0xF9400000:
        rt = insn & 0x1F; rn = (insn >> 5) & 0x1F
        imm = ((insn >> 10) & 0xFFF) * 8
        return 'ldr x%d, [x%d, #%d]' % (rt, rn, imm)
    # STR
    if (insn & 0xFFC00000) == 0xF9000000:
        rt = insn & 0x1F; rn = (insn >> 5) & 0x1F
        imm = ((insn >> 10) & 0xFFF) * 8
        return 'str x%d, [x%d, #%d]' % (rt, rn, imm)
    # MOV (ORR with xzr)
    if (insn & 0xFFE0FFE0) == 0xAA0003E0:
        rd = insn & 0x1F; rm = (insn >> 16) & 0x1F
        return 'mov x%d, x%d' % (rd, rm)
    # MOVZ
    if (insn & 0x7F800000) == 0x52800000:
        rd = insn & 0x1F
        imm = (insn >> 5) & 0xFFFF
        hw = (insn >> 21) & 3
        return 'movz x%d, #0x%X, lsl %d' % (rd, imm, hw*16)
    return '0x%08X' % insn

print('=== EncryptTools.Bind @0x20B4FE4 (size 0x10) ===')
for a, insn, s in disasm(0x20B4FE4, 8):
    print('  0x%X: %-10s %s' % (a, '%08X' % insn, s))

print()
print('=== EncryptTools..ctor @0x20B4FF4 (size 0x30C) ===')
for a, insn, s in disasm(0x20B4FF4, 30):
    print('  0x%X: %-10s %s' % (a, '%08X' % insn, s))
