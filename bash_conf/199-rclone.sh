[[ -f /usr/bin/rclone ]] || { return ; }


RCLONE_TARGET_DIR="$HOME/rclone";

# mount helper error: fusermount: option allow_other only allowed if 'user_allow_other' is set in /etc/fuse.conf
ct_rclone_enable_allow_others() {
    sudo sed -i "s/#user_allow_other/user_allow_other/" /etc/fuse.conf
}


ct_rclone_mountAliasAllDrivers() {

    local tmp_log=${1:-"/discok/tmp"};
    # rclone listremotes
    # local DRIVERS=$(cat ~/.config/rclone/rclone.conf  | grep "\[" |sed "s/\[\(.*\)]/\1/")
    local DRIVERS=$(rclone listremotes | sed "s/://")

    local cmd;

    local tmpdir;

    ct_bashNaoQuebraLinha

    RCLONE_SCRIPTS=$HOME/.config/caja/scripts/rclone/

    if [[ -n `cat /etc/fuse.conf | grep "#user_allow"` ]]
        then
        echoRedBlack "Edit /etc/fuse.conf and enable 'user_allow_other'"
        return;
    fi

    mkdir -p $RCLONE_SCRIPTS

    rm -f $RCLONE_SCRIPTS/*

    for i in $DRIVERS 
    do
        tmpdir="$RCLONE_TARGET_DIR/$i"
        
        mkdir -p "$tmpdir"

        #cmd="rclone mount $i: $tmpdir -vv --allow-other --use-mmap --no-modtime --fast-list --stats=1h --checkers=100 --dir-cache-time=5m --poll-interval=1m0s --cache-db-purge --cache-dir /discok/tmp --daemon --log-file /tmp/rclone.log --allow-non-empty --debug-fuse --write-back-cache --buffer-size 256M --drive-chunk-size 32M --vfs-read-chunk-size 50K  --vfs-read-chunk-size-limit=128M --vfs-cache-poll-interval=1m --vfs-cache-max-age=1h0m0s  --vfs-cache-max-size=0 --vfs-cache-mode writes  --max-read-ahead=128k"

        cmd="rclone mount $i: $tmpdir"
        cmd="$cmd --allow-other"                    # Allow access to other users. Not supported on Windows.(edit /etc/fuse.conf and enable)
        cmd="$cmd --vfs-cache-mode write"         # Cache mode off|minimal|writes|full (default off) - In this mode all reads and writes are buffered to and from disk. When data is read from the remote this is buffered to disk as well.
        cmd="$cmd --vfs-read-chunk-size 128M"
        cmd="$cmd --vfs-cache-max-age 1h0m0s"       # Max age of objects in the cache (default 1h0m0s)        
        cmd="$cmd --use-mmap"
        cmd="$cmd --no-modtime"
        cmd="$cmd --no-seek"
        cmd="$cmd --transfers 10 --checkers 10 --contimeout 60s --timeout 300s --retries 3 --low-level-retries 10 --stats 1s"
        cmd="$cmd --cache-dir ${tmp_log}"
        cmd="$cmd --daemon"                         # Run mount as a daemon (background mode). Not supported on Windows.
        cmd="$cmd --dir-perms 0755"                 # Directory permissions (default 0777)
        cmd="$cmd --file-perms 0666"           
        cmd="$cmd --allow-non-empty"
        cmd="$cmd --debug-fuse"                     # Debug the FUSE internals - needs -v
        cmd="$cmd --write-back-cache"               # Makes kernel buffer writes before sending them to rclone. Without this, writethrough caching is used. Not supported on Windows.
        cmd="$cmd --buffer-size 1G"
        cmd="$cmd --drive-chunk-size 32M"
        cmd="$cmd --cache-chunk-path /dev/shm"
        cmd="$cmd --log-level INFO"
        cmd="$cmd --log-file=${tmp_log}/rclone.log"


        SCRIPT_FILE=$HOME/.config/caja/scripts/rclone/$i.sh
        ## criar arquivo scripts
        echo "$cmd" > $SCRIPT_FILE
        chmod +x $SCRIPT_FILE

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

ct_rclone_open_config() {
    pluma ~/.config/rclone/rclone.conf
}