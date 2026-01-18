param(
  [string]$RootDir
)

Import-Module (Join-Path $RootDir "scripts\lib\Common.psm1") -Force
$state = Get-StateDir
$pidFile = Join-Path $state "gitlab-runner.pid"

if (-not (Test-Path $pidFile)) { Write-Info "No PID file found. Runner not running?"; exit 0 }

$pid = Get-Content $pidFile -ErrorAction SilentlyContinue
if ($pid) {
  try {
    Write-Info "Stopping runner pid=$pid ..."
    Stop-Process -Id $pid -Force
  } catch {
    Write-Warn "Could not stop pid=$pid (already stopped?)"
  }
}

Remove-Item -Force $pidFile -ErrorAction SilentlyContinue
Write-Info "Stopped."
