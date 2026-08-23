# Glance Agent

Glance Agent is a lightweight companion service for Glance that provides system metrics and health information to be displayed in your Glance dashboard.

## Things to note

- No environment variables or configuration files are required for basic operation.
- The agent runs on port `27973` for communication with the Glance dashboard.
- Storage volumes can be mounted as read-only to expose disk information to the dashboard.
- This agent collects system metrics such as CPU, memory, disk usage, and other host information.
- See [Glance documentation](https://github.com/glanceapp/glance) for integration details with your Glance dashboard.
