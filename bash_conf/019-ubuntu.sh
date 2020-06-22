

# gnome charset for meld
# https://askubuntu.com/questions/839755/meld-shows-output-in-unreadable-alphabet-japanese-chinese/877894#877894?newreg=3eb23f4cedc540cb810ff1ca02531f54
ct_meld_corrigeCharset() {
	# gsettings get org.gnome.meld detect-encodings
	gsettings set org.gnome.meld detect-encodings "['utf8','latin1']"
}

