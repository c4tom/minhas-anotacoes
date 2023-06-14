# $0	Identifica o comando emitido
# $@	O conjunto dos argumentos
# $*	Relação dos argumentos fornecidos
# $#	Número de argumentos fornecidos
# $?	Código de retorno do último comando executado
# $$	Número (pid) de identificação do processo
# $!	Identificação (pid) do último processo executado em background


HIST_PWD=$(pwd)
HASSUDO=false;
HASAPT=false;

if [[ -f $(type -P sudo) ]]
    then
        HASSUDO=true;
fi

if [[ -f $(type -P apt) ]]
    then
        HASAPT=true;
fi;



# download arquivos no site da source forge
# Use: download_source_forge <url>
alias wget_source_forge='wget --content-disposition -q '
alias wget_content_disposition='wget --content-disposition -q '

historyOFF() {
    set +o history
}

historyON() {
    set -o history
}

# function that aborts the script on failure
die() { echo "$*" 1>&2 ; exit 1; }



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
    # [[ $OS = "Windows_NT" ]] || { return ; }

    if test -z $WINDIR
    then
        echo 0
    else
        echo 1
    fi
}

isRoot() {
    [[ $(id -u) -eq 0 ]] || { echo >&2 "Must be root to run this function"; kill -INT $$; }
}

# if `isexec "$file"`; then ... fi
isexec() { 
    [[ -f "$1" && -x $(realpath "$1") ]]; 
}

# if `isFile "$file"`; then ... fi
isFile() {
    [[ -f "$1" ]]; 
}



# https://stackoverflow.com/a/1923893/6709209
askToPassword()
{
    local password
    prompt=${1:-"Enter Password:"};
    while IFS= read -p "$prompt" -r -s -n 1 char
    do
        if [[ $char == $'\0' ]]
        then
            break
        fi
        prompt='*'
        password+="$char"
    done
    echo $password
}


### Open AnyFile ####
openAnyFile() {
    xdg-open "$1"
}

alias open=openAnyFile

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
# obs: se for passar ! na regra, precisa escapar, ou seja, usar \!
ct_randomStringGen() {
  local tamanho=${1:-12}
  local caracteres=${2:-"ULNS"}
  local senha=""
  local tipos_caracteres=""
  if [[ $caracteres == *"U"* ]]; then
    tipos_caracteres+="ABCDEFGHIJKLMNOPQRSTUVWXYZ"
  fi
  if [[ $caracteres == *"L"* ]]; then
    tipos_caracteres+="abcdefghijklmnopqrstuvwxyz"
  fi
  if [[ $caracteres == *"N"* ]]; then
    tipos_caracteres+="0123456789"
  fi
  if [[ $caracteres == *"S"* ]]; then
    tipos_caracteres+="@#$%^&*()-_=+[]{}<>,.?/:;|~"
  fi
  for ((i=0; i<$tamanho; i++)); do
    tipo_caracter=${tipos_caracteres:$((RANDOM % ${#tipos_caracteres})):1}
    senha+=$(cat /dev/urandom | tr -dc "$tipo_caracter" | head -c 1)
  done
  echo "$senha"
}

# bash random generator between two numbers
ct_rand() {
    local int1=$1
    local int2=$2
    shuf -i $int1-$int2 -n 1
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


ct_filepath() {
    : ${1?' file'}

    echo $(pwd)/$1
}

ct_filesizeK() {
   local size=$(wc -c "$1" | awk '{print $1}')
   echo $(($size/1024))
}

ct_filesizeM() {
   local size=$(wc -c "$1" | awk '{print $1}')
   echo $(($(($size/1024))/1024))
}


### Password
# U = Upper
# L = Lower
# N = Number
# S = Special
ct_genPassword() {
    local size=${1:-"16"};
    local caracteres=${2:-"ULN"}
    ct_randomStringGen $size $caracteres
}

lastLocalFolder() {
    cd "$HIST_PWD"
}
saveFolder() {
    HIST_PWD="$(pwd)"
}

# https://www.tecmint.com/create-a-shared-directory-in-linux/
# As root, execute this
ct_createDeveloperFolderShared() {
    local FOLDER="$1"
    local USER="$2"
    local GROUP="desenv"
    
    sudo mkdir -p "$1"
    
    sudo groupadd $GROUP
    sudo usermod -a -G $GROUP $USER
    
    sudo chgrp -R $GROUP $FOLDER
    sudo chmod -R 2775 $FOLDER
}

ct_monitorDesliga() {
    xset dpms force off
}


ct_parseINI() {
    local INIFILE="$1"
    local SECTION=$2
    local SECTION_PARAM=$3
    sed -nr "/^\[$SECTION\]/ { :l /^$SECTION_PARAM[ ]*=/ { s/.*=[ ]*//; p; q;}; n; b l;}" "$INIFILE"
}


ct_du_totalDirSizeIgnoreSymLinks(){
    ct_totalSizeDir "$@"
}
ct_totalSizeDir() {
    local dir="$1";
    find ${dir} -exec du -s {} + | awk '{total = total + $1}END{print total}'
}

[[ -f /usr/bin/progress ]] || { 
    cp_with_progress () {
        # https://github.com/Xfennec/progress
        # apt install progress

        local source="$1"
        local target="$2"
        cp "$source" "$target" & progress -mp $!
    }
}

# Bash, with GNU sleep
spin() {
  local i=0
  local sp='/-\|'
  local n=${#sp}
  printf ' '
  sleep 0.1
  while true; do
    printf '\b%s' "${sp:i++%n:1}"
    sleep 0.1
  done
}

# imprime uma mensagem
banner()
{
  echo "+------------------------------------------+"
  printf "| %-40s |\n" "`date`"
  echo "|                                          |"
  printf "|`tput bold` %-40s `tput sgr0`|\n" "$@"
  echo "+------------------------------------------+"
}

# listar funcoes e alias setados
function ct_listar_funcoes_e_alias() {
    echo
    echo -e "$On_IRed Funções:$CGreen"
    compgen -A function
    echo
    echo -e "$On_IGreen Aliases:$CYellow"
    compgen -A alias
    echo
    echo -e "$Color_Off"
}



### RSYNC
# https://superuser.com/questions/109780/how-to-speed-up-rsync

ct_rsync_firstCopy() {
    : ${1?' source_dir'}
	: ${2?' destiny'}
    : ${2?' destiny'}
    rsync -aP -r --inplace --del --exclude-from=$TO_EXCLUDE "$source_dir" "$destiny"
}

ct_rsync_firstCopy() {
    : ${1?' source_dir'}
	: ${2?' destiny'}
    rsync -arPS --no-whole-file --del --exclude-from=$TO_EXCLUDE "$source_dir" "$destiny"
}

ct_rsync_overNetworkSSH() {
    : ${1?' source_dir'}
	: ${2?' destiny'}

    rsync -aHAXxv --numeric-ids --delete --progress -e "ssh -T -c arcfour -o Compression=no -x" "$source_dir" "$destiny"
}


### CHATTR
# https://en.wikipedia.org/wiki/Chattr

ct_chattr_readOnly() {
    : ${1?' Yes=+ or Not=-'}
    : ${2?' filename'}
    sudo chattr $1i "$2" ; lsattr "$2"
}



ct_mylinuxInfo() {
    if [ $(isWin) == "1" ]
        then
            uname -a
        else 
            lsb_release -a
    fi
}

# https://pt.wikipedia.org/wiki/TMPFS
ct_tmpfs_info() {
    echo_and_run df --human-readable --type=tmpfs
}



# Other Utils

#https://gist.github.com/c4tom/da1728f8aac0b8d4c288b015a5f7d1cb
ct_dictionaryFromFile() {
    : ${1?' fileName (text content)'}

    cat "$1" | tr [:upper:] [:lower:] | tr -d [:punct:] | tr -d [:digit:] | tr ' ' '\n' | sort | uniq
}



ct_diff() {
    alias diff='diff --width=$COLUMNS --suppress-common-lines --side-by-side --color=always' "$1" "$2"
}