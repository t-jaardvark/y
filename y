#!/bin/bash

# Define the profile directory
PROFILE_DIR="$HOME/git/repo/myscripts/y.sh/profiles"

# Default profile name
DEFAULT_PROFILE="default.conf"

# Initialize variables
PROFILE="$PROFILE_DIR/$DEFAULT_PROFILE"
PLAY_IMMEDIATELY=false

# Function to print usage
usage() {
  echo "Usage: $0 [-w] [profile] <YouTube URL>"
  echo "  -w         Play the file in mpv immediately after download"
  echo "  profile    Optional profile name (default is 'default')"
  echo "  URL        The YouTube URL to download"
  exit 1
}

# Parse arguments
while getopts ":w" opt; do
  case $opt in
    w)
      PLAY_IMMEDIATELY=true
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      usage
      ;;
  esac
done
shift $((OPTIND -1))

# Determine if the first argument is a profile or URL
if [ $# -eq 1 ]; then
  URL="$1"
elif [ $# -eq 2 ]; then
  PROFILE="$PROFILE_DIR/$1.conf"
  URL="$2"
else
  usage
fi

# Check if the profile file exists
if [ ! -f "$PROFILE" ]; then
  echo "Profile $PROFILE not found!"
  exit 1
fi

# Check if a URL argument is provided
if [ -z "$URL" ]; then
  usage
fi

# Run yt-dlp with the specified profile
yt-dlp --config-location "$PROFILE" "$URL"
DOWNLOAD_PATH=$(yt-dlp --config-location "$PROFILE" --get-filename "$URL")

# Play the file in mpv if requested
if [ "$PLAY_IMMEDIATELY" = true ]; then
  mpv "$DOWNLOAD_PATH"
fi
