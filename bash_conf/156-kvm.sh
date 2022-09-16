[[ `isWin` != "1" ]] || { return ; }

# http://manpages.ubuntu.com/manpages/bionic/man1/guestmount.1.html

# https://stackoverflow.com/questions/22327728/mounting-vmdk-disk-image

if [[ -f /usr/bin/guestmount ]] 
then
	ct_guestMountInstall() {
		sudo apt-get install libguestfs-tools
		sudo useradd -G kvm $USER
		grep "^kvm" /etc/group
	}
fi

ct_guestMountVirtualDisk() {
	local ARQUIVO_VM="$1"
	local PONTO_DE_MONTAGEM="$2"

	guestmount -x -a "$ARQUIVO_VM" -i "$PONTO_DE_MONTAGEM"
}