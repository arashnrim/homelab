# Termix

Termix is a self-hosted terminal multiplexer and session manager with a web interface. It provides persistent terminal sessions accessible through your browser.

## Things to note

- No environment variable files are required; all configuration is inline.
- The web interface is available at port `9013` (mapped to the app's port 8080).
- All session data and configurations are persisted in the `data` volume.
- See [Termix's documentation](https://github.com/lukegus/termix) for more information on usage and features.
