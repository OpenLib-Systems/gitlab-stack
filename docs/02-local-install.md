# Local (Binary) Runner

## Where it installs

- macOS/Linux default: `~/.local/bin/gitlab-runner`
- Windows default: `%LOCALAPPDATA%\gitlab-stack\bin\gitlab-runner.exe`

Config file created by registration:

- macOS/Linux: `~/.gitlab-runner/config.toml`
- Windows: `%USERPROFILE%\.gitlab-runner\config.toml`

## Start/Stop

- Start in background:
  - macOS/Linux: `./setup.sh start --mode local --background`
  - Windows: `.\setup.ps1 -Mode Local -Action Start -Background`
- Stop:
  - macOS/Linux: `./setup.sh stop --mode local`
  - Windows: `.\setup.ps1 -Mode Local -Action Stop`
