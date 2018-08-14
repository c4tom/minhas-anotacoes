
[[ -f "/usr/bin/youtube-dl" ]] || { return ; }


ct_youtubePlayListDownload() {
  youtube-dl -f mp4 --yes-playlist -i "$1" "$2" "$3" "$4" "$5"
}

ct_youtubeSubtitlesAutoGenerateDownloadAll() {
    local YOUTUBE_URL="$1"
    youtube-dl --all-subs --skip-download --write-auto-sub $YOUTUBE_URL
}