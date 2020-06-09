
##
# files.autoGuessEncoding=true para detectar e abrir arquivos

[[ -f /usr/bin/code ]] || { return ; }

#alias code="code -p"

ct_code_executaSemExtensoes() {
    code --disable-extensions "$@"
}

ct_code_listaExtensoes() {
    code --list-extensions
}

