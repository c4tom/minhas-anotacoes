## https://www.davidpashley.com/articles/writing-robust-shell-scripts/
## https://bash.cyberciti.biz/guide/Main_Page

## Lembretes
## Prompt valores padroes
##	
## seta valor padrao para user=root
## local user=${1:-"root"};
##
## Pede o parametro 1
## : ${1?' user'}

export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/desenv/java/apache-cxf-3.3.3/bin

#[[ $(id -u) -eq 0 ]] || { echo >&2 "Must be root to run this function"; return; }

alias gksu='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'


export PATH_ORIGINAL=$PATH

# imprime echo
export CT_VERBOSE=true

export HISTCONTROL=erasedups
export HISTSIZE=5000
export HISTTIMEFORMAT="%d/%m/%y %T "
