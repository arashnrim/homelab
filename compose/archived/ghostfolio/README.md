# Ghostfolio

Ghostfolio is a self-hosted wealth management solution that helps you track, manage, and analyze your investment portfolio. It provides powerful insights into your assets and financial performance.

## Things to note

- The environment variable file (`.env`) is incomplete; make sure to complete it (or remove any irrelevant fields) before running.
  - See [Ghostfolio's documentation](https://ghostfol.io/docs) for more information on supported environment variables and expected values.
- This setup includes the main Ghostfolio app, a PostgreSQL database, and a Redis cache service.
- The web interface is available at port `9004` (mapped to the app's port 3333).
- Health checks are configured for all services to ensure proper startup and operation.
- The setup includes security features such as capability dropping and privilege restrictions.
- Redis is used for caching to improve performance.
