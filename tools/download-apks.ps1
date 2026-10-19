# 下载《魔女兵器》各区服安装包
# 流程：APKCombo 签名直链 -> 解析重定向 -> data.winudf.com 真实文件
$ErrorActionPreference = 'Continue'
$proxy = 'http://127.0.0.1:7897'
$ua    = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'
$tmp   = Join-Path $env:TEMP 'apkhunt'
$dest  = 'G:\project\其他\game\安装包'
New-Item -ItemType Directory -Force -Path $dest | Out-Null

$m = Get-Content (Join-Path $tmp 'manifest2.json') -Raw | ConvertFrom-Json

# 选定要下载的条目：区服 + 版本 + 类型
$want = @(
    @{ R='CN'; V='2.0.1'; T='APK'; Name='魔女兵器_WitchsWeapon_v2.0.1_国服_com.shuiqinling.ww.android.cn00.apk' },
    @{ R='JP'; V='2.0.0'; T='APK'; Name='魔女兵器_WitchsWeapon_v2.0.0_日服_com.dmm.games.witchsweapon.google.apk' },
    @{ R='JP'; V='1.8.0'; T='APK'; Name='魔女兵器_WitchsWeapon_v1.8.0_日服_com.dmm.games.witchsweapon.google.apk' },
    @{ R='JP'; V='1.7.1'; T='APK'; Name='魔女兵器_WitchsWeapon_v1.7.1_日服_com.dmm.games.witchsweapon.google.apk' },
    @{ R='TW'; V='1.6.0'; T='APK'; Name='魔女兵器_WitchsWeapon_v1.6.0_港澳台_com.ltgames.mnbq.android.apk' },
    @{ R='TW'; V='1.4.0'; T='APK'; Name='魔女兵器_WitchsWeapon_v1.4.0_港澳台_com.ltgames.mnbq.android.apk' },
    @{ R='KR'; V='1.0';   T='APK'; Name='魔女兵器_WitchsWeapon_v1.0_韩服_com.shuiqinling.ww.google.kr.apk' },
    @{ R='KR'; V='1.1.90';T='APK'; Name='魔女兵器_WitchsWeapon_v1.1.90_韩服_com.shuiqinling.ww.google.kr.apk' }
)

$report = @()
foreach ($w in $want) {
    $entry = $m | Where-Object { $_.Region -eq $w.R -and $_.PageVer -eq $w.V -and $_.Type -eq $w.T } | Select-Object -First 1
    if (-not $entry) { Write-Output "MISS  $($w.R) $($w.V)"; continue }

    $outPath = Join-Path $dest $w.Name
    if ((Test-Path $outPath) -and ((Get-Item $outPath).Length -gt 1000000)) {
        Write-Output "SKIP  $($w.Name)  (已存在)"
        $report += [pscustomobject]@{ File=$w.Name; Status='已存在'; Bytes=(Get-Item $outPath).Length }
        continue
    }

    # 1) 解析重定向到 data.winudf.com
    $loc = (curl.exe -s -D - -o NUL -x $proxy -A $ua -H 'Referer: https://apkpure.com/' --max-time 40 $entry.Url 2>$null |
            Where-Object { $_ -match '(?i)^location:' }) -replace '(?i)^location:\s*',''
    $loc = ($loc | Select-Object -First 1)
    if (-not $loc) { Write-Output "NOLOC $($w.Name)"; $report += [pscustomobject]@{ File=$w.Name; Status='解析失败'; Bytes=0 }; continue }
    $loc = $loc.Trim()

    # 2) 下载
    Write-Output "GET   $($w.Name)"
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $res = curl.exe -s -L -x $proxy -A $ua -H 'Referer: https://apkpure.com/' `
           --retry 3 --retry-delay 2 -C - -o $outPath `
           -w "%{http_code}|%{size_download}|%{speed_download}" --max-time 1800 $loc 2>$null
    $sw.Stop()
    $parts = $res -split '\|'
    $size = 0
    if (Test-Path $outPath) { $size = (Get-Item $outPath).Length }
    $ok = 'OK'
    if ($size -lt 1000000) { $ok = 'SUSPECT' }
    # 校验 ZIP 魔数
    if ($size -ge 4) {
        $fs = [System.IO.File]::OpenRead($outPath)
        $b = New-Object byte[] 4
        $fs.Read($b, 0, 4) | Out-Null
        $fs.Close()
        if (-not ($b[0] -eq 0x50 -and $b[1] -eq 0x4B)) { $ok = 'NOT-ZIP' }
    }
    Write-Output ("      http={0} size={1:N1} MB speed={2:N0} B/s 用时={3:N0}s  [{4}]" -f `
        $parts[0], ($size/1MB), [double]$parts[2], $sw.Elapsed.TotalSeconds, $ok)
    $report += [pscustomobject]@{ File=$w.Name; Status=$ok; Bytes=$size }
}

Write-Output ""
Write-Output "================ 汇总 ================"
$report | Format-Table -AutoSize
$report | ConvertTo-Json | Set-Content (Join-Path $tmp 'download-report.json') -Encoding UTF8
