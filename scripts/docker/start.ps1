param(
  [string]$RootDir,
  [string]$Stack = "runner"
)

Import-Module (Join-Path $RootDir "scripts\lib\Common.psm1") -Force

$compose = "docker"
$null = & $compose compose version 2>$null
if ($LASTEXITCODE -ne 0) { Throw-Err "Docker Compose v2 not available. Install Docker Desktop / Docker Engine." }

New-Item -ItemType Directory -Force -Path (Join-Path $RootDir ".runner\config") | Out-Null
New-Item -ItemType Directory -Force -Path (Join-Path $RootDir ".runner\cache") | Out-Null

if ($Stack -eq "local-gitlab") {
  Write-Info "Starting local GitLab + runner..."
  & docker compose -f (Join-Path $RootDir "scripts\docker\compose.local-gitlab.yaml") up -d
} else {
  Write-Info "Starting runner..."
  & docker compose -f (Join-Path $RootDir "scripts\docker\compose.runner.yaml") up -d
}
