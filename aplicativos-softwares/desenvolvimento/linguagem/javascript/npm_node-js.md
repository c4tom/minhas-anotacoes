

Instalação Portável

*Obs: Este vem com node.exe e npm

1) Obtenha a última versão em http://nodejs.org/dist/latest/ (no meu caso -node-v8.1.3-win-x64.7z) (ou Download https://nodejs.org/en/download/)
2) Descompacte o conteúdo na pasta nodejs
1) 


Get node binary (node.exe) from http://nodejs.org/download/
Create the folder where node will reside and move node.exe to it
Download the last zip version of npm from http://nodejs.org/dist/npm
Unpack the zip inside the node folder
Download the last tgz version of npm from http://nodejs.org/dist/npm
Open the tgz file and unpack only the file bin/npm (without extension) directly on the node folder.
Add the the node folder and the packages/bin folder to PATH
On a command prompt execute npm install -g npm to update npm to the latest version
Now you can use npm and node from windows cmd or from bash shell like Git Bash of msysgit.



Referências
- http://gareth.flowers/nodejs-portable/