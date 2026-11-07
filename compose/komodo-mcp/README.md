# Komodo MCP Server

Model Context Protocol server for [Komodo](https://github.com/moghtech/komodo). It lets MCP-capable AI assistants list, inspect and act on the containers, stacks, deployments and servers that Komodo manages. It runs over HTTP on host port `9015`.

## Things to note

- Required values: `KOMODO_URL` (the address of Komodo Core, port `9120` by default), `KOMODO_API_KEY` and `KOMODO_API_SECRET`. Create the API key in Komodo under a service account with the narrowest permissions that still do the job.
- Authentication is on by default (`MCP_AUTH_ENABLED=true`). Clients sign in with a Komodo account and act with that account's permissions. If the Komodo URL or credentials are missing, the server rejects every request rather than running open.
- Port `9015` is published on all host interfaces, and there is no reverse proxy or TLS in front, so traffic is plain HTTP. Keep it on the tailnet, or put it behind Caddy before it goes anywhere wider.
- Destructive actions (delete, destroy, prune, exec) need explicit confirmation in the MCP client, and the server fails closed on clients that cannot prompt.
- The image is pinned to `1.5.0` by index digest. The image has no persistent volume, since the server keeps no state of its own.
- `/health` reports that the process is running, and the image's built-in healthcheck uses `/ready`. In a smoke test, `/ready` returned 200 even with an unreachable Komodo URL, so it is not proof of a working Komodo connection. Confirm that with a real MCP call (for example `komodo_health_check`).
- A blank `KOMODO_URL` makes the container exit on startup, because the server validates the URL first.
- The optional `config.toml` mount from upstream is left out. Everything is configured through `.env`.
