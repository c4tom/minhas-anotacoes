
ct_hwPerifericosListar() {
	echo 'Relatorio dos perifericos do linux'
	inxi -FxZ
}

ct_hwDiskInfo() {
	sudo hdparm -I /dev/sda1
}

### PC Info
ct_hwInfo() {
	inxi -Fz
}

# Com mais detalhes, pode instalar um visual apt-get install hardinfo sysinfo
ct_hwInfoLSHW()
{
	sudo lshw
}

### System Info

ct_hwDiskInfoPartition() {
	lsblk -o "NAME,MAJ:MIN,RM,SIZE,RO,FSTYPE,MOUNTPOINT,UUID"
}

ct_hwDiskInfomation(){
	local DISK_DEV=$1 #/dev/sda
	hdparm -I $DISK_DEV
}

ct_hwBiosInfo() {
	sudo dmidecode
}

ct_hwWifiModulosListar() {
	lspci | grep Network
	dmesg | grep iwlwifi
	iwconfig
	modinfo iwlwifi
}


### Batery Info

ct_hwBatteryInfo() {
	upower -i /org/freedesktop/UPower/devices/battery_BAT0
}


### Hibernate

ct_hwHabilitarHibernate()
{
	xdg-open https://forums.linuxmint.com/viewtopic.php?t=277510
}