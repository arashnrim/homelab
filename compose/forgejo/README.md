# Forgejo

Forgejo is a lightweight, self-hosted git service that provides an alternative to GitHub. It allows you to host your own repositories with a simple and intuitive web interface for version control and collaboration.

## Things to note

- Forgejo is configured to run on port `9002` for the web interface and port `222` for SSH access.
- The default UID and GID are set to `1000` to match typical user permissions on Linux systems.
- All data is persisted in a Docker volume for easy backup and recovery.
- Both the system timezone and local time are mounted as read-only volumes to ensure consistent time handling across containers.
