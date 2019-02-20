HIST_PWD=$(pwd)

# download arquivos no site da source forge
# Use: download_source_forge <url>
alias download_source_forge="wget --content-disposition -q "


# https://unix.stackexchange.com/questions/87908/how-do-you-empty-the-buffers-and-cache-on-a-linux-system
ct_freeMemoryCache() {
	free -m
	sudo sh -c 'echo 1 >/proc/sys/vm/drop_caches'
	sudo sh -c 'echo 2 >/proc/sys/vm/drop_caches'
	sudo sh -c 'echo 3 >/proc/sys/vm/drop_caches'
	sudo swapoff -a
	sudo swapon -a
	free -m
}

__qualquerTeclaContinuar()
{
	## ver https://stackoverflow.com/questions/92802/what-is-the-linux-equivalent-to-dos-pause
	read -rsp $'Pressione [ENTER] para continuar...\n'
}

__pause(){
	read -p "$*"
}


isWin() {
	if test -z $WINDIR
		then
			echo 0
		else
			echo 1
	fi
}


### Open AnyFile ####
openAnyFile() {
	xdg-open "$1"
}

### Lista todos arquivos da pasta com seu caminho relativo, em forma de lista
ct_ls2lista(){
	IFS=$'\n'
	local LISTA=$(printf " \"`pwd`/%s\"" *)
	echo $LISTA
}


ct_bashNaoQuebraLinha()
{
	export IFS=$'\n'
}

# bash generate random 32 character alphanumeric string (upper and lowercase)
ct_uuidGen() {
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1
}

# bash generate random 32 character alphanumeric string (lowercase only)
ct_randomStringGen() {
	cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1
}

# bash generate random number between 0 and 9
ct_rand0_9() {
	cat /dev/urandom | tr -dc '0-9' | fold -w 256 | head -n 1 | head --bytes 1
}

# bash generate random number between 0 and 99
ct_rand0_99() {
	local NUMBER=$(cat /dev/urandom | tr -dc '0-9' | fold -w 256 | head -n 1 | sed -e 's/^0*//' | head --bytes 2)
	if [ "$NUMBER" == "" ]; then
		NUMBER=0
	fi
	echo $NUMBER
}

# bash generate random number between 0 and 999
ct_rand0_999() {
	local NUMBER=$(cat /dev/urandom | tr -dc '0-9' | fold -w 256 | head -n 1 | sed -e 's/^0*//' | head --bytes 3)
	if [ "$NUMBER" == "" ]; then
		NUMBER=0
	fi
	echo $NUMBER;
}


#### Strings ####
ct_toLowerCase() {
	echo "$1" | tr "[:upper:]" "[:lower:]"
}

ct_toUpperCase() {
	echo "$1" | tr "[:lower:]" "[:upper:]" 
}

# https://stackoverflow.com/questions/922449/how-can-i-replace-multiple-empty-lines-with-a-single-empty-line-in-bash
# "Arquivo: $1"
ct_replaceTwoOrMoreBlankLinesToOneFromFile() {
	grep -A1 . "$1" | grep -v "^--$"
}



#### Folders and Files
[[ ! -f /usr/bin/meld ]] || { 
	ct_compareFolders() {
		local pasta1="$1"
		local pasta2="$2"
		local rand=`randomStringGen`

		pasta1=`realpath $pasta1`;
		pasta2=`realpath $pasta2`;

		find $pasta1 -type f | sed "s#$pasta1##" | sort > /tmp/pasta1-$rand
		find $pasta2 -type f | sed "s#$pasta2##" | sort > /tmp/pasta2-$rand

		meld /tmp/pasta1-$rand /tmp/pasta2-$rand
	}
}




### Proxy ###
ct_proxyEnable() {
	export http_proxy=http://localhost:3128/
	export https_proxy=http://localhost:3128/
}

ct_proxyDisable() {
	unset http_proxy
	unset https_proxy
}

autoEnableProxy() {
	if [[ ! $http_proxy ]]
		then 
			if [ $(ct_netCheckPortIsListen 3128) = "open" ]
				then
					echo "Proxy ON (localhost)"
					ct_proxyDisable
			fi
	fi
}

autoEnableProxy


### Password

ct_genPassword() {
    local MATRIX='0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'
    local LENGTH=10
		local rand=`ct_rand0_999`
    while [ ${n:=1} -le $LENGTH ]; do
        PASS="$PASS${MATRIX:$(($rand%${#MATRIX})):1}"
        let n+=1
    done
    echo "$PASS"
}

lastLocalFolder() {
	cd $HIST_PWD
}
saveFolder() {
	HIST_PWD=$(pwd)
}