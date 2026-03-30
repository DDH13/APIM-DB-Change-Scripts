#!/bin/bash
set -e  # Exit immediately if a command fails

# Configuration
BASE_PATH="/Users/dineth/Code/db-dumps"
FOLDER_NAME=$1  # Capture the first argument
APIM_DB_DUMP="apim-db.sql"
SHARED_DB_DUMP="shared-db.sql"

# Determine final destination
if [ -z "$FOLDER_NAME" ]; then
    TARGET_PATH="$BASE_PATH"
    echo "No folder name provided. Saving directly to: $TARGET_PATH"
else
    TARGET_PATH="${BASE_PATH}/${FOLDER_NAME}"
    echo "Folder name '$FOLDER_NAME' provided. Saving to: $TARGET_PATH"
fi

# Ensure the target folder exists
mkdir -p "$TARGET_PATH"

echo "Starting MySQL dumps..."

echo "Dumping APIM database from container: apim_db_container"
docker exec apim_db_container mysqldump -u root -prootpass apim_db > "${TARGET_PATH}/${APIM_DB_DUMP}"

echo "Dumping SHARED database from container: shared_db_container"
docker exec shared_db_container mysqldump -u root -prootpass shared_db > "${TARGET_PATH}/${SHARED_DB_DUMP}"

echo "--------------------------------------"
echo "Database dumps completed successfully!"
echo "Files saved to: ${TARGET_PATH}"