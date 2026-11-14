# Continuwuity

Continuwuity is a lightweight, high-performance Matrix homeserver. This stack runs the pinned `v26.9.3` image and stores its database and media data in a Docker volume. A dedicated Unbound resolver provides DNS caching for federation traffic.

## Things to note

- Set `CONTINUWUITY_SERVER_NAME` in `.env` or the stack's runtime environment before starting. This is the stable Matrix homeserver domain and should not be changed after users and rooms have been created. It does not have to be the same hostname used to reach the service, but that domain must be configured for Matrix federation if federation is required.
- Continuwuity listens on container port `8008`; Compose publishes it on host port `9006` (`9006:8008`). Docker's default publish address is all host interfaces. This stack has no TLS or reverse proxy, so restrict direct access or put it behind a reverse proxy.
- The `data` Docker volume is mounted at `/var/lib/continuwuity` and persists the homeserver database and media files. Back it up before upgrades or other maintenance.
- Continuwuity's upstream [DNS tuning guide](https://continuwuity.org/guides/dns.html) recommends a dedicated caching resolver because Docker's bridge DNS can struggle under Matrix federation query load. This stack runs Unbound on the private Compose network at `10.10.10.20`; the app mounts `continuwuity-resolv.conf` as `/etc/resolv.conf`. The resolver's DNS port is not published to the host.
- Compose starts Unbound before Continuwuity, but `depends_on` does not wait for DNS readiness; no healthcheck is configured.
- Unbound performs recursive DNS resolution and maintains its query cache in memory. It can make outbound DNS queries, which are required for recursion. The `unbound_data` Docker volume persists its DNSSEC trust-anchor state under `/var/unbound`; cached answers themselves are not persistent across container restarts.
- The `dns` network uses the fixed subnet `10.10.10.0/24`, with Unbound assigned `10.10.10.20`. This subnet was checked against the Mac mini's current Docker networks and host routes; check for overlap before reusing the stack on another host.
- Mounting a custom `/etc/resolv.conf` bypasses Docker's embedded DNS for the Continuwuity container. It will not resolve other containers by Compose service name. If appservices or other container-hostname dependencies are added later, give them static IPs and configure them accordingly, or revise the DNS design.
- The Continuwuity image remains pinned by version and digest. Unbound is pinned to `1.26.2` by tag and multi-architecture index digest.

## Getting started

1. Set `CONTINUWUITY_SERVER_NAME` in the environment configured for the stack.
2. Start the service:

   ```sh
   docker compose up -d
   ```

3. Follow the logs if needed:

   ```sh
   docker compose logs -f app unbound
   ```

Stop the stack with `docker compose down`. This removes the containers and project network but keeps the named volumes.

See the [Continuwuity repository](https://forgejo.ellis.link/continuwuation/continuwuity), [Continuwuity DNS tuning guide](https://continuwuity.org/guides/dns.html), [Unbound image source](https://github.com/klutchell/unbound-docker), and [Matrix federation documentation](https://matrix.org/docs/older/server-server-api/) for more information.
