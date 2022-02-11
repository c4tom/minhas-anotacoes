
[[ -f "/usr/local/bin/youtube-dl" ]] || { 
  ct_youtubedl_install() {
    sudo curl -L https://yt-dl.org/downloads/latest/youtube-dl -o /usr/local/bin/youtube-dl
    sudo chmod +x /usr/local/bin/youtube-dl
  }
  
  return ; 
}

alias youtube-dl="/usr/local/bin/youtube-dl --restrict-filenames"

ct_youtubePlayListDownload() {
  youtube-dl -f mp4 --yes-playlist -i "$1" "$2" "$3" "$4" "$5"
}

ct_youtubePlayListDownloadWithSubtitles() {
  local YOUTUBE_PLAYLIST_URL="$1"
  youtube-dl -f mp4 --yes-playlist -x --sub-lang pt --write-sub --sub-format vtt --convert-subtitles srt --write-auto-sub  -i $YOUTUBE_PLAYLIST_URL
}


ct_youtubeSubtitlesAutoGenerateDownloadAllLanguage() {
    local YOUTUBE_URL="$1"
    youtube-dl --all-subs --skip-download --write-auto-sub $YOUTUBE_URL
}

ct_youtubeSubtitlesAutoGenerateDownload() {
    local YOUTUBE_URL="$1"
    youtube-dl -v -x --sub-lang pt --write-sub --sub-format vtt --convert-subtitles srt --write-auto-sub --skip-download $YOUTUBE_URL
}

# Listar URLs dos videos de uma playlist
ct_youtubePlayListListarVideos() {
  local YOUTUBE_URL="$1"
  youtube-dl -j --flat-playlist "$YOUTUBE_URL" | jq -r '.id' | sed 's_^_https://youtu.be/_' 
}

# Baixa somente subtitle de uma playlist
ct_youtubePlayListSubtitleDownloadOnly() {
  local LIST=`ct_youtubePlayListListarVideos "$1"`
  for i in $LIST
  do
    echo "--------------------------------------------"
    echo "Download: $i" 
    ct_youtubeSubtitlesAutoGenerateDownload "$i"
  done
}

ct_subtitleVTTtoSRT() {
  ffmpeg -i "$1" "$1.srt"
}

# https://askubuntu.com/questions/486297/how-to-select-video-quality-from-youtube-dl
ct_youtubeDownload480() {
  local YOUTUBE_URL="$1"
  youtube-dl -f 'bestvideo[height<=480]+bestaudio/best[height<=480]' "$YOUTUBE_URL"
}