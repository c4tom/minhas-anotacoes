# Executa o winmerge
# $1 Arquivo 1
# obs: argumento 2 ou mais, não está funcionando.

POLBIN="/usr/share/playonlinux/playonlinux"
[[ -f $POLBIN ]] || { return ; }

_winepath(){
	ArgWinePath=`winepath -w "$1"`
	FileName=${1:+$ArgWinePath}
	echo $FileName
}

# http://manual.winmerge.org/Command_line.html
ct_winmerge() {
	file1=`_winepath "$1"`
	file2=`_winepath "$2"`
	$POLBIN --run "WinMergeU" /r /xq "$file1" "$file2"
}

# para usar com git difftool
ct_winmergeGit() {
		$POLBIN --run "WinMergeU" -e -u -dl "Local" -dr "Remote" "$1" "$2"
}

ct_wineWinMerge() {
	echo Launching WinMergeU.exe: $1 $2
	"/home/$USER/.PlayOnLinux/wineprefix/default/drive_c/Program Files/WinMerge/WinMergeU.exe" -e -u -dl "Local" -dr "Remote" "$1" "$2"
}


# Executa Notepad++
ct_npp(){
	$POLBIN --run "Notepad Plus Plus" "$1"
}