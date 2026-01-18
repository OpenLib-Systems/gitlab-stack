param(
  [ValidateSet("Local","Docker","LocalGitLab")]
  [string]$Mode = "Local",

  [ValidateSet("Install","Register","Start","Stop","Status","Uninstall","Help")]
  [string]$Action = "Help",

  [string]$Url = "",
  [string]$Token = "",
  [string]$Name = "",
  [string]$Tags = "",
  [ValidateSet("shell","docker")]
  [string]$Executor = "shell",
  [string]$DockerImage = "alpine:latest",
  [string]$Prefix = "",
  [switch]$Background
)

$RootDir = Split-Path -Parent $MyInvocation.MyCommand.Path
Import-Module (Join-Path $RootDir "scripts\lib\Common.psm1") -Force

switch ($Action) {
  "Help" {
    Write-Host "Usage examples:"
    Write-Host "  .\setup.ps1 -Mode Local  -Action Install"
    Write-Host "  .\setup.ps1 -Mode Local  -Action Register -Url https://gitlab.com -Token glrt-... -Name win-runner -Tags windows,msvc -Executor shell"
    Write-Host "  .\setup.ps1 -Mode Local  -Action Start -Background"
    Write-Host "  .\setup.ps1 -Mode Docker -Action Start"
    exit 0
  }

  default {
    if ($Mode -eq "Local") {
      & (Join-Path $RootDir "scripts\windows\$Action.ps1") `
        -RootDir $RootDir -Url $Url -Token $Token -Name $Name -Tags $Tags -Executor $Executor -Prefix $Prefix -Background:$Background
    }
    elseif ($Mode -eq "Docker") {
      & (Join-Path $RootDir "scripts\docker\$Action.ps1") `
        -RootDir $RootDir -Url $Url -Token $Token -Name $Name -Tags $Tags -Executor $Executor -DockerImage $DockerImage
    }
    elseif ($Mode -eq "LocalGitLab") {
      if ($Action -in @("Start","Stop","Status")) {
        & (Join-Path $RootDir "scripts\docker\$Action.ps1") -RootDir $RootDir -Stack "local-gitlab"
      } else {
        Write-Host "LocalGitLab supports only: Start|Stop|Status (Docker required)."
      }
    }
  }
}
