
ct_hw_listarTodosPerifericos() {
	echo 'Relatorio dos perifericos do linux'
	inxi -FxZ
}

ct_hw_disk_infoHDPARM() {
	sudo hdparm -I /dev/sda1
}

### PC Info
ct_hw_info() {
	inxi -Fz
}

# Com mais detalhes, pode instalar um visual apt-get install hardinfo sysinfo
ct_hw_info_LSHW()
{
	sudo lshw
}

### System Info

ct_hw_disk_infoPartition() {
	lsblk -o "NAME,MAJ:MIN,RM,SIZE,RO,FSTYPE,MOUNTPOINT,UUID"
}

ct_hw_disk_infomation(){
	local DISK_DEV=$1 #/dev/sda
	hdparm -I $DISK_DEV
}

ct_hw_bios_info() {
	sudo dmidecode
}

ct_hw_wifi_modulosListar() {
	lspci | grep Network
	dmesg | grep iwlwifi
	iwconfig
	modinfo iwlwifi
}


### Batery Info

ct_hw_battery_info() {
	upower -i /org/freedesktop/UPower/devices/battery_BAT0
}


### Hibernate

ct_hw_hibernate_habilitar()
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




### Audio
ct_hw_audio_resetConfiguracoes() {
	rm -r ~/.config/pulse/
	pulseaudio -k
}

#https://diolinux.com.br/2020/06/cancelamento-de-eco-e-ruido-no-linux.html
ct_hw_audio_cancelamentoRuidoMicrofone() {
	echo "
load-module module-echo-cancel aec_args=\"analog_gain_control=0 digital_gain_control=0\" source_name=noiseless
set-default-source noiseless
" | sudo tee --append /etc/pulse/default.pa

	pulseaudio -k
}


