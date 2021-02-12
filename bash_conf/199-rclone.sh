[[ -f /usr/bin/rclone ]] || { return ; }


RCLONE_TARGET_DIR="$HOME/rclone";


ct_rclone_mountAllDrivers() {

    # rclone listremotes
    local DRIVERS=$(cat ~/.config/rclone/rclone.conf  | grep "\[" |sed "s/\[\(.*\)]/\1/")

    local tmpdir;

    ct_bashNaoQuebraLinha

    for i in $DRIVERS 
    do
        tmpdir="$RCLONE_TARGET_DIR/$i"
        echo "Montando $i em $tmpdir";
        mkdir -p "$tmpdir"

        echo rclone mount $i: $tmpdir --allow-other --vfs-cache-mode writes --use-mmap --fast-list --cache-dir /discok/tmp --daemon --log-file /tmp/rclone.log --allow-non-empty --debug-fuse --write-back-cache --buffer-size 256M --drive-chunk-size 32M --vfs-read-chunk-size 128M
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