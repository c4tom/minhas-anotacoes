#!/bin/sh
#
# funcoes para conversão de caracteres
#

# https://stackoverflow.com/questions/37052760/how-can-i-convert-from-us-ascii-to-utf-8-with-iconv
# An ASCII file is already an UTF-8 file because UTF-8 is backwards compatible. 
#	file prints the lowest common denominator; you just have to know what that means. 
# Voting to close as unreproducible. – tripleee May 5 '16 at 14:11
# Saving as UTF-8 may add the BOM at the start of the file. These three bytes turn it into 
# something else than US-ASCII, quite on purpose. It's not "garbled", you are just using an 
# incorrect or misconfigured tool to inspect 


# Converte de uma lista de charset (execute: iconv -l) para ...
# $1 De: 
# $2 Para:
# $3 arquivo
ct_charsetConvertFileFROM_TO() {
	iconv -f $1 -t $2//TRANSLIT "$3" > file.tmp
	cat file.tmp > "$3" 
	rm -f file.tmp
}
# somente imprime saida
ct_charsetConvertFROM_TO_OutuputOnly() {
	iconv -f $1 -t $2 "$3"
}


# Converte um arquivo codificado em ISO-8859-1 para UTF-8
# $1 = /caminho/do/arquivo/arquivo_nome
ct_charsetConvertISO88591toUTF8(){
	ct_charsetConvertFileFROM_TO ISO-8859-1 UTF-8 "$1"
}


# Converte um arquivo codificado em UTF-8 para ISO-8859-1
# $1 = /caminho/do/arquivo/arquivo_nome
ct_charsetConvertUTF8toISO88591(){
	ct_charsetConvertFileFROM_TO UTF-8 ISO-8859-1 "$1"
}

# mostrar charset encode de um arquivo 
# $1 = arquivo.ext
ct_fileChartSet() {
	file --mime-encoding "$1"
}


# Mostra todos charset dos arquivos filtrados=$1 da pasta/diretorio corrente
# use: ct_charsetShowListFile <filtro: ex.: *.java>
ct_charsetShowListFile() {
	local IFS=$'\n'
	for i in $(find ./ -name "$1"); do echo $(ct_fileChartSet "$i"); done
}

# Converte uma lista de arquivos listado por uma expressão do bash (ex.: *.txt) recursivamente
# $1 - DE (charset)
# $2 - PARA (charset)
# $3 - Expressão (ex.: *.txt) neste exemplo todos os arquivos com extensão txt serão convertidos, recursivamente
ct_charsetConvertListFROM_TO(){
	local IFS=$'\n'
	for i in $(find ./ -name "$3")
	do 
		tmp_result=$(ct_fileChartSet "$i")
		tmp_file=$(echo $tmp_result | cut -f1 -d':')
		tmp_charset=$(echo $tmp_result | cut -f2 -d':' | xargs)
		tmp_charset=$(toUpperCase $tmp_charset)
	
		echo -n "- $tmp_file tem charset: '$tmp_charset'";
		
		case "$tmp_charset" in
			"$1") 
			ct_charsetConvertFileFROM_TO $1 $2 $tmp_file
			echoColorn " -> $2 $BGreen(OK)"
			;;
		esac
		echo ""
	done
}

# Convert uma lista de arquivos de ISO-8859-1 para UTF-8
ct_charsetConvertListISO88591_TO_UTF8() {
	ct_charsetConvertListFROM_TO ISO-8859-1 UTF-8 "$1"
}


# Converte todos arquivos *.properties para caracteres unicode, recursivamente
ct_charsetConvertPropertiesFileTOUnicode(){
	# Converte todos arquivos *.properties para caracteres unicode, recursivamente
	for i in $(find ./ -name "*.properties")
	do 

		native2ascii -encoding utf8 $i .tmp.properties
		cat .tmp.properties > $i
		rm .tmp.properties;
		
		echoColorn " -> $i $BGreen(OK)"
		echo "";
	done
}


ct_corrigeConversaoGitParaUTF8()
{
	git checkout "$1"
	cat "$1" | sed 's/ISO-8859-1/UTF-8/g' > /tmp/aaaaaaaaaa
	cat /tmp/aaaaaaaaaa  > "$1"
	ct_charsetConvertISO88591toUTF8 "$1"	
}