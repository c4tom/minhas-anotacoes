

[[ -f /usr/bin/qemu-x86_64 ]] || { return ; }


if [[ -f /usr/bin/qemu-nbd ]] 
then
    #https://askubuntu.com/questions/202571/how-to-mount-a-virtual-hard-disk
    ct_qemuMountVMDK() {
        sudo modprobe nbd max_part=16
        local DEV_NUMERO=$1 # /dev/nbd$DEV_NUMERO
        local ARQUIVO_VMDK="$2" # /caminho/do/arquivo.vmdk
        local PONTO_DE_MONTAGEM="$3" # /mnt/ponto-de-montagem

        qemu-nbd -c /dev/nbd$DEV_NUMERO $ARQUIVO_VMDK
        mount -o loop /dev/nbd$DEV_NUMEROp1 $PONTO_DE_MONTAGEM

        # do stuff
        #umount /mnt
        #qemu-nbd -d /dev/nbd0
        #rmmod nbd
    }
fi