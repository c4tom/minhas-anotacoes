
[[ $OS = "Windows_NT" ]] || { 
    return ;
}

[[ -z "`type -t tree`" ]] || {
    tree(){
        find . -print | sed -e 's;[^/]*/;|-- ;g;s;-- |; |;g'
    }
}