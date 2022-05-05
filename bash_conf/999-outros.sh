

ct_whatsapp() {
    local NUMBER=$(echo "$1" | tr -dc '0-9')
    xdg-open "https://web.whatsapp.com/send?phone=+55$NUMBER&text&source&data"
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


ct_edit_minhaAnotacoes()
{
    FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
    SCRIPT_DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"
    SCRIPT_DIRECTORY="$(dirname "$SCRIPT_DIRECTORY")"
    echo_and_run code-markdown $SCRIPT_DIRECTORY;
}

ct_pull_minhasAnotacoes() {
    FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
    SCRIPT_DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"
    echo $(pwd)
    git pull  
}

ct_reload() {
    FULL_PATH_TO_SCRIPT="$(realpath "${BASH_SOURCE[-1]}")"
    SCRIPT_DIRECTORY="$(dirname "$FULL_PATH_TO_SCRIPT")"
    SCRIPT_DIRECTORY="$(dirname "$SCRIPT_DIRECTORY")"


    for i in $SCRIPT_DIRECTORY/bash_conf/*.sh
    do
    	echo_and_run source $i
    done

}