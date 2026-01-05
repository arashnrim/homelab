# Linkwarden

Linkwarden is a self-hosted collaborative link and article management platform. It allows you to save, organize, and share links and web articles with powerful search and discovery capabilities.

## Things to note

- The environment variable file (`.env`) is incomplete; make sure to complete it (or remove any irrelevant fields) before running.
  - See [Linkwarden's documentation](https://docs.linkwarden.app/) for more information on supported environment variables and expected values.
- This setup includes the main Linkwarden app, a PostgreSQL database, and Meilisearch for full-text search capabilities.
- The web interface is available at port `9005` (mapped to the app's port 3000).
- Meilisearch provides powerful search functionality for indexing and retrieving saved links.
- Make sure to configure `NEXTAUTH_URL` in the `.env` file for proper authentication setup.
- Persistent data is stored in Docker volumes for the application, database, and search index.
