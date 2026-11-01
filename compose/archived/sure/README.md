# Sure

Sure is a self-hosted personal finance application for tracking accounts, spending, cash flow, and net worth.

## Things to note

- The environment variables are defined inline with defaults, but set any required secrets and optional `OPENAI_ACCESS_TOKEN` value before running.
  - See [Sure's Docker hosting documentation](https://github.com/we-promise/sure/blob/main/docs/hosting/docker.md) for more information on deployment and configuration.
- The web interface is available at port `3000` by default (mapped to the app's port 3000); set `PORT` to change it.
- This setup includes the Sure web app, a Sidekiq worker, PostgreSQL, and Redis.
- Application data, PostgreSQL data, and Redis data are persisted in Docker volumes.
- The optional `backup` profile creates daily PostgreSQL backups under `/etc/sure/backups` and retains them by age.
