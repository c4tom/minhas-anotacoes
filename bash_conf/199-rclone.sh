[[ -f /usr/bin/rclone ]] || { return ; }


RCLONE_TARGET_DIR="$HOME/rclone";

ct_rclone_mountAllDrivers() {
    local DRIVERS=$(cat ~/.config/rclone/rclone.conf  | grep "\[" |sed "s/\[\(.*\)]/\1/")
    

    local tmpdir;

    ct_bashNaoQuebraLinha

    for i in $DRIVERS 
    do
        tmpdir="$RCLONE_TARGET_DIR/$i"
        echo "Montando $i em $tmpdir";
        mkdir -p "$tmpdir"

        rclone mount $i: $tmpdir &
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