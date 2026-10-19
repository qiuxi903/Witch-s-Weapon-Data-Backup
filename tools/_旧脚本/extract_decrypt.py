# Ghidra 脚本：提取 EncryptTools.Decrypt 的反编译代码
# 用法：analyzeHeadless <proj> <name> -import <so> -postScript extract_decrypt.py
import os

from ghidra.app.decompiler import DecompInterface
from ghidra.util.task import ConsoleTaskMonitor

TARGETS = [
    ("EncryptTools.Decrypt", 0x131F0D4),
    ("EncryptTools.Encrypt", 0x131EDA4),
    ("EncryptTools..cctor", 0x131F34C),
    ("BytesAsset.get_str", 0x164A670),
    ("BytesAsset.get_bytesEncrypt", 0x164A800),
    ("BytesAsset.get_streamReader", 0x164A734),
]

out_path = r"G:\project\其他\game\提取资源\国服DLL\Il2CppDump\decrypt_decompiled.txt"
fm = currentProgram.getFunctionManager()
decomp = DecompInterface()
decomp.openProgram(currentProgram)
monitor = ConsoleTaskMonitor()

lines = []
lines.append("=" * 78)
lines.append("Ghidra 反编译结果 - EncryptTools / BytesAsset")
lines.append("=" * 78)
lines.append("")

for name, addr in TARGETS:
    lines.append("-" * 78)
    lines.append("### %s  @ 0x%X" % (name, addr))
    lines.append("-" * 78)
    try:
        a = toAddr(addr)
        func = fm.getFunctionAt(a)
        if func is None:
            func = fm.getFunctionContaining(a)
        if func is None:
            lines.append("  [未找到函数]")
            lines.append("")
            continue
        lines.append("  函数名: %s" % func.getName())
        lines.append("  入口: 0x%X" % func.getEntryPoint().getOffset())
        lines.append("  大小: %d 字节" % func.getBody().getNumAddresses())
        lines.append("")
        res = decomp.decompileFunction(func, 180, monitor)
        if res and res.decompileCompleted():
            code = res.getDecompiledFunction().getC()
            lines.append(code)
        else:
            lines.append("  [反编译失败]")
    except Exception as e:
        lines.append("  [异常] %s" % e)
    lines.append("")

with open(out_path, "w", encoding="utf-8") as f:
    f.write("\n".join(lines))

print("已写入 %s (%d 行)" % (out_path, len(lines)))
