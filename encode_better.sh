#!/bin/bash

RED='\e[38;2;255;0;0m'      # Hex: #FF0000
GREEN='\e[38;2;0;255;0m'    # Hex: #00FF00
YELLOW='\e[38;2;255;255;0m' # Hex: #FFFF00
MAGENTA='\e[38;5;206m'     # Hex: #0000FF
CYAN='\e[38;2;0;255;255m'   # Hex: #00FFFF
NC='\e[0m'

echo -e "${GREEN}Enter the paths of the videos to transcode(hint:nospaces-between-filename): ${NC}"
read -a video_recordings

echo -e "${MAGENTA}Where do you want to store the transcoded videos(Default:transcoded-folder): ${NC}"
read transcoded

if [[ -z $transcoded ]]; then
  transcoded="/hdd/Videos/obs_recording/transcoded/"
fi

mkdir -p "$transcoded"

declare -A names

# Prompt for new names for each video
for video in "${video_recordings[@]}"; do
  base_name=$(basename "$video" .mp4) || base_name=$(basename "$video" .webm)
  echo -e "${YELLOW}Enter a name for the encoded video for $base_name: ${NC}"
  read -r new_name
  if [[ -z $new_name ]]; then
    new_name="$base_name"
  fi
  names["$video"]="$new_name"
done

# Transcode videos
for video in "${video_recordings[@]}"; do
  new_name="${names[$video]}"
  ffmpeg -i "$video" -vcodec mjpeg -q:v 0 -acodec pcm_s16be -q:a 0 -f mov "$transcoded/${new_name}.mov"
done

echo -e "${RED}Transcoding complete..... ${NC}"
