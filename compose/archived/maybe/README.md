# Maybe

Maybe is a self-hosted personal finance management application built with Rails. It provides comprehensive financial tracking, analysis, and planning tools for managing your wealth.

## Things to note

- The environment variable file (`stack.env`) is incomplete; make sure to complete it (or remove any irrelevant fields) before running.
  - See [Maybe's documentation](https://github.com/maybe-finance/maybe) for more information on supported environment variables and expected values.
- This setup includes the main Maybe app, a Rails worker for background jobs, a PostgreSQL database, and Redis for caching and job queuing.
- The web interface is available at port `9002` (mapped to the app's port 3000).
- Health checks are configured for both the database and Redis to ensure proper startup.
- OpenAI integration is optional; if enabled, ensure you have set spending limits on your account to avoid unexpected charges.
- Persistent data is stored in Docker volumes for the database, cache, and application storage.
- The app uses Rails Sidekiq for asynchronous job processing through the dedicated worker service.
