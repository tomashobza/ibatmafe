#!/bin/bash

# Define the name of the combined file
combined_file="combined.swift"

# Find all .swift files in the current directory and its subdirectories
find . -type f -name "*.swift" -print0 |
  # Sort the files for consistent ordering
  sort -z |
  # Loop through each file
  while IFS= read -r -d '' file; do
    # Append the contents of each file to the combined file
    cat "$file" >> "$combined_file"
    echo "" >> "$combined_file" # Add a newline after each file's content
  done

echo
