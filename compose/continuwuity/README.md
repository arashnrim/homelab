# Continuwuity

Continuwuity is a lightweight, high-performance Matrix homeserver. This stack runs the pinned `v26.9.3` image and stores its database and media data in a Docker volume.

## Things to note

- Set `CONTINUWUITY_SERVER_NAME` in `.env` before starting the service. This is the stable Matrix homeserver domain and should not be changed after users and rooms have been created. It does not have to be the same host name used to reach the service, but the chosen domain must be configured for Matrix federation if federation is required.
- The service listens on port `8008` and is published on the Docker host at port `8008`.
- The `data` Docker volume is mounted at `/var/lib/continuwuity` and persists the homeserver database and media files. Back it up before upgrades or other maintenance.
- The compose file binds the service to `0.0.0.0` inside the container. There is no TLS or reverse proxy in this stack, so place it behind a reverse proxy for HTTPS and restrict direct access to port `8008` as appropriate.
- The image is pinned by version and digest. The container command remains `/sbin/conduwuit` because Continuwuity is derived from Conduwuit.

## Getting started

1. Set the server name in `.env`:

   ```sh
   CONTINUWUITY_SERVER_NAME=example.org
   ```

2. Start the service:

   ```sh
   docker compose up -d
   ```

3. Follow the logs if needed:

   ```sh
   docker compose logs -f app
   ```

Stop the service with `docker compose down`. The named volume is not removed by this command.

See the [Continuwuity repository](https://forgejo.ellis.link/continuwuation/continuwuity) and [Matrix federation documentation](https://matrix.org/docs/older/server-server-api/) for more information.
