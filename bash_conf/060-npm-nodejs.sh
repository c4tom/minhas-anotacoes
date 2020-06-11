#Node JS - Node.js is a platform built on Chrome's JavaScript runtime for easily building fast, scalable network applications. Real-Time services (Chat, Games etc)
#NPM is a package manager. Typically this software is installed to build Node applications.

#It let's you install software (libraries, plugins, frameworks and applications).
# https://www.tecmint.com/install-nodejs-npm-in-centos-ubuntu/
# Veja tambem: https://nodejs.org/en/download/

if [[ ! -f $(type -p node) ]] 
then
	nodejs_installInLinuxMint() {
		sudo curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
		sudo apt-get install nodejs
	}
fi

# Tools
# https://www.npmjs.com/package/sitemap-generator-cli
#	

ct_npm_corrigeISSUER_CERT_LOCALLY() {
	
	#npm ERR! code UNABLE_TO_GET_ISSUER_CERT_LOCALLY
	#npm ERR! errno UNABLE_TO_GET_ISSUER_CERT_LOCALLY
	#npm ERR! request to https://registry.npmjs.org/mime-db/-/mime-db-1.40.0.tgz failed, reason: unable to get local issuer certificate
	npm config set registry http://registry.npmjs.org/

	#Error: unable to get local issuer certificate
	#Error: unable to get local issuer certificate
    #  at TLSSocket.onConnectSecure (_tls_wrap.js:1177:34)
    #  at TLSSocket.emit (events.js:193:13)
    #  at TLSSocket._finishInit (_tls_wrap.js:668:8)
	npm config set strict-ssl false
}


ct_node_npm_linux_info_git_commit() {
	local finfo=/tmp/info
	echo -e "lsb_release -a\n" > $finfo
	lsb_release -a >> $finfo
	echo -e "\nnpm -v  : `npm -v`" >> $finfo
	echo "node -v  : `node -v`" >> $finfo
	echo -e "\n" >> $finfo

	echo "git log -1 | grep commit " >> $finfo
	git log -1 | grep commit >> $finfo

	cat $finfo
}