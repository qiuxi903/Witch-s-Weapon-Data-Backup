# 重新精细分类美术素材（改进版）
$ErrorActionPreference = 'Continue'

$srcRoot = 'G:\project\其他\game\提取资源'
$dst     = 'G:\project\其他\game\美术素材_分类'
if (Test-Path $dst) { Remove-Item $dst -Recurse -Force }
New-Item -ItemType Directory -Force -Path $dst | Out-Null

# 更精细的分类规则（按优先级从上到下匹配）
$rules = [ordered]@{
    '01_角色卡面'      = '^Servant00_Image_\d+(_bg)?(_\d+)?\.png$'
    '02_角色立绘部件'  = '^Servant00_|^servant\d|_body\.png$|_hair\.png$|cloth\.png$|_at_field'
    '03_卡牌'          = 'cardpool|_card\.png$|^card'
    '04_加载图'        = '^Loading_Bg|^Loading_'
    '05_活动图'        = '^Activity|^activity_'
    '06_白烛'          = 'baizhu|bz2'
    '07_背景场景'      = '^BG_|^bg_|Background|^map_|^Scene'
    '08_UI界面'        = '^UI_|^ui_|Btn|btn|^Icon|^icon|Panel|panel|^Frame|frame|^Btn|^Tab|^Tab_'
    '09_特效'          = '^TX_effects|Effect|effect|Flash|Particle|Glow|glow|^FX|^fx'
    '10_角色3D贴图'    = '^TX_|^mob_|^player_|^boss|^weapon_'
    '11_武器立绘'      = '^Weapon\d+_Image|^Weapon\d+_Wide_Icon|^\d+_weapon'
    '12_角色头像'      = '^role\d+\.png$|^face\d+\.png$|^Draw_Head|^head'
    '13_图标'          = '^Icon|^icon|^item_|^Item|^UISprite'
    '14_字体'          = '\.ttf$|\.otf$'
    '15_地区专属'      = '^Extra_(JP|TW|CN|KR)|^jp_|^kr_|^cn_|^Tw_|^TW_|^JP_|^KR_'
    '16_光影贴图'      = 'Lightmap|_light|_Light'
    '17_其它'          = '.'
}

$seen = @{}
$counts = @{}

foreach ($dir in (Get-ChildItem $srcRoot -Directory | Where-Object { $_.Name -match '导出_UI|导出_全部贴图|_导出UI|导出_字体着色器' })) {
    foreach ($f in (Get-ChildItem $dir.FullName -Recurse -File -Include *.png,*.jpg,*.ttf,*.otf)) {
        $key = "{0}|{1}" -f $f.Name, $f.Length
        if ($seen.ContainsKey($key)) { continue }
        $seen[$key] = $true

        $cat = '13_其它'
        foreach ($k in $rules.Keys) {
            if ($f.Name -match $rules[$k]) { $cat = $k; break }
        }

        $outDir = Join-Path $dst $cat
        if (-not (Test-Path $outDir)) { New-Item -ItemType Directory -Force -Path $outDir | Out-Null }
        $target = Join-Path $outDir $f.Name
        if (Test-Path $target) {
            $base = [System.IO.Path]::GetFileNameWithoutExtension($f.Name)
            $ext  = $f.Extension
            $i = 2
            while (Test-Path $target) { $target = Join-Path $outDir ("{0}_{1}{2}" -f $base,$i,$ext); $i++ }
        }
        Copy-Item -LiteralPath $f.FullName -Destination $target -Force
        if (-not $counts.ContainsKey($cat)) { $counts[$cat] = 0 }
        $counts[$cat]++
    }
}

Write-Output ("去重归档 {0} 个文件" -f $seen.Count)
Write-Output ""
foreach ($k in ($counts.Keys | Sort-Object)) {
    $d = Join-Path $dst $k
    $sz = ((Get-ChildItem $d -File) | Measure-Object -Property Length -Sum).Sum
    Write-Output ("  {0,-18} {1,5} 个  {2,9:N1} MB" -f $k, $counts[$k], ($sz/1MB))
}
