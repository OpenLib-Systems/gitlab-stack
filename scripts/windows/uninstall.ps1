param(
  [string]$RootDir,
  [string]$Prefix
)

Import-Module (Join-Path $RootDir "scripts\lib\Common.psm1") -Force

if (-not $Prefix) { $Prefix = Get-DefaultPrefix }
$runnerExe = Get-RunnerExePath $Prefix
$state = Get-StateDir

if (Test-Path $runnerExe) {
  Write-Info "Removing $runnerExe"
  Remove-Item -Force $runnerExe
} else {
  Write-Warn "No runner binary found at $runnerExe (maybe installed elsewhere)."
}

if (Test-Path $state) {
  Write-Info "Removing state dir: $state"
  Remove-Item -Recurse -Force $state
}

Write-Info "Note: Registration config ($env:USERPROFILE\.gitlab-runner\config.toml) is not removed automatically."
Write-Info "If you want to remove it: Remove-Item -Recurse -Force $env:USERPROFILE\.gitlab-runner"
