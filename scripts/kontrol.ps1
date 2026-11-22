# Kurulum kontrolu: OpenCode var mi, ucretsiz model listede mi. Sadece okur, bir sey kurmaz.
$ok = $true
$exe = (Get-Command opencode.cmd -ErrorAction SilentlyContinue).Source
if (-not $exe) { $exe = (Get-Command opencode -ErrorAction SilentlyContinue).Source }
if ($exe) { "OK    opencode: $exe" } else { "EKSIK opencode. Kurulum: npm.cmd install -g opencode-ai"; $ok = $false }
if ($exe) {
  $modeller = & $exe models 2>$null
  if ($modeller -match 'deepseek-v4.1-flash-free') { "OK    ucretsiz model listede: deepseek-v4.1-flash-free" }
  else { "UYARI  deepseek-v4.1-flash-free listede yok. Model listesi: opencode models (isci-cagir.ps1 -Model ile baska model secin)" }
}
if (Get-Command git -ErrorAction SilentlyContinue) { "OK    git var" } else { "BILGI  git yok (zorunlu degil)" }
if ($ok) { "Hazir. Ornek: powershell -ExecutionPolicy Bypass -File scripts\isci-cagir.ps1 -Not gorev.md -Etiket test" }
