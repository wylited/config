#!/usr/bin/bash

# Function to list Firefox profiles
list_profiles() {
    local profiles_dir="$HOME/.mozilla/firefox"
    if [ -d "$profiles_dir" ]; then
        echo "Available Firefox profiles:"
        ls -1 "$profiles_dir" | grep "\..*" | while read -r profile; do
            echo "  - $profile"
        done
    else
        echo "No Firefox profiles found in $profiles_dir"
        exit 1
    fi
}

# Show available profiles
list_profiles

# Get profile directory from user
PROFILE_DIR=$(gum input --placeholder "Enter the profile directory name (e.g., xxxxxxxx.default-release)")

# Construct paths
SOURCE_DIR="$HOME/config/firefox"
DEST_DIR="$HOME/.mozilla/firefox/$PROFILE_DIR"

# Verify source directory exists
if [ ! -d "$SOURCE_DIR" ]; then
    echo "Source directory $SOURCE_DIR does not exist!"
    exit 1
fi

# Confirm before proceeding
gum confirm "Copy Firefox customization files to $DEST_DIR?" || exit 0

# Copy all files with progress spinner
gum spin --spinner dot --title "Copying files..." -- \
    cp -r "$SOURCE_DIR"/* "$DEST_DIR"/ 2>/dev/null || true

# Show result
if [ $? -eq 0 ]; then
    gum style \
        --foreground 212 --border-foreground 212 --border double \
        --align center --width 50 --margin "1 2" --padding "2 4" \
        'Files copied successfully! 🎉' \
        'Restart Firefox to apply changes'
else
    gum style \
        --foreground 196 --border-foreground 196 --border double \
        --align center --width 50 --margin "1 2" --padding "2 4" \
        'Error copying files! ❌' \
        'Please check permissions and try again'
fi
