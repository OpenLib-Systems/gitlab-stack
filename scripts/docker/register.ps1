param(
  [string]$RootDir,
  [string]$Url,
  [string]$Token,
  [string]$Name = "docker-runner",
  [string]$Tags = "",
  [string]$Executor = "docker",
  [string]$DockerImage = "alpine:latest"
)

if (-not $Url -or -not $Token) { throw "Need -Url and -Token" }

$tokenFlag = "--token"
if (-not $Token.StartsWith("glrt-")) { $tokenFlag = "--registration-token" }

$args = @("register","--non-interactive","--url",$Url,$tokenFlag,$Token,"--name",$Name,"--executor",$Executor,"--docker-image",$DockerImage)
if ($Tags) { $args += @("--tag-list",$Tags) }

& docker compose -f (Join-Path $RootDir "scripts\docker\compose.runner.yaml") up -d
& docker compose -f (Join-Path $RootDir "scripts\docker\compose.runner.yaml") exec -T gitlab-runner gitlab-runner @args
