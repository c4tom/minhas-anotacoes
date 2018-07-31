#!/bin/sh
#
# operações com arquivos e pastas
#

## -name "FILE-TO-FIND" : File pattern.
# -exec rm -rf {} \; : Delete all files matched by file pattern.
# -type f : Only match files and do not include directory names.
ct_findAndRemoveFiles() {
    local tmp="'"$1"'"
    find . -type f -name $tmp -exec rm -f {} \;
}

ct_grepInFileExtension() {
    local tmp="'"$1"'"
    grep -ir $tmp --include \*.$2
}