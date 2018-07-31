
ct_perifericosListar() {
	echo 'Relatorio dos perifericos do linux'
	inxi -FxZ
}



ct_hardDiskInfo() {
	sudo hdparm -I /dev/sda1
}

### PC Info
ct_hardInfo() {
	inxi -Fz
}

### System Info

diskInfoPartition() {
	lsblk -o "NAME,MAJ:MIN,RM,SIZE,RO,FSTYPE,MOUNTPOINT,UUID"
}

diskInfomation(){
	local DISK_DEV=$1 #/dev/sda
	hdparm -I $DISK_DEV
}
