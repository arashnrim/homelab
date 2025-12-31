#!/bin/bash

# Sources any environment variables from .env file if it exists
if [ -f .env ]; then
    source .env
fi

ROOT_DIR=$(pwd)
VOLUME_DIR="${ROOT_DIR}/volumes"
BIND_MOUNT_DIR="${ROOT_DIR}/bind_mounts"
MANUAL_DIR="${ROOT_DIR}/manual"

###
# Docker volumes
###

if [ -f "${VOLUME_DIR}/volume_list.txt" ]; then
    echo "[i] Restoring Docker volumes from ${VOLUME_DIR}..."

    while IFS= read -r volume || [ -n "$volume" ]; do
        [ -z "$volume" ] && continue
        archive_path="${VOLUME_DIR}/${volume}.tar.gz"

        if [ ! -f "$archive_path" ]; then
            echo "[!] Archive ${archive_path} is missing. Skipping ${volume}."
            continue
        fi

        container_id=$(sudo docker ps -a --filter "name=^${volume}$" -q)

        if [ -z "$container_id" ]; then
            echo "[i] Container ${volume} not found. Creating placeholder container..."
            if ! sudo docker create --name "${volume}" -v "${volume}":/volume alpine:latest >/dev/null; then
                echo "[✗] Failed to create container ${volume}. Skipping."
                continue
            fi
        else
            echo "[i] Found container ${volume}. Checking for existing data in /volume..."
            if sudo docker run --rm --volumes-from "${volume}" alpine sh -c 'if [ -n "$(ls -A /volume 2>/dev/null)" ]; then exit 1; fi'; then
                echo "[i] No existing data detected in /volume. Proceeding."
            else
                echo "[!] Container ${volume} has existing data. Skipping restore for this volume to avoid overwrite."
                continue
            fi
        fi

        echo "[i] Restoring volume ${volume} from ${archive_path}..."
        if sudo docker run --rm --volumes-from "${volume}" -v "${VOLUME_DIR}":/backup:ro alpine sh -c 'set -e; rm -rf /volume/* /volume/.[!.]* /volume/..?* 2>/dev/null; tar xzf /backup/'"${volume}"'.tar.gz -C /volume'; then
            echo "[✓] Restored volume ${volume}."
        else
            echo "[✗] Failed to restore volume ${volume}."
        fi
    done < "${VOLUME_DIR}/volume_list.txt"
else
    echo "[i] No volume_list.txt found in ${VOLUME_DIR}. Skipping volume restore."
fi

###
# Docker bind mounts
###

echo -e "\n[i] Restoring bind mounts from ${BIND_MOUNT_DIR}..."

if [ -d "$BIND_MOUNT_DIR" ]; then
    shopt -s nullglob
    for archive in "${BIND_MOUNT_DIR}"/*.tar.gz; do
        base_name=$(basename "$archive" .tar.gz)
        temp_dir=$(mktemp -d)

        if ! sudo tar xzf "$archive" -C "$temp_dir"; then
            echo "[✗] Failed to extract ${archive}."
            sudo rm -rf "$temp_dir"
            continue
        fi

        content_root=$(find "$temp_dir" -mindepth 1 -maxdepth 1 -type d | head -n1)
        if [ -z "$content_root" ]; then
            echo "[✗] Unable to locate extracted content for ${archive}."
            sudo rm -rf "$temp_dir"
            continue
        fi

        original_path_file="${content_root}/original_location.txt"
        if [ ! -f "$original_path_file" ]; then
            echo "[✗] original_location.txt missing for ${archive}."
            sudo rm -rf "$temp_dir"
            continue
        fi

        dest_path=$(sudo cat "$original_path_file")
        sudo rm -f "$original_path_file"

        echo "[i] Restoring bind mount ${base_name} to ${dest_path}..."
        if ! sudo mkdir -p "$dest_path"; then
            echo "[✗] Failed to create destination ${dest_path}."
            sudo rm -rf "$temp_dir"
            continue
        fi

        if ! sudo chmod -R a+rwx "$dest_path"; then
            echo "[✗] Failed to adjust permissions for ${dest_path}."
            sudo rm -rf "$temp_dir"
            continue
        fi

        if sudo rsync -a "${content_root}/" "$dest_path/"; then
            echo "[✓] Restored bind mount to ${dest_path}. (original_location.txt not copied)"
        else
            echo "[✗] Failed to restore bind mount ${base_name}."
        fi

        sudo rm -rf "$temp_dir"
    done
    shopt -u nullglob
else
    echo "[i] Bind mount directory ${BIND_MOUNT_DIR} not found. Skipping bind mount restore."
fi

###
# Manual back-up locations
###

echo -e "\n[i] Restoring manual backups from ${MANUAL_DIR}..."

if [ -d "$MANUAL_DIR" ]; then
    shopt -s nullglob
    for archive in "${MANUAL_DIR}"/*.tar.gz; do
        base_name=$(basename "$archive" .tar.gz)
        temp_dir=$(mktemp -d)

        if ! tar xzf "$archive" -C "$temp_dir"; then
            echo "[✗] Failed to extract ${archive}."
            rm -rf "$temp_dir"
            continue
        fi

        content_root=$(find "$temp_dir" -mindepth 1 -maxdepth 1 -type d | head -n1)
        if [ -z "$content_root" ]; then
            echo "[✗] Unable to locate extracted content for ${archive}."
            rm -rf "$temp_dir"
            continue
        fi

        original_path_file="${content_root}/original_location.txt"
        if [ ! -f "$original_path_file" ]; then
            echo "[✗] original_location.txt missing for ${archive}."
            rm -rf "$temp_dir"
            continue
        fi

        dest_path=$(cat "$original_path_file")
        rm -f "$original_path_file"

        echo "[i] Restoring manual backup ${base_name} to ${dest_path}..."
        if sudo mkdir -p "$(dirname "$dest_path")" && sudo rsync -a "${content_root}/" "$(dirname "$dest_path")/"; then
            echo "[✓] Restored manual backup to ${dest_path}. (original_location.txt not copied)"
        else
            echo "[✗] Failed to restore manual backup ${base_name}."
        fi

        rm -rf "$temp_dir"
    done
    shopt -u nullglob
else
    echo "[i] Manual backup directory ${MANUAL_DIR} not found. Skipping manual restore."
fi

echo -e "\n[i] Restore process completed."
