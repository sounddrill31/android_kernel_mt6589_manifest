#!/bin/bash

# Check if repo is already installed
if ! command -v repo >/dev/null 2>&1; then
  echo "Repo not found. Installing now..."
  
  # Create bin directory if it doesn't exist
  mkdir -p ~/bin
  
  # Download repo script
  curl https://storage.googleapis.com/git-repo-downloads/repo >> ~/bin/repo
  
  # Make repo script executable
  chmod a+x ~/bin/repo
  
  # Create symbolic link to /usr/bin/repo
  sudo ln -sf "/home/$(whoami)/bin/repo" "/usr/bin/repo"
  echo "Repo installation complete."
else
  echo "Repo already installed."
fi

# Initialize the repository
echo "Initializing repository"
repo init -u https://github.com/sounddrill31/android_kernel_mt6589_manifest.git -b a109-experiments

# Sync the repository
echo "Syncing repository"
repo sync -c -j$(nproc --all) --force-sync --no-clone-bundle --no-tags --prune

# Build the kernel
echo "Building kernel"
cd kernel
./build.sh
