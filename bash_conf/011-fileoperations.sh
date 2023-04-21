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

# Remove qualquer arquivo em uma determinada <$1:pasta> com mais de <$2:dias>
ct_find_removeFilesOlderDays() {
    local EM_QUAL_PASTA="$1"
    local MAIS_QUE_DIAS=$2
    echo_and_run find "$EM_QUAL_PASTA" -mindepth 1 -mtime +$MAIS_QUE_DIAS -delete
}

# Busca um palavra, somente em arquivos textos
ct_find_onlyInTextFiles() {
    echo_and_run find . -type f -print0 | xargs -0 grep -I "$1"
}


ct_find_top_size_files_in_dir() {
    : ${1?: '<caminho>'}
    : ${2?: '<quantidade>'}
    find $1 -type f -exec du -Sh {} + | sort -rh | head -n $2
}

ct_find_top_size_dirs() {
    : ${1?: '<caminho>'}
    du -hs "$1/*" | sort -rh | head -5
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


# Remove acentos do nome do arquivo
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


# return filename without extension and extension $1 $2
# Bug: se tiver espaço ou caracteres especial nao funcionará
ct_filename_ext() {
	local filename=$(basename $1)
    local filenameSemExt=`echo ${filename%%.*}`
    local ext=`echo ${filename##*.}`
    
    echo $filenameSemExt $ext

    # para atribuir a variaveis, use
    # read nome ext <<< `ct_filename_ext <filename>`
}


ct_ls_com_octal() {
    stat -c '%n|%a|%A|%F|%U|%G|%s' * | column -t -s "|"
}



# Show CSV and similar in columns
ct_csv_view() {
    : ${1?: "<filename>"}
    : ${2?: "<separator>"}
    cat "$1"  | column -t -s $2
}