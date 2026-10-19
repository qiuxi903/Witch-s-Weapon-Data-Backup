# 解包国服 APK，完整提取所有资源
$ErrorActionPreference = 'Continue'
Add-Type -AssemblyName System.IO.Compression.FileSystem

$root = 'G:\project\其他\game'
$apk  = Join-Path $root '安装包\魔女兵器_WitchsWeapon_v2.0.1_国服_九游版_com.shuiqinling.ww.android.cn00.apk'
$out  = Join-Path $root '提取资源\国服v2.0.1_完整解包'
New-Item -ItemType Directory -Force -Path $out | Out-Null

Write-Output "开始解包: $apk"
Write-Output "输出到:   $out"
$sw = [System.Diagnostics.Stopwatch]::StartNew()

$zip = [System.IO.Compression.ZipFile]::OpenRead($apk)
$total = $zip.Entries.Count
$i = 0
$bytes = 0
$err = 0

foreach ($e in $zip.Entries) {
    $i++
    # 跳过目录项
    if ([string]::IsNullOrEmpty($e.Name)) { continue }
    $target = Join-Path $out ($e.FullName -replace '/', '\')
    $dir = Split-Path $target -Parent
    try {
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
        [System.IO.Compression.ZipFileExtensions]::ExtractToFile($e, $target, $true)
        $bytes += $e.Length
    } catch {
        $err++
        if ($err -le 10) { Write-Output ("  提取失败: {0} -- {1}" -f $e.FullName, $_.Exception.Message) }
    }
    if ($i % 1000 -eq 0) {
        Write-Output ("  进度 {0}/{1}  已解出 {2:N1} MB  用时 {3:N0}s" -f $i, $total, ($bytes/1MB), $sw.Elapsed.TotalSeconds)
    }
}
$zip.Dispose()
$sw.Stop()
Write-Output ""
Write-Output ("完成: {0} 个条目, 解出 {1:N2} GB, 失败 {2} 个, 用时 {3:N0}s" -f $total, ($bytes/1GB), $err, $sw.Elapsed.TotalSeconds)

# 统计
$files = Get-ChildItem $out -Recurse -File
Write-Output ("磁盘实际: {0} 个文件, {1:N2} GB" -f $files.Count, (($files | Measure-Object -Property Length -Sum).Sum/1GB))
