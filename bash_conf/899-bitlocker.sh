# Bitlocker para Linux (read/write)
# https://superuser.com/questions/376533/how-to-access-a-bitlocker-encrypted-drive-in-linux



[[ -f /usr/bin/dislocker ]] || { 
    [[ $HASAPT = false ]] && { return; }
    ct_bitlockerInstall() {
        sudo apt-get install dislocker
    }    
    
    return ; 
}


ct_bitlockerMount() {
    local DEV_SDAx="$1"
    local CHAVE="$2"
    local PONTO_DE_MONTAGEM="$3"


    [[ ! -f "$DEV_SDAx" ]] || { echo "Nao existe $DEV_SDAx"; return ; } 
    
    local BL_FOLDER=`echo $DEV_SDAx | sed "s@/dev/@@"`

    [[ -d "/mnt/$BL_FOLDER" ]] || { 
        sudo mkdir -p "/mnt/$BL_FOLDER"
    }
    sudo dislocker -v -V "$DEV_SDAx" -p$CHAVE -- /mnt/$BL_FOLDER

    sudo mount -o loop /mnt/$BL_FOLDER/dislocker-file "$PONTO_DE_MONTAGEM"

    export DISLOCKER_UMOUNT_$BL_FOLDER="sudo umount $PONTO_DE_MONTAGEM && sudo umount $DEV_SDAx"
}