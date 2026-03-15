#!/bin/bash

# Create a clean folder for the renamed files
OUTPUT_DIR="assets_upload"
mkdir -p "$OUTPUT_DIR"

echo "Starting renaming and copying process..."

# Array of folder:prefix pairs
FOLDERS=("mip_mcmc_videos:mip_mcmc_" "mip_mcmc_qnn_videos:mip_mcmc_qnn_" "mip_3dgs_videos:mip_3dgs_" "mip_3dgs_qnn_videos:mip_3dgs_qnn_")

for item in "${FOLDERS[@]}"; do
    # Split the folder name and the prefix by the colon
    folder="${item%%:*}"
    prefix="${item##*:}"

    if [ -d "$folder" ]; then
        echo "Processing folder: $folder"
        # Find all mp4 files in the folder
        for file in "$folder"/*.mp4; do
            # Handle cases where no .mp4 files are found
            if [ -f "$file" ]; then
                filename=$(basename "$file")
                new_filename="${prefix}${filename}"

                # Copy to output directory with the new name
                # cp "$file" "$OUTPUT_DIR/$new_filename"
                echo "$new_filename"
            fi
        done
    else
        echo "Warning: Folder $folder not found. Skipping."
    fi
done

echo -e "\nDone! Drag and drop all files from the '$OUTPUT_DIR' directory into your GitHub Release."
