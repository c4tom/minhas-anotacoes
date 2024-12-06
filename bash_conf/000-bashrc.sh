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

# Define a custom 'type' function for Zsh
# Define a custom 'type' function for Zsh
#
# This function mimics the behavior of the 'type' command in Bash for Zsh.
# It determines the type of a given command (builtin, alias, function, or external).
#
# Parameters:
#   $1 - The command to check
#   $@ - Additional options (currently ignored)
#
# Returns:
#   Prints the type of the command:
#     "builtin" for shell built-in commands
#     "alias" for defined aliases
#     "function" for shell functions
#     "external" for external commands
#     "not found" if the command is not recognized
#   Returns 0 if successful, 1 if options are provided (which are ignored)
function type() {
  local command=$1
  local options=("${@:2}")  # Get all options after the command name

  # Check if any options are present
  if [[ ${#options[@]} -gt 0 ]]; then
    # Ignore options like '-t' and '-P'
    echo "Ignoring options: ${options[@]}"
    return 1
  fi

  # Check for built-in commands
  if [[ -n "${builtins[$command]}" ]]; then
    echo "builtin"
  # Check for aliases
  elif [[ -n "${aliases[$command]}" ]]; then
    echo "alias"
  # Check for functions
  elif [[ -n "${functions[$command]}" ]]; then
    echo "function"
  # Check for external commands
  elif [[ -f $(which $command) ]]; then
    echo "external"
  # If not found
  else
    echo "not found"
  fi
}

