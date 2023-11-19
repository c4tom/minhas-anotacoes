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


## hotkeys

#ctrl-r	to search through your command history in reverse (newest to oldest)
#ctrl-k	to clear all the text after cursor
#ctrl-u	to clear all the text before cursor
#ctrl-a	move to beginning of the current
#ctrl-e	move to end of the current
#ctrl-f	move forward one char
#ctrl-b	move backward one word

export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/snap/bin

#[[ $(id -u) -eq 0 ]] || { echo >&2 "Must be root to run this function"; return; }

alias gksu='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'


export PATH_ORIGINAL=$PATH

# imprime echo
export CT_VERBOSE=true

export HISTCONTROL=erasedups
export HISTSIZE=9000
export HISTTIMEFORMAT="%d/%m/%y %T "

export uid=$(id -u)
export gid=$(id -g)

ct_mate_terminal_titulo() {
    local titulo
    titulo="${1?' titulo'}"
    PROMPT_COMMAND='echo -en "\033]0;'"$titulo"'\a"'
}
