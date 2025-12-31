# Komodo

Komodo is a self-hosted DevOps orchestration and server management platform. It pairs a central controller (Core) with a lightweight agent (Periphery) to manage deployments, monitor hosts, and run automations across your infrastructure.

## Things to note

- The environment variable file (`stack.env`) is incomplete; fill in or clear any sensitive values before running.
  - See [Komodo's documentation](https://github.com/moghtech/komodo) for the full list of supported environment variables and configuration guidance.
- This setup runs three services: Komodo Core (`app`), MongoDB (`db`), and Komodo Periphery (`periphery`).
- The web interface is exposed on port `9012` (mapped to Core's port 9120).
- Core connects to MongoDB using credentials defined in `stack.env`; ensure `KOMODO_DB_USERNAME` and `KOMODO_DB_PASSWORD` match between Core and Mongo.
- Core and Periphery authenticate using `KOMODO_PASSKEY`; keep this secret and consistent across both services.
- Host mounts are used for backups and syncs (`/etc/komodo/backups`, `/etc/komodo/syncs`) and to give Periphery access to Docker (`/var/run/docker.sock`) and host metrics (`/proc`).
- Data is persisted in Docker volumes for MongoDB (`mongo_data`, `mongo_config`).
