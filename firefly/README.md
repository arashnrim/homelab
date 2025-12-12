# Firefly III

Firefly III is a self-hosted personal finance manager designed to help you keep track of your expenses, income, budgets, and more. It provides a powerful interface for managing your finances and generating insightful reports.

## Things to note

- The environment variable file (`stack.env`) is incomplete; make sure to complete it (or remove any irrelevant fields) before running.
  - See [Firefly III's documentation](https://docs.firefly-iii.org/) for more information on supported environment variables and expected values.
- This setup includes the main Firefly III app, a MariaDB database, a data importer service, and a cron job for scheduled tasks.
- The default web interface is available at port `9002` (mapped to the app's port 8080).
- The data importer is available at port `9003`.
- Database credentials and other sensitive information are managed via the `stack.env` file.
- Persistent data is stored in Docker volumes for both uploads and the database.
