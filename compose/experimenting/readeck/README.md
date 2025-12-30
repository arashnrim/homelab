# Readeck

Readeck is a self-hosted read-it-later service that allows you to save and manage articles and web content for offline reading. It provides a clean reading experience without distractions.

## Things to note

- The environment variable file (`stack.env`) is incomplete; make sure to complete it (or remove any irrelevant fields) before running.
  - See [Readeck's documentation](https://readeck.org/) for more information on supported environment variables and expected values.
- This setup includes the Readeck app and a PostgreSQL database for storing your articles and reading list.
- The web interface is available at port `9011` (mapped to the app's port 8000).
- Health checks are configured for both the app and database to ensure proper startup.
- Readeck data is persisted in Docker volumes for article storage and database management.
- The app depends on the database being healthy before starting.
