# Arr Stack

The Arr Stack is a collection of media management applications that work together to automate the organization and acquisition of movies, TV shows, and subtitles. All services route through Gluetun VPN for privacy and security.

## Services

This stack includes:

- **Gluetun** - VPN client that all other services route through
- **qBittorrent** - BitTorrent client for downloading media
- **Jellyfin** - Media server for streaming and managing your media library
- **Radarr** - Movie management and automation
- **Sonarr** - TV show management and automation
- **Bazarr** - Subtitle management and automation

## Things to note

- The environment variable file (`.env`) is required for Gluetun VPN configuration.
  - See [Gluetun's documentation](https://github.com/qdm12/gluetun) for VPN provider setup and configuration options.
- Port mappings (all exposed through Gluetun):
  - Radarr: `7878` (movie management)
  - Sonarr: `8989` (TV show management)
  - Bazarr: `6767` (subtitle management)
  - qBittorrent: `8080` (web UI)
  - Jellyfin: `8096` (media server)
- All services run with UID/GID `1000` and UMASK `002` for consistent file permissions.
- Timezone is set to `Asia/Singapore` for all services.
- Configuration directories are mounted from `/etc/{service}/config` on the host.
- Media data is stored in `/mnt/sda/data/media` and shared across all services.
- Each service uses the latest Hotio images which are maintained and regularly updated.
