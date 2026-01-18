# Local GitLab + Runner (optional)

This spins up a local GitLab CE instance + runner via Docker Compose. Useful for testing pipelines locally.

Start:

- macOS/Linux: `./setup.sh start --mode local-gitlab`
- Windows: `.\setup.ps1 -Mode LocalGitLab -Action Start`

GitLab will be exposed on: <http://localhost:8929> (default in compose).

**Resource note:** GitLab can be heavy (RAM/CPU). If it feels slow, increase Docker Desktop resources.
