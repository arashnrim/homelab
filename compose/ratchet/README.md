# Ratchet

Ratchet is an internal tool designed to assist with day-to-day mechanic work.

## Things to note

- The environment variable file (`.env`) is required; complete it before running.
- No host port or persistent volume is defined in this Compose file, so access and data persistence must be provided through the container's environment and the surrounding infrastructure.
- The application image is pulled from `ghcr.io/arashnrim/ratchet`.
