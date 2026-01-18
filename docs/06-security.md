# Security Notes

## Docker socket mount

Mounting `/var/run/docker.sock` into the runner container effectively grants the runner high privileges over the host's Docker daemon.
Only enable this if you understand the implications and the runner is trusted.

## Secrets

Do not hardcode tokens in repo files.
Use environment variables, protected CI variables, or a secrets manager.

## Least privilege

This repo defaults to user-space runner installs (no admin), and avoids system-wide services by default.
