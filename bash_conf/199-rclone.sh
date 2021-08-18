[[ -f /usr/bin/rclone ]] || { return ; }


RCLONE_TARGET_DIR="$HOME/rclone";

# mount helper error: fusermount: option allow_other only allowed if 'user_allow_other' is set in /etc/fuse.conf
ct_rclone_enable_allow_others() {
    sudo sed -i "s/#user_allow_other/user_allow_other/" /etc/fuse.conf
}


ct_rclone_mountAliasAllDrivers() {

    # rclone listremotes
    # local DRIVERS=$(cat ~/.config/rclone/rclone.conf  | grep "\[" |sed "s/\[\(.*\)]/\1/")
    local DRIVERS=$(rclone listremotes | sed "s/://")

    local cmd;

    local tmpdir;

    ct_bashNaoQuebraLinha

    RCLONE_SCRIPTS=$HOME/.config/caja/scripts/rclone/

    mkdir -p $RCLONE_SCRIPTS

    rm -f $RCLONE_SCRIPTS/*

    for i in $DRIVERS 
    do
        tmpdir="$RCLONE_TARGET_DIR/$i"
        
        mkdir -p "$tmpdir"

        #cmd="rclone mount $i: $tmpdir -vv --allow-other --use-mmap --no-modtime --fast-list --stats=1h --checkers=100 --dir-cache-time=5m --poll-interval=1m0s --cache-db-purge --cache-dir /discok/tmp --daemon --log-file /tmp/rclone.log --allow-non-empty --debug-fuse --write-back-cache --buffer-size 256M --drive-chunk-size 32M --vfs-read-chunk-size 50K  --vfs-read-chunk-size-limit=128M --vfs-cache-poll-interval=1m --vfs-cache-max-age=1h0m0s  --vfs-cache-max-size=0 --vfs-cache-mode writes  --max-read-ahead=128k"

        cmd="rclone mount $i: $tmpdir"
        #cmd="$cmd --allow-other"                    #Allow access to other users. Not supported on Windows.
        cmd="$cmd --vfs-cache-mode writes"
        cmd="$cmd --use-mmap"
        cmd="$cmd --no-modtime"
        cmd="$cmd --fast-list --transfers 10 --checkers 10 --contimeout 60s --timeout 300s --retries 3 --low-level-retries 10 --stats 1s"
        cmd="$cmd --cache-dir /discok/tmp"
        cmd="$cmd --daemon"                         # Run mount as a daemon (background mode). Not supported on Windows.
        cmd="$cmd --allow-non-empty"
        cmd="$cmd --debug-fuse"                     # Debug the FUSE internals - needs -v
        cmd="$cmd --write-back-cache"               # Makes kernel buffer writes before sending them to rclone. Without this, writethrough caching is used. Not supported on Windows.
        cmd="$cmd --buffer-size 1G"
        cmd="$cmd --drive-chunk-size 32M"
        cmd="$cmd --vfs-read-chunk-size 128M"
        cmd="$cmd --log-level DEBUG"
        cmd="$cmd --log-file=/discok/tmp/rclone.log"


        ## criar arquivo scripts
        echo "$cmd" > $HOME/.config/caja/scripts/rclone/$i.sh

        echoGreenBlack "alias rclone_mount_$i";
        eval "alias rclone_mount_$i='$cmd'"
        if test "$1" = "1"
        then
            eval "$cmd &"
        fi
    done;
}


ct_rclone_umountAllDrivers() {
    cd $RCLONE_TARGET_DIR
    ct_bashNaoQuebraLinha
    for i in * 
    do
        fusermount -uz "$i"
    done
}

ct_rclone_webgui() {
    rclone rcd --rc-web-gui
}

ct_rclone_updateToken() {
    : ${1?' remote'}
    rclone config reconnect $1 
}