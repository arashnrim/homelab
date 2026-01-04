# SearXNG

SearXNG is a self-hosted privacy-focused search engine that aggregates results from multiple search engines while protecting your privacy. It provides an alternative to traditional search engines without tracking your searches.

## Things to note

- SearXNG is configured to run on port `9006` with the web interface available on port 8080.
- The default UID and GID are set to `1000` to match typical user permissions on Linux systems.
- Configuration is stored in `/etc/searxng`, which should be mounted to persist custom settings across container restarts.
- Search results cache is persisted in a Docker volume for improved performance.
- No authentication is required by default; consider implementing additional security measures if exposing this service over the network.
