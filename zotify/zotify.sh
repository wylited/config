#!/usr/bin/env sh

# Set required environment variable for zotify
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=python

# Set default download path and format
MUSIC_DIR="$HOME/Music"
FORMAT="ogg"
QUALITY="very_high"

# Function to display spinner during downloads
show_spinner() {
    local pid=$1
    local delay=0.1
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
}

# Main menu
echo "🎵 Zotify Music Downloader"
echo "------------------------"

# still need to get zotify to work

# Choose download type
DOWNLOAD_TYPE=$(gum choose "Single URL" "Multiple URLs from file" "Liked Songs" "Followed Artists" "Search" "Playlist")

case $DOWNLOAD_TYPE in
"Single URL")
    URL=$(gum input --placeholder "Enter Spotify URL")
    gum spin --spinner dot --title "Downloading..." -- zotify --download-format $FORMAT --download-quality $QUALITY --output "{artist}/{album}/{track_number} - {song_name}.{ext}" "$URL"
    ;;

"Multiple URLs from file")
    FILE=$(gum input --placeholder "Enter path to file containing URLs")
    gum spin --spinner dot --title "Downloading..." -- zotify -d --download-format $FORMAT --download-quality $QUALITY --output "{artist}/{album}/{track_number} - {song_name}.{ext}" "$FILE"
    ;;

"Liked Songs")
    gum spin --spinner dot --title "Downloading liked songs..." -- zotify -l --download-format $FORMAT --download-quality $QUALITY --output "{artist}/{album}/{track_number} - {song_name}.{ext}"
    ;;

"Followed Artists")
    gum spin --spinner dot --title "Downloading followed artists..." -- zotify -f --download-format $FORMAT --download-quality $QUALITY --output "{artist}/{album}/{track_number} - {song_name}.{ext}"
    ;;

"Search")
    QUERY=$(gum input --placeholder "Enter search term")
    gum spin --spinner dot --title "Searching and downloading..." -- zotify -s --download-format $FORMAT --download-quality $QUALITY --output "{artist}/{album}/{track_number} - {song_name}.{ext}" "$QUERY"
    ;;

"Playlist")
    gum spin --spinner dot --title "Downloading playlist..." -- zotify -p --download-format $FORMAT --download-quality $QUALITY --output "{artist}/{album}/{track_number} - {song_name}.{ext}"
    ;;
esac

# Show completion message
gum style \
    --foreground 212 --border-foreground 212 --border double \
    --align center --width 50 --margin "1 2" --padding "2 4" \
    'Download Complete! 🎉' \
    'Check your Music directory'
