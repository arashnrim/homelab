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

# Dump list of volumes to a text file
echo "$volumes" > ./volumes/volume_list.txt

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
    safe_name=${bind_mount#/}
    safe_name=${safe_name//\//_}
    temp_dir="./bind_mount_backup_$$"

    # Create temporary directory and copy bind mount contents
    if ! sudo mkdir -p "${temp_dir}" || ! sudo cp -a "${bind_mount}" "${temp_dir}/${base_name}"; then
        echo "[✗] Failed to copy bind mount ${bind_mount}."
        sudo rm -rf "${temp_dir}"
        continue
    fi

    # Create original_location.txt file
    if ! echo "${bind_mount}" | sudo tee "${temp_dir}/${base_name}/original_location.txt" > /dev/null; then
        echo "[✗] Failed to create original_location.txt for ${bind_mount}."
        sudo rm -rf "${temp_dir}"
        continue
    fi

    # Archive the bind mount with metadata
    if sudo tar czf "./bind_mounts/${safe_name}.tar.gz" -C "${temp_dir}" "${base_name}"; then
        echo "[✓] Successfully backed up bind mount ${bind_mount} to ./bind_mounts/${safe_name}.tar.gz."
    else
        echo "[✗] Failed to backup bind mount ${bind_mount}."
    fi

    # Cleanup temporary directory
    sudo rm -rf "${temp_dir}"
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
        safe_name=${file#/}
        safe_name=${safe_name//\//_}
        backup_dir="./manual/${safe_name}_backup"

        # Create directory structure
        if ! mkdir -p "${backup_dir}"; then
            echo "[✗] Failed to create backup directory for $file."
            continue
        fi

        # Copy the file into the backup directory
        if ! sudo cp -a "$file" "${backup_dir}/"; then
            echo "[✗] Failed to copy $file."
            rm -rf "${backup_dir}"
            continue
        fi

        # Create original_location.txt with the original path
        if ! echo "$file" > "${backup_dir}/original_location.txt"; then
            echo "[✗] Failed to create original_location.txt for $file."
            rm -rf "${backup_dir}"
            continue
        fi

        # Archive the directory
        if tar czf "./manual/${safe_name}.tar.gz" -C "./manual" "${safe_name}_backup"; then
            echo "[✓] Successfully backed up $file to ./manual/${safe_name}.tar.gz."
        else
            echo "[✗] Failed to backup $file."
        fi

        # Cleanup backup directory
        rm -rf "${backup_dir}"
    else
        echo "[i] $file does not exist. Skipping."
    fi
done

###
# Conclusion
###

mkdir -p "./$(hostname -s)_backup"
cp -r ./volumes ./bind_mounts ./manual "./$(hostname -s)_backup/"

current_date=$(date +"%Y-%m-%d_%H-%M-%S")
tar czf "./$(hostname -s)_backup_${current_date}.tar.gz" "./$(hostname -s)_backup/"
rm -rf "./$(hostname -s)_backup/"

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
        
        if scp "./$(hostname -s)_backup_${current_date}.tar.gz" "${BACKUP_LOCATION}/"; then
            echo "[✓] Successfully backed up to HDD."
        else
            echo "[✗] Failed to back up to HDD."
        fi

        rm "./$(hostname -s)_backup_${current_date}.tar.gz"
    fi
else
    echo "[i] Skipping backup to HDD."
fi