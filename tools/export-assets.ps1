# 用 AssetStudioModCLI 批量导出资源
param(
    [Parameter(Mandatory=$true)][string]$InputDir,
    [Parameter(Mandatory=$true)][string]$OutputDir,
    [string]$AssetTypes = 'all',
    [string]$Mode = 'export',
    [string]$GroupOption = 'container',
    [string]$ImageFormat = 'png',
    [string]$AudioFormat = 'wav'
)

$ErrorActionPreference = 'Continue'
$exe = 'G:\project\其他\game\tools\AssetStudioModCLI\AssetStudioModCLI_net472_win32_64\AssetStudioModCLI.exe'
New-Item -ItemType Directory -Force -Path $OutputDir | Out-Null

Write-Output "输入: $InputDir"
Write-Output "输出: $OutputDir"
Write-Output "类型: $AssetTypes   模式: $Mode   分组: $GroupOption"
Write-Output ""

$sw = [System.Diagnostics.Stopwatch]::StartNew()
& $exe $InputDir `
    -m $Mode `
    -t $AssetTypes `
    -g $GroupOption `
    -o $OutputDir `
    -r `
    --image-format $ImageFormat `
    --audio-format $AudioFormat `
    --log-level warning `
    --max-export-tasks 8 2>&1 | ForEach-Object {
        # 只打印非进度条行
        if ($_ -notmatch '^\[\d{3}%\]$') { Write-Output $_ }
    }
$sw.Stop()
Write-Output ""
Write-Output ("完成，用时 {0:N0} 秒" -f $sw.Elapsed.TotalSeconds)
$f = Get-ChildItem $OutputDir -Recurse -File -ErrorAction SilentlyContinue
if ($f) {
    Write-Output ("导出 {0} 个文件, {1:N1} MB" -f $f.Count, (($f | Measure-Object -Property Length -Sum).Sum/1MB))
}
