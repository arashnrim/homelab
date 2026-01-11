# AdGuard Home

AdGuard Home is a self-hosted DNS filtering service that acts as a network-wide ad blocker and privacy protection tool. It intercepts DNS requests and blocks ads, trackers, and malicious domains across your entire network.

## Things to note

- No environment variables are required for basic operation.
- The service uses `host` network mode, meaning it runs on the host's network directly rather than in a Docker network.
- Default ports:
  - DNS: `53` (for DNS queries)
  - HTTP: `3000` (for initial setup)
  - HTTPS: `443` (for HTTPS requests)
- Configuration and data are persisted in host directories:
  - `/etc/adguard/conf` - AdGuard Home configuration files
  - `/etc/adguard/work` - Working directory with filters and statistics
- Back up `/etc/adguard/conf` to preserve your filtering rules and settings.
- See [AdGuard Home documentation](https://adguard.com/en/adguardhome/overview.html) for configuration and setup guidance.
