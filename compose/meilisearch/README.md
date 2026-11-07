# Meilisearch

Meilisearch is a fast, open-source search engine with typo tolerance, faceting and an HTTP API. It is a good fit for adding search to your own apps, notes or content without running a heavy search cluster.

## Things to note

- `.env` is the committed template, with `MEILI_MASTER_KEY` left blank. Generate the key with `openssl rand -base64 32`.
- With `MEILI_ENV=production`, Meilisearch refuses to start without a master key.
- The API is available on port `9014` (mapped to the container's port 7700).
- Indexes are persisted in the `data` Docker volume, mounted at `/meili_data`.
- `MEILI_NO_ANALYTICS=true` stops Meilisearch from sending usage telemetry.
- Use the master key only for administration. Create scoped API keys for applications through the `/keys` endpoint.
- There is no reverse proxy or authentication layer in this stack. Anyone who can reach port 9014 can query the API, and anyone with the master key can change everything. Keep it on the tailnet or behind your proxy.
