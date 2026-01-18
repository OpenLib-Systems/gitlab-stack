# Troubleshooting

## Runner registered but not picking jobs

- Check tags match your `.gitlab-ci.yml`
- Check runner is online in GitLab UI
- Check runner logs:
  - macOS/Linux local mode: `~/.local/state/gitlab-stack/runner.log`
  - Docker mode: `docker compose -f scripts/docker/compose.runner.yaml logs -f`

## Token issues

- New workflow tokens often start with `glrt-`. If you have older registration tokens, they may behave differently depending on your GitLab version.
- If unsure: create a runner in GitLab UI and use the provided token.

## Docker permission issues

- If Docker executor is used, your runner container may need access to Docker. See `docs/06-security.md`.
