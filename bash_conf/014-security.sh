## https://sectools.org/tag/pass-audit/

[[ `isWin` != "1" ]] || { return ; }

[[ -f /usr/bin/testssl.sh ]] || { 
	ct_ssl_install_tester() {
        # https://github.com/drwetter/testssl.sh

        cd /tmp
        wget https://raw.githubusercontent.com/drwetter/testssl.sh/3.0/testssl.sh
        chmod +x testssl.sh
        sudo cp testssl.sh /usr/bin/testssl.sh
	}
	return ; 
}


# https://www.tecmint.com/testssl-sh-test-tls-ssl-encryption-in-linux-commandline/
ct_ssl_TLStest() {
    local URL="$1"
    testssl.sh --parallel $URL
}