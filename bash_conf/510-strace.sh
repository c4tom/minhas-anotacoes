
[[ -f /usr/bin/strace ]] || { return ; }

# Mostra os arquivos abertos que um executável abre e lê
# use: strace2 </caminho/do/executável>
alias strace2="strace -e trace=open,read "

ct_straceShowPath() {
    strace -e trace=open,read,file "$1" 
}
