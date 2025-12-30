# wger

wger is a self-hosted workout and exercise management platform. It provides tools for creating and tracking workouts, managing exercises, and monitoring your fitness progress.

## Things to note

- The environment variable file (`stack.env`) is incomplete; make sure to complete it (or remove any irrelevant fields) before running.
  - See [wger's documentation](https://wger.de/en/software/api) for more information on supported environment variables and expected values.
- This setup includes the wger app with an Nginx reverse proxy, a PostgreSQL database, and a Redis cache.
- The web interface is available at port `9012` (mapped through Nginx on port 80).
- Health checks are configured for all services to ensure proper startup and operation.
- Static files and media uploads are persisted in Docker volumes.
- Nginx is used as a reverse proxy to serve the application with proper routing and static file handling.
- Redis cache is used to improve application performance.
