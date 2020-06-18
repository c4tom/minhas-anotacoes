#!/bin/sh
#
# operações com arquivos e pastas
#

## -name "FILE-TO-FIND" : File pattern.
# -exec rm -rf {} \; : Delete all files matched by file pattern.
# -type f : Only match files and do not include directory names.
ct_find_removeOnlyFiles() {
    local tmp="'"$1"'"
    find . -type f -name $tmp -exec rm -f {} \;
}

ct_find_removeFilesOlderDays() {
    local EM_QUAL_PASTA="$1"
    local MAIS_QUE_DIAS=$2
    find "$EM_QUAL_PASTA" -mindepth 1 -mtime +$MAIS_QUE_DIAS -delete
}


ct_find_onlyTextFiles() {
    find . -type f -print0 | xargs -0 grep -I "$1"
}


ct_grep_inFileExtension() {
    local tmp="'"$1"'"
    grep -ir $tmp --include \*.$2
}


ct_chmod_recursiveSomenteFolder() {
	local CAMINHO="$1"
	local PERMSOCTAL=$2
	find $CAMINHO -type d -exec sudo chmod $PERMSOCTAL {} \;
}

ct_chmod_recursiveSomenteFiles() {
	local CAMINHO="$1"
	local PERMSOCTAL=$2

    find $CAMINHO -type f -exec sudo chmod $PERMSOCTAL {} \;
}

ct_filename_removeAccents() {
    local append_text="$1"
    local preppend_text="$2"
    
    for file in *
    do
        filename=${file%%.*}
        extension="${file##*.}"
    
        #file_clean=`echo $filename | tr -cs "[:alnum:]_" _ `
        #file_clean=`echo $filename | iconv -c -f utf8 -t ascii`
        #file_clean=`echo $filename | iconv -f utf8 -t ascii//TRANSLIT | iconv -c -f utf8 -t ascii`
    
        file_clean=`echo $filename | iconv -f utf8 -t ascii//TRANSLIT`
        final="$append_text$file_clean$preppend_text.$extension"
        echo "\"$file\" -> \"$final\" "
        mv "$file" "$final"
done
}