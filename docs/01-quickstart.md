# Quickstart

## Choose a mode

- **Local**: installs GitLab Runner as a single binary in user space (no admin).
- **Docker**: runs runner in a container using Docker Compose.
- **LocalGitLab (optional)**: runs GitLab CE + Runner for local testing (Docker Compose).

## macOS/Linux

```bash
./setup.sh install --mode local
./setup.sh register --mode local --url "https://gitlab.com" --token "glrt-..." --name "my-runner" --tags "linux" --executor "shell"
./setup.sh start --mode local --background
./setup.sh status --mode local
```

## Windows

```bash
.\setup.ps1 -Mode Local -Action Install
.\setup.ps1 -Mode Local -Action Register -Url "https://gitlab.com" -Token "glrt-..." -Name "win-runner" -Tags "windows" -Executor "shell"
.\setup.ps1 -Mode Local -Action Start -Background
.\setup.ps1 -Mode Local -Action Status
```
