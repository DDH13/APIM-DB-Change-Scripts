#!/bin/bash
set -e  # Exit immediately if a command fails

# Define paths and filenames
folder_path="/Users/dineth/Code/db-dumps"
apim_db_dump="apim-db.sql"
shared_db_dump="shared-db.sql"

# Ensure the target folder exists
mkdir -p "$folder_path"
mkdir -p "$folder_path"

echo "Starting MySQL dumps..."
echo "Dumping APIM database from container: apim_db_container"
docker exec apim_db_container mysqldump -u root -prootpass apim_db > "${folder_path}/${apim_db_dump}"

echo "Dumping SHARED database from container: shared_db_container"
docker exec shared_db_container mysqldump -u root -prootpass shared_db > "${folder_path}/${shared_db_dump}"

echo "Database dumps completed successfully!"
echo "Files saved to: ${folder_path}"