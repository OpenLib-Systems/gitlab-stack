param(
  [string]$RootDir
)

Import-Module (Join-Path $RootDir "scripts\lib\Common.psm1") -Force
$state = Get-StateDir
$pidFile = Join-Path $state "gitlab-runner.pid"

if (Test-Path $pidFile) {
  $pid = Get-Content $pidFile -ErrorAction SilentlyContinue
  if ($pid) {
    try { Get-Process -Id $pid -ErrorAction Stop | Out-Null; Write-Info "Runner is RUNNING (pid $pid)"; exit 0 } catch {}
  }
}
Write-Info "Runner is NOT running."
exit 1
