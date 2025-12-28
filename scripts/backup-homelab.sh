#!/bin/bash

# Sources any environment variables from .env file if it exists
if [ -f .env ]; then
    source .env
fi

###
# Docker volumes
###

# Get list of non-dangling Docker volumes
volumes=$(sudo docker volume ls -f dangling=false -q)

echo "[i] Retrieved $(echo "$volumes" | wc -l) volumes. Backing up into ./volumes..."

# Creates /volumes directory if it doesn't exist
mkdir -p ./volumes

# Read and process each volume
while IFS= read -r volume; do
    if sudo docker run --rm -v "${volume}":/volume:ro -v "$(pwd)/volumes":/backup alpine tar czf /backup/"${volume}".tar.gz -C /volume .; then
        echo "[✓] Successfully backed up volume ${volume} to ./volumes/${volume}.tar.gz."
    else
        echo "[✗] Failed to backup volume ${volume}."
    fi
done <<< "$volumes"

###
# Docker bind mounts
###

# Gets bind mount volumes
bind_mounts=$(sudo docker ps -q | xargs -r sudo docker inspect --format '{{ range .Mounts }}{{ if eq .Type "bind" }}{{ printf "%s\n" .Source }}{{ end }}{{ end }}' | sort -u)

# Filter bind mounts to only include those in /etc/
bind_mounts=$(echo "$bind_mounts" | grep '^/etc/')

echo -e "\n[i] Retrieved $(echo "$bind_mounts" | wc -l) bind mounts. Backing up into ./bind_mounts..."

# Creates /bind_mounts directory if it doesn't exist
mkdir -p ./bind_mounts

# Read and process each bind mount
while IFS= read -r bind_mount; do
    base_name=$(basename "$bind_mount")

    if sudo tar czf "./bind_mounts/${base_name}.tar.gz" -C "$(dirname "$bind_mount")" "$base_name"; then
        echo "[✓] Successfully backed up bind mount ${bind_mount} to ./bind_mounts/${base_name}.tar.gz."
    else
        echo "[✗] Failed to backup bind mount ${bind_mount}."
    fi
done <<< "$bind_mounts"

###
# Manual back-up locations
###

echo -e "\n[i] Backing up manual locations (hint: edit manual_backups array in the script)..."

# Array of manual backup locations
manual_backups=(
    "/etc/caddy/Caddyfile"
)

mkdir -p ./manual

# Process each manual backup location
for file in "${manual_backups[@]}"; do
    if [ -f "$file" ]; then
        sudo cp "$file" "./manual/$(basename "$file").bak"

        if [ $? -eq 0 ]; then
            echo "[✓] Successfully backed up $file to ./manual/$(basename "$file").bak."
        else
            echo "[✗] Failed to backup $file."
        fi
    else
        echo "[i] $file does not exist. Skipping."
    fi
done

echo -e "\n[i] Backup process completed."

###
# Optional: Back up to HDD
###

read -r -p "[?] Back up to HDD? (y/N): " backup_to_hdd

if [[ "$backup_to_hdd" =~ ^[Yy]$ ]]; then
    if [[ -z "${BACKUP_LOCATION:-}" ]]; then
        echo "[✗] BACKUP_LOCATION is not set. Aborting HDD backup."
    else
        echo "[i] Starting backup to HDD..."
        mkdir -p "./$(hostname -s)_backup"
        cp -r ./volumes ./bind_mounts ./manual "./$(hostname -s)_backup/"
        tar czf "./$(hostname -s)_backup.tar.gz" "./$(hostname -s)_backup/"
        if scp "./$(hostname -s)_backup.tar.gz" "${BACKUP_LOCATION}/"; then
            echo "[✓] Successfully backed up to HDD."
        else
            echo "[✗] Failed to back up to HDD."
        fi

        rm -rf "./$(hostname -s)_backup/"
        rm "./$(hostname -s)_backup.tar.gz"
    fi
else
    echo "[i] Skipping backup to HDD."
fi