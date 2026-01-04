# YOURLS

YOURLS is a self-hosted URL shortener that lets you create and manage short links with your own domain.

## Things to note

- The environment variable file (`.env`) is incomplete; fill in or clear any sensitive values before running.
  - See [YOURLS documentation](https://yourls.org/) for supported environment variables and setup guidance.
- This setup includes the YOURLS app and a MySQL database.
- The web interface is available at port `9004` (mapped to the app's port 8080).
- Required credentials: `YOURLS_USER`, `YOURLS_PASS`, `YOURLS_SITE`, and matching database settings (`YOURLS_DB_PASS`, `MYSQL_ROOT_PASSWORD`, `MYSQL_DATABASE`).
- Database data is stored in the `db` volume; back it up to preserve short links.
