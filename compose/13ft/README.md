# 13ft

13ft is a lightweight, self-hosted alternative to 12ft ladder that helps you bypass soft paywalls for reading articles. It proxies pages to strip paywall overlays so you can view content directly.

## Things to note

- No environment variables are required for basic operation.
- The web interface is available at port `9003` (mapped to the app's port 5000).
- This deployment uses the latest image from `ghcr.io/wasi-master/13ft` and restarts unless stopped.
