# 用 headless Edge 渲染 APKCombo 下载页，提取真实直链，输出清单
$ErrorActionPreference = 'Continue'
$exe  = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'
$proxy = 'http://127.0.0.1:7897'
$tmp  = Join-Path $env:TEMP 'apkhunt'
$prof = Join-Path $tmp 'edgeprof'
New-Item -ItemType Directory -Force -Path $tmp, $prof | Out-Null

function B64Decode([string]$s) {
    if ([string]::IsNullOrWhiteSpace($s)) { return '' }
    $p = $s.Replace('-', '+').Replace('_', '/')
    $m = $p.Length % 4
    if ($m -ne 0) { $p += '=' * (4 - $m) }
    try { return [System.Text.Encoding]::UTF8.GetString([Convert]::FromBase64String($p)) } catch { return '' }
}

function Render-Page([string]$url, [string]$name) {
    $out = Join-Path $tmp "render_$name.html"
    if ((Test-Path $out) -and ((Get-Item $out).Length -gt 20000)) { return [System.IO.File]::ReadAllText($out) }
    & $exe --headless=new --disable-gpu --no-sandbox --user-data-dir="$prof" `
        --proxy-server=$proxy --virtual-time-budget=15000 --dump-dom $url 2>$null |
        Set-Content -Path $out -Encoding UTF8
    if (Test-Path $out) { return [System.IO.File]::ReadAllText($out) }
    return ''
}

$pages = @(
    @{ R='TW'; Pkg='com.ltgames.mnbq.android';            Slug='%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8-%E9%83%BD%E5%B8%82%E5%B9%BB%E6%83%B3%E8%BC%95%E5%B0%8F%E8%AA%AArpg'; V='1.6.0' },
    @{ R='TW'; Pkg='com.ltgames.mnbq.android';            Slug='%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8-%E9%83%BD%E5%B8%82%E5%B9%BB%E6%83%B3%E8%BC%95%E5%B0%8F%E8%AA%AArpg'; V='1.4.0' },
    @{ R='JP'; Pkg='com.dmm.games.witchsweapon.google';   Slug='witch-s-weapon-%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8'; V='2.0.0' },
    @{ R='JP'; Pkg='com.dmm.games.witchsweapon.google';   Slug='witch-s-weapon-%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8'; V='1.8.0' },
    @{ R='JP'; Pkg='com.dmm.games.witchsweapon.google';   Slug='witch-s-weapon-%E9%AD%94%E5%A5%B3%E5%85%B5%E5%99%A8'; V='1.7.1' },
    @{ R='KR'; Pkg='com.shuiqinling.ww.google.kr';        Slug='%EB%A7%88%EB%85%80%EB%B3%91%EA%B8%B0'; V='1.1.97' },
    @{ R='KR'; Pkg='com.shuiqinling.ww.google.kr';        Slug='%EB%A7%88%EB%85%80%EB%B3%91%EA%B8%B0'; V='1.1.90' },
    @{ R='KR'; Pkg='com.shuiqinling.ww.google.kr';        Slug='%EB%A7%88%EB%85%80%EB%B3%91%EA%B8%B0'; V='1.0' },
    @{ R='CN'; Pkg='com.shuiqinling.ww.android.cn00';     Slug='witch-s-weapon'; V='2.0.1' }
)

$manifest = @()
foreach ($p in $pages) {
    $name = "$($p.R)_$($p.V)"
    $url = "https://apkcombo.com/$($p.Slug)/$($p.Pkg)/download/phone-$($p.V)-apk"
    if ($p.V -eq '2.0.1' -and $p.R -eq 'CN') { $url = "https://apkcombo.com/$($p.Slug)/$($p.Pkg)/download/apk" }
    $html = Render-Page $url $name
    $n = 0
    foreach ($m in [regex]::Matches($html, 'apkcombo\.com/d\?u=([A-Za-z0-9_\-]+={0,2})')) {
        $u = B64Decode $m.Groups[1].Value
        if (-not $u) { continue }
        $type = 'APK'
        if ($u -match '/b/(?i)xapk/') { $type = 'XAPK' }
        $meta = ''
        $cm = [regex]::Match($u, '[&?]c=([^&]+)')
        if ($cm.Success) {
            foreach ($part in ([System.Uri]::UnescapeDataString($cm.Groups[1].Value) -split '\|')) {
                if ($part -match '^[A-Za-z0-9+/=]{16,}$') {
                    $inner = [System.Uri]::UnescapeDataString((B64Decode $part))
                    if ($inner) { $meta = $inner }
                }
            }
        }
        $size = 0; $sm = [regex]::Match($meta, 's=(\d+)'); if ($sm.Success) { $size = [int64]$sm.Groups[1].Value }
        $vn = '';   $vm = [regex]::Match($meta, 'vn=([^&]+)'); if ($vm.Success) { $vn = $vm.Groups[1].Value }
        $dev = '';  $dm = [regex]::Match($meta, 'dev=([^&]+)'); if ($dm.Success) { $dev = $dm.Groups[1].Value }
        $manifest += [pscustomobject]@{
            Region = $p.R; Pkg = $p.Pkg; PageVer = $p.V; Type = $type
            Ver = $vn; SizeMB = [math]::Round($size / 1MB, 1); Dev = $dev; Url = $u
        }
        $n++
    }
    Write-Output "$name : $n links"
}

$manifest = $manifest | Sort-Object Region, PageVer, Type -Unique
$manifest | Format-Table Region, PageVer, Type, Ver, SizeMB, Dev -AutoSize
$manifest | ConvertTo-Json -Depth 4 | Set-Content (Join-Path $tmp 'manifest2.json') -Encoding UTF8
Write-Output ("`nentries: {0} -> manifest2.json" -f $manifest.Count)
