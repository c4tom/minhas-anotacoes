[[ `isWin` != "1" ]] || { return ; }

[[ -f /usr/bin/pandoc ]] || { return ; }

ct_markdown_reader_cmd() {
    : ${1?' <filename.md>'}

    pandoc $1 | w3m -T text/html
}