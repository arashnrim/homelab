# Uptime Kuma

Uptime Kuma is a self-hosted status page and uptime monitoring solution. It allows you to monitor the availability of your services and display status information to your users.

## Things to note

- The web interface is available at port `9007` (mapped to the app's port 3001).
- The Docker socket is mounted as read-only to allow Uptime Kuma to monitor Docker containers.
- All monitoring data is persisted in a Docker volume for historical tracking and reporting.
- No environment variables are required for basic operation.
