[[ `isWin` == "1" ]] || { return ; }

# instalar 
# apt-get install tesseract-ocr tesseract-ocr-por tesseract-ocr-spa tesseract-ocr-eng ocrmypdf imagemagick yagf
[[ -f /usr/bin/tesseract ]] || { return ; }


ocrPDF2TXT() {
	local ARQUIVO_PDF="$1"
	local ARQUIVO_TXT="$2"
	local SAIDA_TIFF=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 32 | head -n 1)".tiff"
	convert -density 300 "$ARQUIVO_PDF" -depth 8  -background white -alpha Off $SAIDA_TIFF
	tesseract -l por $SAIDA_TIFF "$ARQUIVO_TXT"
}