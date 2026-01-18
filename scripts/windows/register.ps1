param(
  [string]$RootDir,
  [string]$Url,
  [string]$Token,
  [string]$Name = "win-runner",
  [string]$Tags = "",
  [string]$Executor = "shell",
  [string]$Prefix
)

Import-Module (Join-Path $RootDir "scripts\lib\Common.psm1") -Force
$runnerExe = Get-RunnerExePath $Prefix
if (-not (Test-Path $runnerExe)) { Throw-Err "gitlab-runner not found. Run: .\setup.ps1 -Mode Local -Action Install" }

if (-not $Url -or -not $Token) {
  Write-Info "Interactive registration (missing -Url or -Token)."
  & $runnerExe register
  exit 0
}

# New workflow tokens often start with glrt-
$tokenFlag = "--token"
if (-not $Token.StartsWith("glrt-")) { $tokenFlag = "--registration-token" }

$args = @("register","--non-interactive","--url",$Url,$tokenFlag,$Token,"--name",$Name,"--executor",$Executor)
if ($Tags) { $args += @("--tag-list",$Tags) }

Write-Info "Registering runner '$Name'..."
& $runnerExe @args
Write-Info "Done. Config is usually at: $env:USERPROFILE\.gitlab-runner\config.toml"
