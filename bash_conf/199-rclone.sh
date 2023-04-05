[[ `isWin` == "0" ]] || { return ; }

[[ -f /usr/bin/rclone ]] || { return ; }


ct_rclone_edit_config_file() {
    open ~/.config/rclone/rclone.conf
}

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

    local tmp_cache_dir=${1:-"/tmp/rclone"};
    local target_dir=${2:-"$RCLONE_TARGET_DIR"}
    local DRIVERS=$(rclone listremotes | sed "s/://")
    local cmd;
    local tmpdir;

    ct_bashNaoQuebraLinha

    RCLONE_CAJA_SCRIPTS=$HOME/.config/caja/scripts/rclone/

    if [[ -n `cat /etc/fuse.conf | grep "#user_allow"` ]]
        then
        echoRedBlack "Edit /etc/fuse.conf and enable 'user_allow_other'"
        return;
    fi

    mkdir -p $RCLONE_CAJA_SCRIPTS
    mkdir -p $tmp_cache_dir

    rm -f $RCLONE_CAJA_SCRIPTS/*

    for i in $DRIVERS 
    do
        tmpdir="$RCLONE_TARGET_DIR/$i"
        
        mkdir -p "$tmpdir"

        #cmd="rclone mount $i: $tmpdir -vv --allow-other --use-mmap --no-modtime --fast-list --stats=1h --checkers=100 --dir-cache-time=5m --poll-interval=1m0s --cache-db-purge --cache-dir /discok/tmp --daemon --log-file /tmp/rclone.log --allow-non-empty --debug-fuse --write-back-cache --buffer-size 256M --drive-chunk-size 32M --vfs-read-chunk-size 50K  --vfs-read-chunk-size-limit=128M --vfs-cache-poll-interval=1m --vfs-cache-max-age=1h0m0s  --vfs-cache-max-size=0 --vfs-cache-mode writes  --max-read-ahead=128k"

        cmd="rclone mount $i: $tmpdir"
        cmd="$cmd --allow-other"                    # Allow access to other users. Not supported on Windows.(edit /etc/fuse.conf and enable)
        cmd="$cmd --check-first"                    # especifica que o rclone deve verificar se os arquivos já existem no destino antes de transferi-los.

        cmd="$cmd --vfs-cache-mode writes"         # Cache mode off|minimal|writes|full (default off) - In this mode all reads and writes are buffered to and from disk. When data is read from the remote this is buffered to disk as well.
        cmd="$cmd --vfs-read-chunk-size 64M"    # é usada para definir o tamanho dos chunks que o rclone lê do sistema de arquivos remoto durante a leitura de um arquivo.
        cmd="$cmd --vfs-cache-max-age 1h0m0s"       # Max age of objects in the cache (default 1h0m0s)        
        cmd="$cmd --use-mmap"                   # Quando essa opção é habilitada, o rclone usa o mmap para acessar arquivos grandes, o que pode melhorar o desempenho em algumas situações. No entanto, o uso do mmap pode consumir muita memória,
        cmd="$cmd --no-modtime"
        cmd="$cmd --no-seek"
        cmd="$cmd --fast-list"
        cmd="$cmd --transfers 8 --checkers 16" # define o número de transferências simultâneas que o rclone usa para enviar e receber arquivos. Por padrão, o rclone usa 4 transferências simultâneas. Definir um número maior pode melhorar o desempenho em sistemas de arquivos remotos rápidos ou em conexões de internet rápidas.
        cmd="$cmd --cache-dir ${tmp_cache_dir}"
        cmd="$cmd --daemon"                         # Run mount as a daemon (background mode). Not supported on Windows.
        cmd="$cmd --dir-perms 0755"                 # Directory permissions (default 0777)
        cmd="$cmd --file-perms 0666"           
        cmd="$cmd --allow-non-empty"
        cmd="$cmd --debug-fuse"                     # Debug the FUSE internals - needs -v, Quando essa opção é habilitada, o rclone exibe mensagens de depuração detalhadas sobre as operações do sistema de arquivos FUSE, o que pode ser útil para diagnosticar problemas de montagem do sistema de arquivos remoto.
        cmd="$cmd --write-back-cache"               # Quando essa opção é habilitada, o rclone armazena em cache as gravações em um diretório local e as envia em segundo plano para o sistema de arquivos remoto. Isso pode melhorar o desempenho em sistemas de arquivos remotos lentos ou em conexões de internet lentas, pois permite que o rclone continue gravando arquivos localmente enquanto envia as gravações para o sistema de arquivos remoto em segundo plano.
        cmd="$cmd --buffer-size 256M"         #  é usada para definir o tamanho do buffer usado pelo rclone para ler e gravar arquivos durante a sincronização em sistemas de arquivos remotos.
        cmd="$cmd --drive-chunk-size 32M"
        cmd="$cmd --cache-chunk-path /dev/shm"
        cmd="$cmd --log-level INFO"
        cmd="$cmd --no-update-modtime"
        cmd="$cmd --contimeout 60s"
        cmd="$cmd --timeout 300s"
        cmd="$cmd --drive-upload-cutoff=64M" # Por padrão, o rclone divide arquivos grandes em chunks de 8 MB para fazer upload para o Google Drive, o que pode melhorar o desempenho. No entanto, para arquivos menores, fazer upload diretamente pode ser mais rápido e eficiente.
    
        cmd="$cmd --drive-acknowledge-abuse" # Quando essa opção é habilitada, o rclone exibirá uma mensagem de aviso no console informando que o uso indevido pode levar à suspensão da conta do Google e pedirá que você confirme que está ciente dos riscos e que está usando o rclone por sua conta e risco.



        cmd="$cmd --log-level DEBUG"
        cmd="$cmd --retries 3"
        cmd="$cmd --low-level-retries 10"
        cmd="$cmd --stats 1s"
        cmd="$cmd --poll-interval 15s"
        #cmd="$cmd --rc"

        cmd="$cmd --log-file=${tmp_cache_dir}/rclone.log"

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
    rclone rcd --rc-web-gui --rc-web-gui-force-update
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
