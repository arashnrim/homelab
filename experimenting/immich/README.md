# Immich

Immich is a self-hosted photo and video backup solution that provides an alternative to Google Photos. It offers powerful searching, advanced machine learning capabilities, and a beautiful interface for organizing and viewing your media library.

# Things to note

- The environment variable file is incomplete; make sure to complete them (or remove any irrelevant fields) before running.
  - See [Immich's documentation](https://immich.app/docs/install/environment-variables) for more information on supported environment variables and expected values.
- This setup includes a Machine Learning (ML) service for intelligent photo search and classification. You can optionally enable hardware acceleration for transcoding and ML inference by uncommenting the relevant `extends` sections in the docker-compose.yml file and selecting an appropriate accelerator (e.g., `nvenc`, `quicksync`, `vaapi` for transcoding; `cuda`, `rocm`, `openvino` for ML).
- The setup uses Redis for caching and a custom Postgres database with vector extensions for efficient media analysis.
- Faced a weird pecularity where the Immich web app won't start because it cannot find the database — it attempts connecting to something with the hostname `database`, but to no avail. A custom fix has been implemented where the hostname `immich-db` has been assigned to the database container manually, and this seems to work for now!
