param(
  [string]$RootDir,
  [string]$Prefix,
  [switch]$Background
)

Import-Module (Join-Path $RootDir "scripts\lib\Common.psm1") -Force

$runnerExe = Get-RunnerExePath $Prefix
if (-not (Test-Path $runnerExe)) { Throw-Err "gitlab-runner not found. Run: .\setup.ps1 -Mode Local -Action Install" }

$config = Join-Path $env:USERPROFILE ".gitlab-runner\config.toml"
if (-not (Test-Path $config)) { Throw-Err "No config found at $config. Run Register first." }

$state = Get-StateDir
New-Item -ItemType Directory -Force -Path $state | Out-Null
$pidFile = Join-Path $state "gitlab-runner.pid"
$logFile = Join-Path $state "runner.log"
$workDir = Join-Path $state "work"
New-Item -ItemType Directory -Force -Path $workDir | Out-Null

if (Test-Path $pidFile) {
  $pid = Get-Content $pidFile -ErrorAction SilentlyContinue
  if ($pid) {
    try { Get-Process -Id $pid -ErrorAction Stop | Out-Null; Write-Info "Runner already running (pid $pid)"; exit 0 } catch {}
  }
}

if ($Background) {
  Write-Info "Starting runner in background..."
  $p = Start-Process -FilePath $runnerExe -ArgumentList @("run","--working-directory",$workDir,"--config",$config) -WindowStyle Hidden -PassThru -RedirectStandardOutput $logFile -RedirectStandardError $logFile
  Set-Content -Path $pidFile -Value $p.Id
  Write-Info "Started. pid=$($p.Id)"
  Write-Info "Logs: $logFile"
} else {
  Write-Info "Starting runner in foreground (Ctrl+C to stop)..."
  & $runnerExe run --working-directory $workDir --config $config
}
