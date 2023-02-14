[[ `isWin` == "0" ]] || { return ; }

[[ -f /usr/bin/rclone ]] || { return ; }


ct_rclone_update_version() {
    local rclone_versao_instalada=$(rclone version | grep "^rclone" | awk '{print $2}')
    local rclone_disponivel=$(curl -s 'https://rclone.org/downloads/#downloads-for-scripting' | pandoc -f html -t plain | grep Release | head -n 1 | awk '{print $2}')

    echoGreenBlack "Instalada: $rclone_versao_instalada | Disponivel: $rclone_disponivel"

    if [[ $rclone_disponivel != $rclone_versao_instalada ]]
    then
        cd /tmp
        curl -o rclone.deb https://downloads.rclone.org/rclone-current-linux-amd64.deb
        sudo dpkg -i rclone.deb
    fi
}


RCLONE_TARGET_DIR="$HOME/rclone";

# mount helper error: fusermount: option allow_other only allowed if 'user_allow_other' is set in /etc/fuse.conf
ct_rclone_enable_allow_others() {
    sudo sed -i "s/#user_allow_other/user_allow_other/" /etc/fuse.conf
}


ct_rclone_mountAliasAllDrivers() {

    local tmp_log=${1:-"/discok/tmp"};
    local target_dir=${2:-"$RCLONE_TARGET_DIR"}
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
        cmd="$cmd --check-first"                    # especifica que o rclone deve verificar se os arquivos já existem no destino antes de transferi-los.

        cmd="$cmd --vfs-cache-mode writes"         # Cache mode off|minimal|writes|full (default off) - In this mode all reads and writes are buffered to and from disk. When data is read from the remote this is buffered to disk as well.
        cmd="$cmd --vfs-read-chunk-size 128M"
        cmd="$cmd --vfs-cache-max-age 1h0m0s"       # Max age of objects in the cache (default 1h0m0s)        
        cmd="$cmd --use-mmap"
        cmd="$cmd --no-modtime"
        cmd="$cmd --no-seek"
        cmd="$cmd --transfers 8 --checkers 16   "
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
        cmd="$cmd --no-update-modtime"
        cmd="$cmd --contimeout 60s"
        cmd="$cmd --timeout 300s"
        cmd="$cmd --drive-upload-cutoff=64M"
    
        #cmd="$cmd --drive-acknowledge-abuse"
        cmd="$cmd --log-level DEBUG"
        cmd="$cmd --retries 3"
        cmd="$cmd --low-level-retries 10"
        cmd="$cmd --stats 1s"
        cmd="$cmd --poll-interval 15s"
        #cmd="$cmd --rc"

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

ct_rclone_oraclecloud() { 
    # https://docs.oracle.com/pt-br/solutions/move-data-to-cloud-storage-using-rclone/configure-rclone-object-storage.html#GUID-9AEC25DB-091C-4E72-B0B9-1FFAC5AC0494

    # http://blog.osdev.org/oci/2020/10/15/oci-objectstorage-with-rclone.html
    
    : ${1?' your_access_key'}
    : ${2?' your_secret_key'}
    : ${3?' your_region_identifier'}
    : ${4?' your_namespace'}

    #export RCLONE_CONFIG_OCI_TYPE=s3
    #export RCLONE_CONFIG_OCI_ACCESS_KEY_ID=$1
    #export RCLONE_CONFIG_OCI_SECRET_ACCESS_KEY=$2
    #export RCLONE_CONFIG_OCI_REGION=$3
    #export RCLONE_CONFIG_OCI_ENDPOINT=https://$4.compat.objectstorage.$RCLONE_CONFIG_OCI_REGION.oraclecloud.com

    #env | grep RCLONE
    echo "Adicione isso no rclone.conf"
    echo "
[oci]
type = s3
env_auth = false
access_key_id = $1
secret_access_key = $2
region = $3
endpoint = https://$4.compat.objectstorage.$3.oraclecloud.com
"
}
