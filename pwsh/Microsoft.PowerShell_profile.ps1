Set-PSReadLineOption -PredictionSource History

oh-my-posh init pwsh --config "D:\Documents\WindowsPowerShell\dbox.omp.json" | Invoke-Expression

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
