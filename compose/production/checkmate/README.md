# Checkmate

Checkmate is a self-hosted website monitoring and uptime tracking solution. It provides real-time monitoring of your services with comprehensive status reporting and alerting capabilities.

## Things to note

- The environment variable file (`stack.env`) is incomplete; make sure to complete it (or remove any irrelevant fields) before running.
  - See [Checkmate's documentation](https://github.com/bluewave-labs/checkmate) for more information on supported environment variables and expected values.
- This setup includes the main Checkmate app and a MongoDB database for storing monitoring data.
- The web interface is available at port `9009` (mapped to the app's port 52345).
- MongoDB health checks are configured to ensure the database is ready before the app starts.
- Always pull the latest image to ensure you have the most recent features and security updates.
- Persistent data is stored in Docker volumes for historical monitoring records.
