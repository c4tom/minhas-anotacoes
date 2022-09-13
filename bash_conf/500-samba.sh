[[ `isWin` != "1" ]] || { return ; }

ct_sambaViewNetworkFolder()
{
	#caja \\km3rede\aplcopel\TIMESHEET\NewTimesheet
	#local PASTA=`echo '$1' | sed "s#\\\#/#g"`
	local PASTA=$(echo -E "$1" | sed "s#\\\#/#g");
	echo $PASTA;
	caja smb:$PASTA;
}

ct_samba_mount() {
	: ${1?:' <windows share  //host/folder>'}
	: ${2?:' </mount/dir>'}
	: ${3?:' <user>'}

	echo_and_run sudo mount -t cifs -o user=$3 "$1" "$2"

}

# https://techviewleo.com/install-and-configure-samba-file-sharing-on-linux-mint/
ct_install_samba() {
	echo_and_run sudo apt-get -y install samba
	echo_and_run sudo mkdir -p /home/share
	echo_and_run sudo chmod 777 /home/share

	echo_and_run sudo chgrp sambashare /home/share

	echoRedBlack "Adicionando samba ao firewall"
	echo_and_run sudo ufw allow samba

	ct_samba_restart
}

ct_samba_restart() {
	echo_and_run sudo systemctl restart smbd nmbd
}

ct_samba_adduser() {
	: ${1?:' <user>'}
	local USER=$1
	local GROUP=${1:-"sambashare"};

	sudo useradd -M -d /home/share/$USER -s /usr/sbin/nologin -G $GROUP $USER
	sudo mkdir /home/share/$USER
	sudo chown $USER:$GROUP /home/share/$USER
	sudo chmod 2770 /home/share/$USER
	echo "Setar uma senha para $USER"
	sudo smbpasswd -a $USER
	sudo smbpasswd -e $USER


	echo "

[$USER]
path = /home/share/$USER
readonly = no
Browseable = no
force create mode = 0660
force directory mode = 2770
valid user = @$USER @$GROUP

" | sudo tee -a /etc/samba/smb.conf

}

