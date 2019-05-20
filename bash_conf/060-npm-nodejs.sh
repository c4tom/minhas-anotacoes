

# https://www.tecmint.com/install-nodejs-npm-in-centos-ubuntu/
# Veja tambem: https://nodejs.org/en/download/
nodejsInstallLinuxMint() {
	sudo curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install nodejs
}

[[ -f /usr/bin/nodejs ]] || { return ; }

# Tools
# https://www.npmjs.com/package/sitemap-generator-cli
#	


nodejsCorrecoesProblemas() {
	
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