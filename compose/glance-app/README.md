# Glance

Glance is a self-hosted dashboard that aggregates feeds and information at a glance. It provides a customizable homepage with widgets for RSS feeds, videos, calendars, and more.

## Things to note

- Configuration is managed through the `glance.yml` file mounted at `/app/config` in the container.
  - See [Glance's documentation](https://github.com/glanceapp/glance) for more information on widget configuration and customization options.
- The web interface is available at port `9000` (mapped to the app's port 8080).
- No database is required; all configuration is file-based.
- Configuration files should be placed in `/etc/glance/config` on the host.
- The dashboard supports various widget types including RSS feeds, calendars, videos, Hacker News, and more.
