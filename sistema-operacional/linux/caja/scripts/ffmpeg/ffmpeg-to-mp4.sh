
filename=$(kdialog --inputbox "Digite o nome do arquivo SEM .mp4" "$1")

if [ "video/webm" = $(mimetype -b "$1")]
then 
	CMD=$(echo "ffmpeg -i \"$1\" -strict experimental \"$filename.mp4\"")
else 
	CMD=$(echo "ffmpeg -i \"$1\" -c copy \"$filename.mp4\"")
fi

eval $CMD

