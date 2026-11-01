# Komodo Periphery

Komodo Periphery is the agent that lets Komodo manage deployments, containers, and host operations on a remote server.

## Things to note

- The environment variable file (`.env`) is required; complete it before running.
  - See [Komodo's Periphery documentation](https://github.com/moghtech/komodo/blob/main/scripts/readme.md) for configuration guidance.
- The Periphery API is available at port `8120`.
- The container requires access to the Docker socket and the host's `/proc` filesystem for Docker operations and host metrics.
- Komodo configuration is persisted through the `/etc/komodo` host mount and the `keys` Docker volume.
- Treat the `.env` file, Docker socket access, and mounted configuration as sensitive.
