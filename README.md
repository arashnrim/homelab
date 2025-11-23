# homelab

Welcome to the repository for my home lab! This repo will house the setup and configuration files for the services running in my home lab. For more details about my current home lab and the devices part of it, check out [the home lab page in my digital garden](https://garden.arash.codes/projects/homelabbing).

## Getting started

This repo contains applications separated by directories, such that the files needed to set them up and configure them are located in their own respective directories. As of now, most of the apps are containerised using Docker, and in due time Docker Compose files will be made available.

1. Clone the repository or download it as a ZIP file:

   ```sh
   git clone https://github.com/arashnrim/homelab.git
   cd homelab
   ```

2. Navigate into the directory of the services you are interested in.

   ```sh
   cd joplin-server # As an example — if you'd like to set up Joplin Server
   ```

3. Review any guidance messages, usually a README or some human-readable file, for any additional config. This may include tasks like setting up environment variables, so don't overlook this!

4. Use Docker Compose to build the app:

   ```sh
   docker compose up -d
   ```

## Core philosophies

These are the defining principles guiding the setup and maintenance of this home lab:

- **Version pinning** — where possible, pin to a specific version tag in preference to the `latest` tag. This ensures consistency and prevents issues where newer versions may introduce breaking changes or instability.
- **Documented in public** — any thoughts, experiences, and troubleshooting steps are documented in this repository in the form of README files or equivalent documentation.

## Contributing

Since the contents of this repo is meant for use in my home lab, this repo is not accepting contributions. You're welcome to contact me through other means though if you'd like to provide an input!

## Licence

This repo is made open-source with the [MIT Licence](https://github.com/arashnrim/homelab/blob/main/LICENSE.md), meaning that you are allowed to modify and distribute the source code as well as use it for private and commercial use provided that the licence and copyright notices are retained. For more information, visit the link above to learn more about what is permitted by the licence.
