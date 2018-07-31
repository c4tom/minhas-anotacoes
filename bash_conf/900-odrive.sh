# https://docs.odrive.com/docs/odrive-sync-agent


ct_odriveInstallAgent() {
    od="$HOME/.odrive-agent/bin" 
    curl -L "http://dl.odrive.com/odrive-py" --create-dirs -o "$od/odrive.py" 
    curl -L "http://dl.odrive.com/odriveagent-lnx-64" | tar -xvzf- -C "$od/" 
    curl -L "http://dl.odrive.com/odrivecli-lnx-64" | tar -xvzf- -C "$od/"
}


[[ -f $HOME/.odrive-agent/bin/odriveagent ]] || { return ; }

ct_odriveAgentStart() {
    nohup "$HOME/.odrive-agent/bin/odriveagent" > /dev/null 2>&1 &
}

ct_odriveAgentStop() {
    ps aux | grep odrive
}

ct_odriveAuth() {
    "$HOME/.odrive-agent/bin/odrive" authenticate "$1"
}

ct_odriveMount() {
    mkdir "$HOME/odrive-agent-mount"
    "$HOME/.odrive-agent/bin/odrive" mount "$HOME/odrive-agent-mount" /
}

ct_odriveInstallClient() {
    "$HOME=/"
    https://dl.odrive.com/odrivecli-lnx-64
}

ct_odriveSyncCloudDropbox() {
    "$HOME/.odrive-agent/bin/odrive" sync "$HOME/odrive-agent-mount/Dropbox.cloudf"
}
ct_odriveSyncCloudOnedrive() {
    "$HOME/.odrive-agent/bin/odrive" sync "$HOME/odrive-agent-mount/OneDrive.cloudf"
}

ct_odriveSyncToLocal() {
    local FILE_CLOUD="$1"
    #"$HOME/.odrive-agent/bin/odrive" sync "$HOME/odrive-agent-mount/Dropbox.cloudf"
    "$HOME/.odrive-agent/bin/odrive" sync "$FILE_CLOUD"
}

ct_odriveSyncToServer() {
    echo
}