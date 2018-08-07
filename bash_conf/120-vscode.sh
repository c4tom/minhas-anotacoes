
##
# files.autoGuessEncoding=true para detectar e abrir arquivos

[[ -f /usr/bin/code ]] || { return ; }

alias code="code -p"

ct_codeExecutaSemExtensoes() {
    code -p --disable-extensions "$@"
}

ct_codeListaExtensoes() {
    code --list-extensions
}

