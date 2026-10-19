$ErrorActionPreference = 'Continue'
$ProgressPreference = 'SilentlyContinue'
Add-Type -AssemblyName System.Drawing

$base = 'https://anywhere.coresv.net/mobile/wiki/witchs_weapon/lib/exe/fetch.php?media='
$root = 'G:\project\其他\game\assets'
$raw  = Join-Path $root 'raw'
$web  = Join-Path $root 'img'
New-Item -ItemType Directory -Force -Path $raw, $web | Out-Null

$list = @()
foreach ($n in 1..20)  { $list += ,@(('load{0:d2}' -f $n), ('wiki:archive:loading{0:d2}.png' -f $n)) }
foreach ($n in @(1,3,5,7,9,11,13,15,17,19,21,23,25,27)) { $list += ,@(('cost{0:d2}' -f $n), ('wiki:costume:costume{0:d2}.png' -f $n)) }
foreach ($n in 1..32)  { $list += ,@(('mem{0:d2}' -f $n), ('wiki:archive:memorial{0:d2}.png' -f $n)) }

$ok = 0; $fail = 0; $skip = 0
foreach ($item in $list) {
    $stem = $item[0]; $media = $item[1]
    $png = Join-Path $raw "$stem.png"
    $jpg = Join-Path $web "$stem.jpg"
    if (Test-Path $jpg) { $skip++; continue }
    if (-not (Test-Path $png)) {
        try {
            Invoke-WebRequest -Uri ($base + $media) -OutFile $png -UserAgent 'Mozilla/5.0' -TimeoutSec 60
        } catch {
            Write-Output "DLFAIL $stem $($_.Exception.Message)"
            $fail++
            continue
        }
    }
    try {
        $img = [System.Drawing.Image]::FromFile($png)
        $maxW = 1500.0
        $scale = [Math]::Min(1.0, $maxW / $img.Width)
        $nw = [int]($img.Width * $scale); $nh = [int]($img.Height * $scale)
        $bmp = New-Object System.Drawing.Bitmap($nw, $nh)
        $g = [System.Drawing.Graphics]::FromImage($bmp)
        $g.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
        $g.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
        $g.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
        $g.DrawImage($img, 0, 0, $nw, $nh)
        $g.Dispose()
        $codec = [System.Drawing.Imaging.ImageCodecInfo]::GetImageEncoders() | Where-Object { $_.MimeType -eq 'image/jpeg' }
        $ep = New-Object System.Drawing.Imaging.EncoderParameters(1)
        $ep.Param[0] = New-Object System.Drawing.Imaging.EncoderParameter([System.Drawing.Imaging.Encoder]::Quality, [int64]84)
        $bmp.Save($jpg, $codec, $ep)
        $bmp.Dispose(); $img.Dispose()
        $ok++
        Write-Output ("OK $stem {0}x{1} -> {2} KB" -f $nw, $nh, [int]((Get-Item $jpg).Length / 1KB))
    } catch {
        Write-Output "CONVFAIL $stem $($_.Exception.Message)"
        $fail++
    }
}
Write-Output "SUMMARY ok=$ok skip=$skip fail=$fail"
Get-ChildItem $web -File | Measure-Object -Property Length -Sum | Select-Object Count, @{n='MB'; e={[math]::Round($_.Sum / 1MB, 1)}} | Format-List
