
if [ "video/webm" = $(mimetype -b "$i")]
then 
ffmpeg "$i" -strict experimental "$i.mp4"
else 
    ffmpeg -i "$1" "$1.mp4"
done
