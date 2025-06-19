# Paperless-ngx

Paperless-ngx is a community-supported open-source document management system that transforms your physical documents into a searchable online archive so you can less paper.

# Things to note

- The environment variable files is incomplete; make sure to complete them (or remove any irrelevant fields) before running.
  - See [Paperless-ngx's documentation](https://docs.paperless-ngx.com/configuration/) for more information on supported environment variables and expected values.
- It's likely that Docker's implementation of a VM layer in macOS causes Paperless-ngx's consumer to fail to read new files in the consume directory. That's why `PAPERLESS_CONSUMER_POLLING` is set to a non-zero value to force Paperless-ngx to check every set interval instead of using the filesystem watcher to listen for filesystem changes.
  - See [the documentation for `PAPERLESS_CONSUMER_POLLING`](https://docs.paperless-ngx.com/configuration/#PAPERLESS_CONSUMER_POLLING) for more information.
