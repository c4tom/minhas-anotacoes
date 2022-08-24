
[[ $OS = "Windows_NT" ]] || { return ; }

tree() {
    find . -print | sed -e 's;[^/]*/;|-- ;g;s;-- |; |;g'
}