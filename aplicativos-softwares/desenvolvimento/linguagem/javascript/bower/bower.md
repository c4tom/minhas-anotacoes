---
page: "bower"
title: "Bower"
description: ""
---
# Bower

## Instalar bower Globalmente

npm install -g bower

*** No Linux executar o comando abaixo (http://stackoverflow.com/questions/20886217/browserify-error-usr-bin-env-node-no-such-file-or-directory)
update-alternatives --install /usr/bin/node nodejs /usr/bin/nodejs 100

se nao resolver, tente:
##ln -s /usr/bin/nodejs /usr/bin/node 
apt-get install nodejs-legacy

senão dá o erro:

> bower search bootstrap
/usr/bin/env: node: No such file or directory



Usando o bower


Pesquisar pacotes
bower search

## Referências
<div class="referencia">
- http://tableless.com.br/bower-na-pratica/
</div>