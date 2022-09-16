[[ `isWin` != "1" ]] || { return ; }

[[ -f /usr/bin/strace ]] || { return ; }

# Mostra os arquivos abertos que um executável abre e lê
# use: strace2 </caminho/do/executável>
alias strace2="strace -e trace=open,read "

ct_strace_showPath() {
    strace -e trace=open,read,file "$1" 
}

ct_strace_openatFiles() {
    strace "$1" 2>&1 | grep 'openat'
}