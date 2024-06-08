#!/bin/bash

# Define the profile directory
PROFILE_DIR="$HOME/.yt-dlp-profiles"

# Default profile name
DEFAULT_PROFILE="default.conf"

# Check if a profile argument is provided
if [ -z "$1" ]; then
  PROFILE="$PROFILE_DIR/$DEFAULT_PROFILE"
else
  PROFILE="$PROFILE_DIR/$1.conf"
fi

# Check if the profile file exists
if [ ! -f "$PROFILE" ]; then
  echo "Profile $PROFILE not found!"
  exit 1
fi

# Check if a URL argument is provided
if [ -z "$2" ]; then
  echo "Usage: $0 [profile] <YouTube URL>"
  exit 1
fi

# YouTube URL
URL="$2"

# Run yt-dlp with the specified profile
yt-dlp --config-location "$PROFILE" "$URL"
