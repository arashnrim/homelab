# Watchtower

Watchtower is a containerized solution for automating Docker image updates. It periodically checks for updated container images and automatically updates running containers with the latest versions, helping keep your services current and secure.

# Things to note

- The environment variable file can be used to configure Watchtower's update behavior, notification settings, and scheduling preferences.
  - See [Watchtower's documentation](https://containrrr.dev/watchtower/) for more information on supported environment variables and configuration options.
- Watchtower needs access to the Docker daemon via the socket mount (`/var/run/docker.sock`) to manage containers.
