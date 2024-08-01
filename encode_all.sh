#!/bin/bash
# from where the videos files will be pulled
video_recording="~/Videos/"
# the transcoded video files will be stored here
transcoded="~/Videos/transcoded/"

mkdir -p "$transcoded"
for i in "$video_recording"*.mp4; do
  base_name=$(basename "$i" .mp4)
  ffmpeg -i "$i" -vcodec mjpeg -q:v 0 -acodec pcm_s16be -q:a 0 -f mov "$transcoded${base_name}.mov"
done
echo "Transcoding done....."
