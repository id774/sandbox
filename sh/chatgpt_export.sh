#!/bin/bash
# chatgpt_export.sh: Flatten exported ChatGPT conversation folders
#
# Description:
# Flatten exported ChatGPT conversation folders into one directory, stripping
# name prefixes. Markdown files from each *-conversations/<date> folder are
# copied into output/ without their leading numeric prefix.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     bash chatgpt_export.sh
#
# Requirements:
# - Bash and GNU sed
# - The exported *-conversations folders in the current directory
#

# Create the output directory
output_dir="output"
mkdir -p "$output_dir"

# Find each YYYY-MM-DD-conversations folder
for conversation_dir in *-conversations; do
  # Find each YYYY-MM-DD folder
  for date_dir in "$conversation_dir"/*; do
    # Find each Markdown file
    for file in "$date_dir"/*.md; do
      # Rename by dropping the leading numeric prefix
      new_filename=$(echo "$(basename "$file")" | sed -r 's/^[0-9]{1,2}-[0-9]{1,2}-[0-9]{1,2}-//')
      # Copy into the output directory
      cp "$file" "$output_dir/$new_filename"
    done
  done
done

