#!/bin/bash

# This script will traverse through every folder and get my git remotes and output them to a file 

# Set the output file paths
output_file="git_remotes.txt"
no_remote_file="folders_with_no_remotes.txt"

# Find all git repositories in the current directory and its subdirectories
find . -name ".git" -type d | while read git_dir; do
    # Get the remote URL of the git repository
    remote_url=$(git --git-dir="$git_dir" remote get-url origin)
    # Get the folder name of the git repository
    folder_name=$(dirname "$git_dir")
    # Check if the remote URL is empty
    if [ -z "$remote_url" ]; then
        # Output the folder name to the no remote file
        echo "$folder_name" >> "$no_remote_file"
    else
        # Output the remote URL and folder name to the output file
        echo "Folder: $folder_name"
        echo "$remote_url" >> "$output_file"
    fi
done