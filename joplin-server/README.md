# Joplin Server

Joplin is an open source note-taking app that allows you to capture your thoughts and securely access them from any device. This component runs a server that allows Joplin notes to be backed up to a machine.

# Things to note

- Instead of using the official Joplin Server image (`joplin/server:latest`), this set up uses eTechonomy's automated build of Joplin Server (`ghcr.io/etechonomy/joplin-server:latest`). This was due to a limitation back then when the official Joplin Server builds did not include an image that supports ARM64 (the architecture of the Raspberry Pi's CPU).
- The environment variable files is incomplete; make sure to complete them (or remove any irrelevant fields) before running.
  - See [Joplin Server's documentation](https://github.com/laurent22/joplin/blob/dev/packages/server/README.md#individual-variables) for more information on supported environment variables and expected values.

# Changes

- 22/11/2025: Instead of using a bind mount to store the stack's Postgres data (previously at `./data/postgres`), a volume is now used for consistency with other stacks and simplification.
