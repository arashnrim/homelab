# Radicale

Radicale is a small but powerful CalDAV (calendars, to-do lists) and CardDAV (contacts) server, that:

- Shares calendars and contact lists through CalDAV, CardDAV and HTTP.
- Supports events, todos, journal entries and business cards.
- Works out-of-the-box, no complicated setup or configuration required.
- Can limit access by authentication.
- Can secure connections with TLS.
- Works with many CalDAV and CardDAV clients.
- Stores all data on the file system in a simple folder structure.
- Can be extended with plugins.
- Is GPLv3-licensed free software.

# Things to note

- Radicale does not offer an official Docker image, so a community-managed one (`tomsquest/docker-radicale`) is used. See more details about this image and the configuration it supports through [its GitHub page](https://github.com/tomsquest/docker-radicale).
- More config needs to be done to implement authentication; follow the steps below.

  1.  Check that `apache2-utils` is installed in your system; if not, install it:

      ```sh
      sudo apt install apache2-utils
      ```

  2.  Copy `config` to a preferred location store the configuration and user password files:

      ```sh
      cp ./config <preferred_location>
      ```

  3.  Use `htpasswd` to create a users file with a new user:

      ```sh
      htpasswd -cB <preferred_location>/config/users <username>
      ```

  4.  Ensure your `compose.yaml` mounts the config directory and references the users file (e.g., `<preferred_location>/config:/etc/radicale:ro`).
