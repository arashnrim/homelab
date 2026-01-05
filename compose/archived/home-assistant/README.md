# Home Assistant

Home Assistant is an open-source home automation platform that brings together all the smart devices in your home into one system. It provides a unified interface to monitor and control devices from various manufacturers and integrations.

# Things to note

- This setup uses the official Home Assistant container image running in host network mode to ensure compatibility with network-dependent automations and integrations.
- Configuration is stored at `/etc/homelab/home_assistant/config`, which is mounted as a volume and persists between container restarts.
- The container runs in privileged mode to allow access to system resources needed for certain integrations (e.g., Z-Wave, Zigbee adapters).
