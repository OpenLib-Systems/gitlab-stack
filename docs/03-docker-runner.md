# Docker Runner

## Prerequisites

- Docker Engine / Docker Desktop
- Docker Compose v2 (`docker compose`)

## Start

```bash
./setup.sh start --mode docker
./setup.sh status --mode docker
```

```bash
.\setup.ps1 -Mode Docker -Action Start
.\setup.ps1 -Mode Docker -Action Status
```

## Register

```bash
./setup.sh register --mode docker --url "https://gitlab.com" --token "glrt-..." --name "docker-runner" --tags "docker" --executor docker --docker-image "alpine:latest"
```

```bash
.\setup.ps1 -Mode Docker -Action Register `
  -Url https://gitlab.com `
  -Token glrt-... `
  -Name docker-runner `
  -Executor docker `
  -DockerImage alpine:latest
```
