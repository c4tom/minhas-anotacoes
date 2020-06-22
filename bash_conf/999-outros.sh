

ct_whatsapp() {
    xdg-open https://web.whatsapp.com/send?phone=+55$1&text&source&data
}



# https://stackoverflow.com/questions/37040798/how-do-you-use-youtube-dl-to-download-live-streams-that-are-live
# sudo add-apt-repository ppa:nilarimogard/webupd8
# sudo apt update
# sudo apt install streamlink
ct_youtubeDownloadLiveVideo() {
    local URL="$1"
    local FILE_NAME="$2"
    echo "Escolha a qualidade de gravação: "
    streamlink ${URL}
    read QUALITY

    streamlink ${URL} ${QUALITY} -o ${FILE_NAME}
}



