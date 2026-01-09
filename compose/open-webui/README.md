# Open WebUI

Open WebUI is a self-hosted web interface for interacting with LLMs (large language models). It provides a user-friendly chat interface compatible with Ollama and other LLM backends.

## Things to note

- The environment variable file (`.env`) should be configured; make sure to complete it before running.
  - See [Open WebUI's documentation](https://github.com/open-webui/open-webui) for more information on supported environment variables and expected values.
- The web interface is available at port `9000` (mapped to the app's port 8080).
- `OLLAMA_BASE_URL` should point to your Ollama instance (e.g., `http://ollama:11434` if running in the same network).
- `OPENWEBUI_API_KEY` is used for API authentication; set a strong, secure value.
- All data including conversations, settings, and models are persisted in the `data` volume.
