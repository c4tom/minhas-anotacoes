
ct_sambaViewNetworkFolder()
{
	#caja \\km3rede\aplcopel\TIMESHEET\NewTimesheet
	#local PASTA=`echo '$1' | sed "s#\\\#/#g"`
	local PASTA=$(echo -E "$1" | sed "s#\\\#/#g");
	echo $PASTA;
	caja smb:$PASTA;
}