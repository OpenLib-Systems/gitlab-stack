param(
  [string]$RootDir,
  [string]$Stack = "runner"
)

if ($Stack -eq "local-gitlab") {
  & docker compose -f (Join-Path $RootDir "scripts\docker\compose.local-gitlab.yaml") ps
} else {
  & docker compose -f (Join-Path $RootDir "scripts\docker\compose.runner.yaml") ps
}
