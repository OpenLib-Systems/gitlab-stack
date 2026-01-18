# gitlab-stack

A small, cross-platform "GitLab Runner stack" to bootstrap GitLab Runner locally:

- **Local (binary) runner**: installs and runs GitLab Runner in *user-space* (no admin required).
- **Docker runner**: runs GitLab Runner in a container via Docker Compose.
- **Optional local GitLab + runner**: for local testing (free GitLab CE + runner with Compose).

## Supported OS

- macOS (Intel + Apple Silicon)
- Linux (amd64 + arm64)
- Windows (amd64; ARM64 uses amd64 via emulation)

## Quickstart

See:

- `docs/01-quickstart.md`
- `docs/02-local-install.md`
- `docs/03-docker-runner.md`

## Notes

- New GitLab runner workflow uses runner authentication tokens (often with `glrt-` prefix).
- Docker mode may mount Docker socket for `docker` executor; read `docs/06-security.md`.

## License

see `LICENSE`
