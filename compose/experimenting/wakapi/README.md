# Wakapi

Wakapi is a self-hosted WakaTime alternative that tracks your coding activity and provides insights into your development habits. It helps you monitor productivity and analyze your coding patterns.

## Things to note

- The environment variable file (`stack.env`) is incomplete; make sure to complete it (or remove any irrelevant fields) before running.
  - See [Wakapi's documentation](https://github.com/muety/wakapi) for more information on supported environment variables and expected values.
- This setup includes the Wakapi app and a PostgreSQL database for storing activity data.
- The web interface is available at port `9008` (mapped to the app's port 3000).
- A PostgreSQL database is used to persist all coding activity records and user statistics.
- Persistent data is stored in Docker volumes for long-term analytics and history.
