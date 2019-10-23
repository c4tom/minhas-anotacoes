
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
	#xdg-open https://forums.linuxmint.com/viewtopic.php?t=277510
	#xdg-open https://forums.linuxmint.com/viewtopic.php?f=42&t=273202

	echo "[Re-enable hibernate by default]
Identity=unix-user:*
Action=org.freedesktop.upower.hibernate
ResultActive=yes

[Re-enable hibernate by default in logind]
Identity=unix-user:*
Action=org.freedesktop.login1.hibernate
ResultActive=yes" | sudo tee --append /etc/polkit-1/localauthority/50-local.d/com.ubuntu.enable-hibernate.pkla > /dev/null

	local UUID=`blkid | grep swap | sed 's/.* UUID="\(.*\)" TYPE.*/\1/'`;

	echo $UUID;

	sudo sed -i "s/quiet splash/resume=UUID=$UUID/" /etc/default/grub


}