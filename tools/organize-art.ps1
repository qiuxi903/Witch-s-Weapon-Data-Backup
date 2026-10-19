# 整理提取出的美术资源：去重 + 分类归档
$ErrorActionPreference = 'Continue'

$srcRoot = 'G:\project\其他\game\提取资源'
$dst     = 'G:\project\其他\game\美术素材'

# 分类规则：按文件名模式归类
$rules = [ordered]@{
    '01_角色卡面立绘' = 'Servant00_Image|^servant\d|^servant_|chara_|_chara'
    '02_加载图'       = 'Loading_Bg|Loading_'
    '03_活动图'       = 'Activity|activity_'
    '04_卡牌'         = 'card|Card'
    '05_白烛'         = 'baizhu|bz2'
    '06_UI界面'       = 'UI_|^ui_|Btn|btn|Icon|icon|Panel|panel|Frame|frame'
    '07_背景场景'     = 'BG_|^bg_|Background|Scene|scene|map_'
    '08_特效'         = 'TX_effects|Effect|effect|Flash|Particle|Glow|glow'
    '09_立绘部件'     = '_body|_hair|_cloth|cloth|hair|body'
}

Write-Output "开始整理..."
$seen = @{}
$counts = @{}
$total = 0

foreach ($dir in (Get-ChildItem $srcRoot -Directory | Where-Object { $_.Name -match '导出_UI|导出_全部贴图|_导出UI' })) {
    Write-Output ("扫描: {0}" -f $dir.Name)
    foreach ($f in (Get-ChildItem $dir.FullName -Recurse -File -Include *.png,*.jpg)) {
        $total++
        # 用 文件名+大小 作为去重键
        $key = "{0}|{1}" -f $f.Name, $f.Length
        if ($seen.ContainsKey($key)) { continue }
        $seen[$key] = $true

        # 归类
        $cat = '10_其它'
        foreach ($k in $rules.Keys) {
            if ($f.Name -match $rules[$k]) { $cat = $k; break }
        }

        $outDir = Join-Path $dst $cat
        if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }
        $target = Join-Path $outDir $f.Name
        # 若同名不同内容，加后缀
        if (Test-Path $target) {
            $base = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
            $ext  = $f.Extension
            $i = 2
            while (Test-Path $target) {
                $target = Join-Path $outDir ("{0}_{1}{2}" -f $base, $i, $ext)
                $i++
            }
        }
        Copy-Item -LiteralPath $f.FullName -Destination $target -Force
        if (-not $counts.ContainsKey($cat)) { $counts[$cat] = 0 }
        $counts[$cat]++
    }
}

Write-Output ""
Write-Output ("扫描 {0} 个文件，去重后归档 {1} 个" -f $total, $seen.Count)
Write-Output ""
Write-Output "=== 分类结果 ==="
foreach ($k in ($counts.Keys | Sort-Object)) {
    $d = Join-Path $dst $k
    $sz = ((Get-ChildItem $d -File) | Measure-Object -Property Length -Sum).Sum
    Write-Output ("  {0,-18} {1,5} 个  {2,9:N1} MB" -f $k, $counts[$k], ($sz/1MB))
}
