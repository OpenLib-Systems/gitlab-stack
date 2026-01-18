param(
  [string]$RootDir,
  [string]$Prefix
)

Import-Module (Join-Path $RootDir "scripts\lib\Common.psm1") -Force

if (-not $Prefix) { $Prefix = Get-DefaultPrefix }
New-Item -ItemType Directory -Force -Path $Prefix | Out-Null

$runnerExe = Get-RunnerExePath $Prefix
$arch = $env:PROCESSOR_ARCHITECTURE

# GitLab provides windows-amd64 + windows-386; on ARM64, amd64 generally runs via emulation
$url = "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-windows-amd64.exe"
if ($arch -eq "x86") {
  $url = "https://gitlab-runner-downloads.s3.amazonaws.com/latest/binaries/gitlab-runner-windows-386.exe"
}

Write-Info "Downloading GitLab Runner from: $url"
$tmp = Join-Path $env:TEMP "gitlab-runner.exe"
Invoke-WebRequest -Uri $url -OutFile $tmp -UseBasicParsing

Move-Item -Force $tmp $runnerExe
Write-Info "Installed: $runnerExe"

& $runnerExe --version
Write-Info "Tip: add '$Prefix' to your user PATH if you want to call 'gitlab-runner' directly."
