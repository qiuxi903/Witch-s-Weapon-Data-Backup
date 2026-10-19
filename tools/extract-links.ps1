# 从 APKCombo 页面提取真实直链，输出 JSON 清单
$ErrorActionPreference = 'Continue'
$proxy = 'http://127.0.0.1:7897'
$ua    = 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/131.0.0.0 Safari/537.36'
$tmp   = Join-Path $env:TEMP 'apkhunt'
New-Item -ItemType Directory -Force -Path $tmp | Out-Null

function B64Decode([string]$s) {
    if ([string]::IsNullOrWhiteSpace($s)) { return '' }
    $p = $s.Replace('-', '+').Replace('_', '/')
    $m = $p.Length % 4
    if ($m -ne 0) { $p += '=' * (4 - $m) }
    try { return [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($p)) } catch { return '' }
}

function Get-Page([string]$url, [string]$name) {
    $f = Join-Path $tmp "$name.html"
    if (-not (Test-Path $f)) {
        curl.exe -s -L -x $proxy -A $ua -H 'Accept-Language: zh-CN,zh;q=0.9' -o $f --max-time 60 $url 2>$null | Out-Null
    }
    if (Test-Path $f) { return [System.IO.File]::ReadAllText($f) }
    return ''
}

# 各区服的下载页（变体页）
$targets = @(
    @{ Region='TW'; Ver='1.6.0'; Url='https://apkcombo.com/%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8-%E9%83%BD%E5%B8%82%E5%B9%BB%E6%83%B3%E8%BC%95%E5%B0%8F%E8%AA%AArpg/com.ltgames.mnbq.android/download/phone-1.6.0-apk' },
    @{ Region='TW'; Ver='1.4.0'; Url='https://apkcombo.com/%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8-%E9%83%BD%E5%B8%82%E5%B9%BB%E6%83%B3%E8%BC%95%E5%B0%8F%E8%AA%AArpg/com.ltgames.mnbq.android/download/phone-1.4.0-apk' },
    @{ Region='JP'; Ver='2.0.0'; Url='https://apkcombo.com/witch-s-weapon-%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8/com.dmm.games.witchsweapon.google/download/phone-2.0.0-apk' },
    @{ Region='JP'; Ver='1.8.0'; Url='https://apkcombo.com/witch-s-weapon-%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8/com.dmm.games.witchsweapon.google/download/phone-1.8.0-apk' },
    @{ Region='JP'; Ver='1.7.1'; Url='https://apkcombo.com/witch-s-weapon-%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8/com.dmm.games.witchsweapon.google/download/phone-1.7.1-apk' },
    @{ Region='KR'; Ver='1.1.97'; Url='https://apkcombo.com/%EB%A7%88%EB%85%80%EB%B3%91%EA%B8%B0/com.shuiqinling.ww.google.kr/download/phone-1.1.97-apk' },
    @{ Region='KR'; Ver='1.1.90'; Url='https://apkcombo.com/%EB%A7%88%EB%85%80%EB%B3%91%EA%B8%B0/com.shuiqinling.ww.google.kr/download/phone-1.1.90-apk' },
    @{ Region='KR'; Ver='1.0';    Url='https://apkcombo.com/%EB%A7%88%EB%85%80%EB%B3%91%EA%B8%B0/com.shuiqinling.ww.google.kr/download/phone-1.0-apk' },
    @{ Region='CN'; Ver='2.0.1'; Url='https://apkcombo.com/witch-s-weapon/com.shuiqinling.ww.android.cn00/download/apk' }
)

$manifest = @()
foreach ($t in $targets) {
    $name = "$($t.Region)_$($t.Ver)"
    $html = Get-Page $t.Url $name
    if (-not $html) { Write-Output "PAGEFAIL $name"; continue }
    $found = 0
    foreach ($m in [regex]::Matches($html, 'apkcombo\.com/d\?u=([A-Za-z0-9_\-]+={0,2})')) {
        $u = B64Decode $m.Groups[1].Value
        if (-not $u) { continue }
        # 元数据在 c= 参数里，先 unescape 再按 | 切分
        $meta = ''
        $cm = [regex]::Match($u, '[&?]c=([^&]+)')
        if ($cm.Success) {
            $dec = [System.Uri]::UnescapeDataString($cm.Groups[1].Value)
            foreach ($part in ($dec -split '\|')) {
                if ($part -match '^[A-Za-z0-9+/=]{16,}$') {
                    $inner = [System.Uri]::UnescapeDataString((B64Decode $part))
                    if ($inner) { $meta = $inner }
                }
            }
        }
        $type = 'APK'
        if ($u -match '/b/xapk/') { $type = 'XAPK' }
        $size = 0
        $sm = [regex]::Match($meta, 's=(\d+)'); if ($sm.Success) { $size = [int64]$sm.Groups[1].Value }
        $vn = ''; $vm = [regex]::Match($meta, 'vn=([^&]+)'); if ($vm.Success) { $vn = $vm.Groups[1].Value }
        $dev = ''; $dm = [regex]::Match($meta, 'dev=([^&]+)'); if ($dm.Success) { $dev = $dm.Groups[1].Value }
        $fn = ''; $fm = [regex]::Match($u, '[&?]_fn=([^&]+)')
        if ($fm.Success) { $fn = [System.Uri]::UnescapeDataString((B64Decode $fm.Groups[1].Value)) }
        $manifest += [pscustomobject]@{
            Region = $t.Region; PageVer = $t.Ver; Type = $type
            Ver = $vn; SizeBytes = $size; SizeMB = [math]::Round($size / 1MB, 1)
            Dev = $dev; FileName = $fn; Url = $u
        }
        $found++
    }
    Write-Output "$name : $found links"
}

$manifest | Sort-Object Region, PageVer, Type | Format-Table Region, PageVer, Type, Ver, SizeMB, Dev -AutoSize
$manifest | ConvertTo-Json -Depth 4 | Set-Content -Path (Join-Path $tmp 'manifest.json') -Encoding UTF8
Write-Output ("`nmanifest -> {0}" -f (Join-Path $tmp 'manifest.json'))
Write-Output ("total entries: {0}" -f $manifest.Count)
