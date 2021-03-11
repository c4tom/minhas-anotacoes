
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