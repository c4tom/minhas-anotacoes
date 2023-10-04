
##
# files.autoGuessEncoding=true para detectar e abrir arquivos

[[ -f /usr/bin/code ]] || { return ; }

#alias code="code -p"

alias code-markdown="code --profile=MD"
alias code-java="code --profile=Java"
alias code-php="code --profile=PHP"
alias code-javascript="code --profile=JS"
alias code-python="code --profile=Python"

ct_code_executaSemExtensoes() {
    code --disable-extensions "$@"
}

ct_code_listaExtensoes() {
    code --list-extensions
}

ct_code_install_my_extension() {
    local VSCODE_EXT=""

    vsadd() {
        VSCODE_EXT="$VSCODE_EXT $@"
    }


    # Bash
    vsadd mads-hartmann.bash-ide-vscode;

    # Git
    vsadd eamodio.gitlens
    vsadd pomber.git-file-history
    vsadd mhutchie.git-graph
    #vsadd arturock.gitstash # Give extra stash abilities to Code. Visually browse stashes, review and extract changes. Get all stash commands and more.
    vsadd exelord.git-commits #

    # HTML
    vsadd roscop.activefileinstatusbar # snippets html5
    vsadd abusaidm.html-snippets;

    # Bootstrap
    vsadd thekalinga.bootstrap4-vscode # Snippet

    # Dart
    vsadd Dart-Code.flutter #

    # Database
    vsadd dineug.vuerd-vscode # ERD design

    # Docker
    vsadd ms-azuretools.vscode-docker #

    # Javascript & Type Script
    vsadd chenxsan.vscode-standardjs # Integrates JavaScript Standard Style into VS Code.
    vsadd DenisGolovin.dependencies-diagram-generator # Dependencies Diagram Generator
    vsadd xabikos.JavaScriptSnippets # code snippets for JavaScript in ES6 syntax
    # vsadd AlexShen.classdiagram-ts # create class diagram for typescript projects
    vsadd donjayamanne.jquerysnippets #

    # Markdown
    #vsadd yzane.markdown-pdf # Gerador de PDF,HTML,PNG a partir de markdown
    vsadd davidanson.vscode-markdownlint # Markdown linting and style checking for Visual Studio Code
    vsadd jayfidev.markdown-touchbar # Testar se ele nao zua com o codigo
    vsadd bierner.markdown-preview-github-styles # view in github style
    vsadd telesoho.vscode-markdown-paste-image # Paste image, ask for name image

    vsadd jebbs.markdown-extended # Export in HTML / PDF / PNG / JPEG, many shortcut, table tools

    # NPM - NODE
    vsadd howardzuo.vscode-npm-dependency #
    vsadd chris-noring.node-snippets # digite node-*
    vsadd aslamanver.node-js-dependency-manager # npm manager
    vsadd herrmannplatz.npm-dependency-links # link directly with site pkg in file package.json
    vsadd nitayneeman.puppeteer-snippets # puppeteer - automate for google chrome

    vsadd roscop.activefileinstatusbar # testar

    # REACT
    vsadd msjsdiag.vscode-react-native #

    # REST
    vsadd humao.rest-client #

    # Uteis - diversos
    vsadd WallabyJs.quokka-vscode WallabyJs.wallaby-vscode #
    vsadd aaron-bond.better-comments # Improve your code commenting by annotating with alert, informational, TODOs, 
    vsadd DaGhostman.vs-treeview # Tree View extension providing an overview of the main file symbols (seems outline function)

    vsadd SonarSource.sonarlint-vscode #;

    vsadd roscop.activefileinstatusbar # show full path file in status bar
    vsadd sandcastle.vscode-open # show in menu, option to "open with default application" alt+ctrl+o, alternative (YuTengjing.open-in-external-app)
    vsadd esbenp.prettier-vscode # Formatador de codigo JavaScript · TypeScript · Flow · JSX · JSON, CSS · SCSS · Less, HTML · Vue · Angular, GraphQL · Markdown · YAML (alternative: HookyQR.beautify)

    vsadd ms-vscode-remote.remote-containers #
    vsadd ms-vscode-remote.remote-ssh-edit-nightly

    vsadd formulahendry.code-runner # run php, js etc

    vsadd ms-vscode-remote.remote-ssh # edit remote file via ssh
    vsadd ybaumes.highlight-trailing-white-spaces # Highlite spaces

    # Corretor
    vsadd adamvoss.vscode-languagetool-pt # Language Tool, idioma pt e pt-br
    vsadd adamvoss.vscode-languagetool-en
    vsadd adamvoss.vscode-languagetool-es

    for i in $VSCODE_EXT
    do
        code --install-extension $i
    done
}

ct_code_create_bins() {
    #!/bin/sh

    local VSCMD="code --extensions-dir"

    local ROOT_FOLDER=/dados/vscode

    echo $VSCMD $ROOT_FOLDER/java "\$1" | sudo tee --append /usr/bin/code-java

    echo $VSCMD $ROOT_FOLDER/markdown "\$1" | sudo tee --append /usr/bin/code-markdown

    echo $VSCMD $ROOT_FOLDER/php "\$1" | sudo tee --append /usr/bin/code-php

    echo $VSCMD $ROOT_FOLDER/nodejs-js-web "\$1" | sudo tee --append /usr/bin/code-nodejs

    echo $VSCMD $ROOT_FOLDER/py "\$1" | sudo tee --append /usr/bin/code-py

    echo $VSCMD $ROOT_FOLDER/dotnet-csharp "\$1" | sudo tee --append /usr/bin/code-csharp

    sudo chmod +x /usr/bin/code-*

}
# Testar

# 
# Aashish.java-colored-text-printing-extension
# abusaidm.html-snippets
# adashen.vscode-tomcat
# AlanWalk.markdown-toc

# AlexShen.classdiagram-ts
# andrew-codes.mocha-snippets
# arturock.gitstash
# 
# bat67.markdown-extension-pack
# bierner.markdown-checkbox
# bierner.markdown-emoji

# bmewburn.vscode-intelephense-client
# chenxsan.vscode-standardjs
# 
# christian-kohler.npm-intellisense
# christian-kohler.path-intellisense
# Compulim.vscode-mocha
# csholmq.excel-to-markdown-table
# 
# darkriszty.markdown-table-prettify
# dbaeumer.vscode-eslint
# DenisGolovin.dependencies-diagram-generator
# devdoge1.node-snippets
# 
# esbenp.prettier-vscode
# formulahendry.code-runner
# foxundermoon.shell-format
# funkyremi.vscode-google-translate
# goessner.mdmath
# gurayyarar.imagesprites
# henriiik.docker-linter
# 
# 
# 
# 
# ionutvmi.path-autocomplete
# jasonnutter.search-node-modules
# JayFiDev.markdown-touchbar
# josefpihrt-vscode.snippetica-markdown
# keshan.markdown-live
# mads-hartmann.bash-ide-vscode
# maty.vscode-mocha-sidebar
# mdickin.markdown-shortcuts
# mhutchie.git-graph
# MicroProfile-Community.mp-starter-vscode-ext


# ms-vscode-remote.remote-wsl
# ms-vscode-remote.vscode-remote-extensionpack
# ms-vsliveshare.vsliveshare
# msjsdiag.debugger-for-chrome
# 
# pack.jade-bootstrap
# pomber.git-file-history
# redhat.java
# rifi2k.format-html-in-php
# ritwickdey.LiveServer
# robole.marky-markdown

# 
# Saravanaselvan.mocha-test-generator
# shakram02.bash-beautify

# shengchen.vscode-checkstyle
# sohibe.java-generate-setters-getters
# SonarSource.sonarlint-vscode
# sprdp.remote-browser
# steoates.autoimport
# subhendukundu.gif-code-snippet
# TakumiI.markdowntable
# TeamsDevApp.ms-teams-vscode-extension
# telesoho.vscode-markdown-paste-image
# tgreen7.vs-code-node-require
# TqrHsn.vscode-docker-registry-explorer
# usernamehw.remove-empty-lines
# vaclav-purchart.javascript-test-runner
# VisualStudioExptTeam.vscodeintellicode
# vscjava.vscode-java-debug
# vscjava.vscode-java-dependency
# vscjava.vscode-java-pack
# vscjava.vscode-java-test
# vscjava.vscode-maven
# waderyan.nodejs-extension-pack
# wmaurer.html2jade
# xabikos.JavaScriptSnippets
# yzhang.markdown-all-in-one
# ziishaned.hugobot

ct_vscode_linkCacheToTmp() {
    local cacheDir=/.cache/vscode
    cd $HOME/.config/Code
    killall -9 code

    ct_bashNaoQuebraLinha

    local dirs="blob_storage
Cache
CachedData
CachedExtensions
CachedExtensionVSIXs
Code Cache
Crash Reports
Local Storage
logs
GPUCache
exthost Crash Reports"

    sleep 1

    rm -fr $cacheDir

    for i in $dirs
    do
    mkdir -p "$cacheDir/$i"
    rm -fr "$i"
    ln -sf "$cacheDir/$i" "$i"

    done;
}


ct_teams_linkCacheToTmp() {
    local cacheDir=/.cache/teams
    cd "$HOME/.config/Microsoft/Microsoft Teams"
    killall -9 teams

    ct_bashNaoQuebraLinha

    local dirs="Application Cache
blob_storage
Cache
Code Cache
Crash Reports
Local Storage
logs
GPUCache
Session Storage
Service Worker
"

    sleep 1

    rm -fr $cacheDir

    for i in $dirs
    do
    mkdir -p "$cacheDir/$i"
    rm -fr "$i"
    ln -sf "$cacheDir/$i" "$i"

    done;
}