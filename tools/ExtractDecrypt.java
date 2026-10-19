// Ghidra Java 脚本：提取 EncryptTools.Decrypt 的反编译代码
//@category Analysis

import ghidra.app.script.GhidraScript;
import ghidra.app.decompiler.DecompInterface;
import ghidra.app.decompiler.DecompileResults;
import ghidra.program.model.address.Address;
import ghidra.program.model.listing.Function;
import ghidra.program.model.listing.FunctionManager;
import ghidra.util.task.ConsoleTaskMonitor;
import java.io.PrintWriter;
import java.io.File;

public class ExtractDecrypt extends GhidraScript {

    @Override
    public void run() throws Exception {
        String outPath = "G:\\project\\其他\\game\\提取资源\\国服DLL\\Il2CppDump\\decrypt_decompiled.txt";

        long[][] targets = new long[][] {
            {0x131F0D4L, 0}, // EncryptTools.Decrypt
            {0x131EDA4L, 0}, // EncryptTools.Encrypt
            {0x131F34CL, 0}, // EncryptTools..cctor
            {0x164A670L, 0}, // BytesAsset.get_str
            {0x164A800L, 0}, // BytesAsset.get_bytesEncrypt
            {0x164A734L, 0}, // BytesAsset.get_streamReader
        };
        String[] names = {
            "EncryptTools.Decrypt",
            "EncryptTools.Encrypt",
            "EncryptTools..cctor",
            "BytesAsset.get_str",
            "BytesAsset.get_bytesEncrypt",
            "BytesAsset.get_streamReader",
        };

        FunctionManager fm = currentProgram.getFunctionManager();
        DecompInterface decomp = new DecompInterface();
        decomp.openProgram(currentProgram);
        ConsoleTaskMonitor mon = new ConsoleTaskMonitor();

        PrintWriter pw = new PrintWriter(new File(outPath), "UTF-8");
        pw.println("================================================================");
        pw.println("Ghidra 反编译结果 - EncryptTools / BytesAsset");
        pw.println("================================================================");
        pw.println();

        for (int i = 0; i < targets.length; i++) {
            long addr = targets[i][0];
            String name = names[i];
            pw.println("----------------------------------------------------------------");
            pw.println("### " + name + "  @ 0x" + Long.toHexString(addr).toUpperCase());
            pw.println("----------------------------------------------------------------");
            try {
                Address a = toAddr(addr);
                Function func = fm.getFunctionAt(a);
                if (func == null) func = fm.getFunctionContaining(a);
                if (func == null) {
                    pw.println("  [未找到函数]");
                    pw.println();
                    continue;
                }
                pw.println("  函数名: " + func.getName());
                pw.println("  入口: 0x" + Long.toHexString(func.getEntryPoint().getOffset()).toUpperCase());
                pw.println("  大小: " + func.getBody().getNumAddresses() + " 字节");
                pw.println();
                DecompileResults res = decomp.decompileFunction(func, 180, mon);
                if (res != null && res.decompileCompleted()) {
                    pw.println(res.getDecompiledFunction().getC());
                } else {
                    pw.println("  [反编译失败]");
                }
            } catch (Exception e) {
                pw.println("  [异常] " + e.toString());
            }
            pw.println();
        }
        pw.close();
        println("已写入 " + outPath);
    }
}
