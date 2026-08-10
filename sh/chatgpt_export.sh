#!/bin/bash
# Flatten exported ChatGPT conversation folders into one directory, stripping name prefixes.

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

