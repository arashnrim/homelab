# Vaultwarden

Vaultwarden is a lightweight, self-hosted Bitwarden-compatible server. It provides secure vault storage for passwords, notes, and other secrets while remaining resource efficient.

## Things to note

- The environment variable file (`.env`) is incomplete; make sure to complete it (or remove any irrelevant fields) before running.
  - See [Vaultwarden's documentation](https://github.com/dani-garcia/vaultwarden) for more information on supported environment variables and expected values.
- The web interface and API are exposed on port `9012` (mapped to the container's port 80).
- Persistent data is stored in the `data` volume; back it up to avoid vault loss.
- Set `DOMAIN` in `.env` to the externally reachable URL so invites and links work correctly.
