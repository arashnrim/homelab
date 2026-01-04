# Karakeep

Karakeep is a self-hosted karaoke management and streaming application. It provides a platform for organizing and managing karaoke songs with search functionality and web interface support.

## Things to note

- The environment variable file (`stack.env`) is incomplete; make sure to complete it (or remove any irrelevant fields) before running.
  - See [Karakeep's documentation](https://github.com/karakeep-app/karakeep) for more information on supported environment variables and expected values.
- This setup includes the main Karakeep app, Chrome for headless browsing, and Meilisearch for search functionality.
- The web interface is available at port `9010` (mapped to the app's port 3000).
- Chrome runs on port 9222 and is used internally by Karakeep for screenshot/preview generation.
- Meilisearch provides full-text search capabilities for the karaoke library.
- All data is persisted in Docker volumes for songs and search index.
