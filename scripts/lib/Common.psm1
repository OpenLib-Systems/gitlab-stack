function Write-Info($msg) { Write-Host "INFO  $msg" }
function Write-Warn($msg) { Write-Warning $msg }
function Throw-Err($msg) { throw $msg }

function Get-DefaultPrefix {
  $base = $env:LOCALAPPDATA
  if (-not $base) { $base = $env:USERPROFILE }
  return (Join-Path $base "gitlab-stack\bin")
}

function Get-StateDir {
  $base = $env:LOCALAPPDATA
  if (-not $base) { $base = $env:USERPROFILE }
  return (Join-Path $base "gitlab-stack\state")
}

function Get-RunnerExePath([string]$Prefix) {
  if (-not $Prefix) { $Prefix = Get-DefaultPrefix }
  return (Join-Path $Prefix "gitlab-runner.exe")
}

Export-ModuleMember -Function *
