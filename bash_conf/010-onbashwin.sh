if [[ $OS = "Windows_NT" ]]; then
    return
fi

if [[ -z "$(type -t tree)" ]]; then
    tree() {
        find . -print | sed -e 's;[^/]*/;|-- ;g;s;-- |; |;g'
    }
fi
