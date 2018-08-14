# https://docs.odrive.com/docs/odrive-sync-agent
# https://docs.odrive.com/docs/odrive-sync-agent#section--using-odrive-sync-agent-

ct_odriveInstallAgent_e_Client() {
    od="$HOME/.odrive-agent/bin"
    curl -L "http://dl.odrive.com/odrive-py" --create-dirs -o "$od/odrive.py"
    curl -L "http://dl.odrive.com/odriveagent-lnx-64" | tar -xvzf- -C "$od/"
    curl -L "http://dl.odrive.com/odrivecli-lnx-64" | tar -xvzf- -C "$od/"
}



[[ -f $HOME/.odrive-agent/bin/odriveagent ]] || { return ; }
alias odriveAgent="$HOME/.odrive-agent/bin/odriveagent"
[[ ! -f $HOME/.odrive-agent/bin/odrive ]] || {
    alias odrive=$HOME/.odrive-agent/bin/odrive
}


ct_odriveAgentStart() {
    nohup odriveAgent > /dev/null 2>&1 &
}

ct_odriveAgentStop() {
    ps aux | grep odrive
}

# obter o auth_key em https://www.odrive.com/account/authcodes
ct_odriveAuth() {
    local AUTH_KEY="$1"
    odrive authenticate "$AUTH_KEY"
}

ct_odriveMount() {
    mkdir "$HOME/odrive-agent-mount"
    odrive mount "$HOME/odrive-agent-mount" /
}

ct_odriveSyncCloudDropbox() {
    odrive sync "$HOME/odrive-agent-mount/Dropbox.cloudf"
}
ct_odriveSyncCloudOnedrive() {
    odrive sync "$HOME/odrive-agent-mount/OneDrive.cloudf"
}

ct_odriveSyncToLocal() {
    local FILE_CLOUD="$1"
    #"$HOME/.odrive-agent/bin/odrive" sync "$HOME/odrive-agent-mount/Dropbox.cloudf"
    odrive sync "$FILE_CLOUD"
}

ct_odriveSyncToServer() {
    echo
}

ct_odriveUnsync() {
    set -e
    ODRIVE_PY=odrive
    RECURSIVE="-maxdepth 1"
    if [[ $1 == "-h" ]] || [[ $1 == "--help" ]] ; then
        echo "Usage: unsync_by [-e <extension>] [-s <size in kilobytes>] [-d <days>] [directory path] [-r]"
        echo "Help: Unsync files by extension, size, or days old for a given directory"
        echo "Options:"
        echo "-e --extension  Unsyncs files with the specified extension"
        echo "-s --size       Unsyncs files larger than the specified size in kilobytes"
        echo "-d --days       Unsyncs files older than the specified day"
        echo "-r --recursive  Unsyncs files recursively through the specified path"
        echo "-h --help       Help"
        elif [[ $# -gt 2 ]] ; then
        key="$1"
        case $key in
            -e|--extension)
                EXTENSION="$2"
            ;;
            -s|--size)
                SIZE="$2"
            ;;
            -d|--days)
                DAYS="$2"
            ;;
            *)
                echo "Invalid arguments. Please consult help for usage details (-h, --help)."
                exit 1
            ;;
        esac
    else
        echo "Invalid arguments. Please consult help for usage details (-h, --help)."
        exit 1
    fi
    DIRPATH="$3"
    if [[ $4 == "-r" ]] || [[ $4 == "--recursive" ]] ; then
        RECURSIVE=""
    fi
    if [[ $EXTENSION ]] ; then
        echo unsyncing all files of "$EXTENSION" type in "$DIRPATH"
        find "$DIRPATH" $RECURSIVE -name "*$EXTENSION" -type f -exec python "$ODRIVE_PY" unsync {} \;
        elif [[ $SIZE ]] ; then
        echo unsyncing all files larger than "$SIZE" kilobytes in "$DIRPATH"
        find "$DIRPATH" $RECURSIVE -size "+${SIZE}k" -type f -exec python "$ODRIVE_PY" unsync {} \;
        elif [[ $DAYS ]] ; then
        echo unsyncing all files older than "$DAYS" days in "$DIRPATH"
        find "$DIRPATH" $RECURSIVE -mtime "+${DAYS}" -type f -exec python "$ODRIVE_PY" unsync {} \;
    fi
}