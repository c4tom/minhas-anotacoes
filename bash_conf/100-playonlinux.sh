
if [[ ! -f /usr/share/playonlinux/playonlinux ]]
then
	ct_polInstall()
	{
		cd /tmp
		wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
		sudo wget http://deb.playonlinux.com/playonlinux_oneiric.list -O /etc/apt/sources.list.d/playonlinux.list
		sudo apt-get update
		sudo apt-get install playonlinux
	}
fi



[[ -f /usr/share/playonlinux/playonlinux ]] || { return ; }
# Executa o winmerge
# $1 Arquivo 1
# obs: argumento 2 ou mais, não está funcionando.


POLBIN="/usr/share/playonlinux/playonlinux"
[[ -f $POLBIN ]] || { return ; }

pol() {
	$POLBIN --run "$@"
}

# https://iridakos.com/tutorials/2018/03/01/bash-programmable-completion-tutorial.html
_playonlinux_autocomplete()
{
	cd /home/$USER/.PlayOnLinux/shortcuts
	local LISTA=$(printf " '%s'" *)
	complete -W "$LISTA" pol
}
_playonlinux_autocomplete

_winepath(){
	ArgWinePath=`winepath -w "$1"`
	FileName=${1:+$ArgWinePath}
	echo $FileName
}

# http://manual.winmerge.org/Command_line.html
ct_pol_winmerge() {
	file1=`_winepath "$1"`
	file2=`_winepath "$2"`
	$POLBIN --run "WinMergeU" /r /xq "$file1" "$file2"
}

# para usar com git difftool
ct_pol_winmergeGit() {
		$POLBIN --run "WinMergeU" -e -u -dl "Local" -dr "Remote" "$1" "$2"
}

ct_pol_wineWinMerge() {
	echo Launching WinMergeU.exe: $1 $2
	"/home/$USER/.PlayOnLinux/wineprefix/default/drive_c/Program Files/WinMerge/WinMergeU.exe" -e -u -dl "Local" -dr "Remote" "$1" "$2"
}


# Executa Notepad++
ct_pol_npp(){
	$POLBIN --run "Notepad Plus Plus" "$1"
}

ct_pol_temp_clean(){
	if [ ! -d "/home/$USER/.PlayOnLinux/tmp" ]; then
  		cd /home/$USER/.PlayOnLinux/tmp
		rm -fr *
	fi
}

ct_pol_lista_atalhos() {
	ls -l /home/$USER/.PlayOnLinux/shortcuts
}