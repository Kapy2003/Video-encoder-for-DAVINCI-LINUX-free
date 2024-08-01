video_recording="/hdd/Videos/obs_recording/needs_transcode/"
transcoded="/hdd/Videos/obs_recording/transcoded/"

mkdir -p "$transcoded"
for i in "$video_recording"*.mp4; do
  base_name=$(basename "$i" .mp4)
  #echo "Enter a name for the encoded video for $base_name:"
  #read -r new_name
  ffmpeg -i "$i" -vcodec mjpeg -q:v 0 -acodec pcm_s16be -q:a 0 -f mov "$transcoded${base_name}.mov"
done
