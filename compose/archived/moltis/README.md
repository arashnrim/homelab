# Moltis

Moltis is a self-hosted AI gateway and agent platform built in Rust. It provides a unified interface to multiple LLM providers with built-in features for voice I/O, memory management, scheduling, multi-channel communication (Telegram, Discord, Teams), and sandboxed tool execution. Everything runs locally with a focus on security, auditability, and control.

## Things to note

- The application runs in a container with access to the Docker socket for sandboxed tool execution.
  - See [Moltis's documentation](https://docs.moltis.org/) for more information on configuration, features, and usage.
- Initial setup requires completing the setup process at the web interface to set your password or register a passkey.
- The web interface is available at port `13131` (mapped to the app's port 13131).
- Additional ports may be used for WebSocket connections (`13132`) and other services.
- Persistent configuration and data are stored in Docker volumes for sessions, memory, and settings.
- The container requires access to `/var/run/docker.sock` to execute tools in isolated containers.
- Supports multiple LLM providers (OpenAI, GitHub Copilot, local models) and various integrations (MCP servers, Telegram, Discord, etc.).
