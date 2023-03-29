#!/bin/bash

# This script will traverse through every folder and check if there are any uncommitted changes in git repositories and output them to a file 

# Set the output file path
output_file="git_uncommitted_changes.txt"

# Find all git repositories in the current directory and its subdirectories
find . -name ".git" -type d | while read git_dir; do
    # Get the folder name of the git repository
    folder_name=$(dirname "$git_dir")
    echo "Checking $folder_name"
    # Check if there are any uncommitted changes
    if git --git-dir="$git_dir" --work-tree="$folder_name" status --short | grep -q "^[??MADRCU]"; then
        # Output the folder name to the output file
        echo "$folder_name"  >> "$output_file"
    fi
done