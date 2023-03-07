[[ `isWin` != "1" ]] || { return ; }

# sudo apt install qemu-utils
if [[ -f /usr/bin/qemu-nbd ]] 
then
    #https://askubuntu.com/questions/202571/how-to-mount-a-virtual-hard-disk
    ct_qemuMountVMDK() {
        sudo modprobe nbd max_part=16
        sudo partprobe /dev/nbd$DEV_NUMERO

        local DEV_NUMERO=$1 # /dev/nbd$DEV_NUMERO
        local ARQUIVO_VMDK="$2" # /caminho/do/arquivo.vmdk
        local PONTO_DE_MONTAGEM="$3" # /mnt/ponto-de-montagem

        sudo qemu-nbd -c /dev/nbd$DEV_NUMERO $ARQUIVO_VMDK
        sudo mount -o loop /dev/nbd$DEV_NUMEROp1 $PONTO_DE_MONTAGEM

        # do stuff
        #umount /mnt
        #qemu-nbd -d /dev/nbd0
        #rmmod nbd
    }
fi


ct_qemu_create_vmdk() {
    : ${1? 'nome do arquivo'}
    : ${2? 'tamanho do arquivo. Ex.: 20G'}

    qemu-img create -f vmdk -o subformat=twoGbMaxExtentSparse -o compat6=on "$1" $2
}

[[ -f /usr/bin/qemu-x86_64 ]] || { 
    
    return ; 
}