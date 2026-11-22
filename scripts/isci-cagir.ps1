# Claude Code icin ucuz/ucretsiz isci modeli (OpenCode) cagirici. Windows PowerShell 5.1+ ile calisir.
# Kullanim (proje klasorunde, not dosyasi .yazisma\ altinda olmali):
#   powershell -ExecutionPolicy Bypass -File <yol>\isci-cagir.ps1 -Not gorev.md -Etiket kisa-ad
param(
  [Parameter(Mandatory)] [string]$Not,      # .yazisma altindaki gorev notu dosya adi
  [Parameter(Mandatory)] [string]$Etiket,   # cikti: .yazisma\isci-<Etiket>-cevap.md
  [string]$Model = 'opencode/deepseek-v4.1-flash-free',
  [string[]]$Yedek = @('opencode/mimo-v2.6-flash-free', 'opencode/big-pickle'),
  [switch]$Yazabilir,                       # verilmezse salt okunur (plan ajani)
  [string]$Dizin = $PWD.Path                # varsayilan: betigi cagirdiginiz klasor (proje)
)

$ErrorActionPreference = 'Continue'
$Y = Join-Path $Dizin '.yazisma'
if ($Dizin -like "$env:SystemRoot*") { "HATA: Proje klasorunde calistirin (su an: $Dizin)"; exit 1 }
New-Item -ItemType Directory -Force $Y | Out-Null

# opencode komutunu bul: once PATH, sonra npm global klasoru
$exe = (Get-Command opencode.cmd -ErrorAction SilentlyContinue).Source
if (-not $exe) { $exe = (Get-Command opencode -ErrorAction SilentlyContinue).Source }
if (-not $exe) { "HATA: opencode bulunamadi. Once kontrol.ps1 calistirin veya: npm.cmd install -g opencode-ai"; exit 1 }

$cikti  = Join-Path $Y "isci-$Etiket-cevap.md"
$gunluk = Join-Path $Y "isci-$Etiket-log.txt"
# Istem tek satir olmali (.cmd uzerinden cok satirli arguman kesilir). Ayrinti not dosyasinda.
$istem = ".yazisma\$Not dosyasini oku ve yalniz orada istenenleri yap. Sen ucuz isci modelsin. Notta adi gecmeyen dosyalari okuma. Cevabini en cok 30 satir ver."
$kip = if ($Yazabilir) { @('--agent', 'build', '--auto') } else { @('--agent', 'plan') }

Set-Location $Dizin
$esc = [char]27
$bas = Get-Date
$metin = ''
foreach ($m in @($Model) + $Yedek) {
  # Girdi $null ile kapatilir; yoksa opencode stdin bekleyip takili kalir
  $ham = $null | & $exe run --pure -m $m --dir $Dizin @kip $istem 2>> $gunluk
  $metin = [regex]::Replace(($ham -join "`r`n"), "$esc\[[0-9;?]*[A-Za-z]", '').Trim()
  if ($metin.Length -gt 0) { $Model = $m; break }
  "bos cevap: $m" | Add-Content $gunluk
}
# Salt okunur (plan) kipinden sizan bilgi satirlarini ayikla
$metin = (($metin -split "`r?`n" | Where-Object { $_ -notmatch '(?i)plan mod|plan mode|read-only mode|salt okunur mod' }) -join "`r`n").Trim()
$sure = [int]((Get-Date) - $bas).TotalSeconds
Set-Content -LiteralPath $cikti -Value $metin -Encoding UTF8
"BITTI | model: $Model | sure: $sure sn | cevap: $cikti"
if ($metin.Length -eq 0) { "UYARI: tum modeller bos dondu, gunluge bak: $gunluk" }
