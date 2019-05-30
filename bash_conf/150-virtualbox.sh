#!/bin/sh

# TPM e Bitlocker http://www.shulerent.com/2012/09/04/locking-down-a-virtual-machine-with-bitlocker/

[[ -f /usr/bin/VBoxManage ]] || { return ; }

ct_vboxCreateRawDisk() {
    local nome_do_arquivo="$1"
    local device="$2"
    local partition="$3"
    local outros=""

    if test ! -z $partition
        then
            outros=" -partitions $partition"
        fi

    VBoxManage internalcommands createrawvmdk -filename "$nome_do_arquivo" -rawdisk $device $outros
}

ct_vboxListPartition() {
    local device="$1"
    VBoxManage internalcommands listpartitions -rawdisk "$device"
}

# https://forums.virtualbox.org/viewtopic.php?f=2&t=54591
# https://forums.virtualbox.org/viewtopic.php?f=2&t=43678
ct_vboxSetExtraData() {
    # OBs: Nao usar, pois ocorre problemas
    local VM_NAME="$1"
    local BOARD_PRODUCT="$2"
    local BOARD_VENDOR="$3"
    local SYSTEM_PRODUCT="$4"
    local SYSTEM_VENDOR="$5"
    local SYSTEM_UUID="$6"
    local SYSTEM_SERIAL="$7"

    vboxmanage setextradata $VM_NAME "VBoxInternal/Devices/pcbios/0/Config/DmiBoardProduct" "$BOARD_PRODUCT"
    vboxmanage setextradata $VM_NAME "VBoxInternal/Devices/pcbios/0/Config/DmiBoardVendor" "$BOARD_VENDOR"
    vboxmanage setextradata $VM_NAME "VBoxInternal/Devices/pcbios/0/Config/DmiSystemProduct" "$SYSTEM_PRODUCT"
    vboxmanage setextradata $VM_NAME "VBoxInternal/Devices/pcbios/0/Config/DmiSystemVendor" "$SYSTEM_VENDOR"

    vboxmanage setextradata $VM_NAME "VBoxInternal/Devices/pcbios/0/Config/DmiSystemUuid" "$SYSTEM_UUID"
    vboxmanage setextradata $VM_NAME  "VBoxInternal/Devices/pcbios/0/Config/DmiSystemSerial" "$SYSTEM_SERIAL"
}