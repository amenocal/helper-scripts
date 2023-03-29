#!/bin/bash

# This script will read a list of GitHub remotes from a file and clone them

# Set the feature flag.
DRY_RUN=true

# Read the input file of GitHub remotes.
while read remote; do
  # Extract the organization or owner name.
  if [[ $remote =~ ^https.* ]]; then
    owner=$(echo $remote | cut -d'/' -f4)
  else
    owner=$(echo $remote | cut -d':' -f2 | cut -d'/' -f1)
  fi

  # Create a folder with the name of the organization or owner.
  if [ "$DRY_RUN" = false ]; then
    echo "Creating folder for $owner"
    mkdir -p $owner
  else
    echo "Skipping folder creation for $owner"
  fi

  # Change the current working directory to the newly created folder.
  if [ "$DRY_RUN" = false ]; then
    echo "Changing directory to $owner"
    cd $owner
  else
    echo "Skipping directory change to $owner"
  fi

  # Clone the repository using the remote URL.
  if [ "$DRY_RUN" = false ]; then
    echo "Cloning repository $remote"
    git clone $remote
  else
    echo "Skipping repository cloning for $remote"
  fi

  # Change back to the parent directory.
  if [ "$DRY_RUN" = false ]; then
    echo "Changing directory back to parent"
    cd ..
  else
    echo "Skipping directory change back to parent"
  fi
done < git_remotes.txt