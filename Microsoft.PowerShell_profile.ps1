Set-PSReadLineOption -PredictionSource History

oh-my-posh init pwsh --config "C:\Users\dmitr\AppData\Local\Programs\oh-my-posh\themes\gruvbox.omp.json" | Invoke-Expression

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
