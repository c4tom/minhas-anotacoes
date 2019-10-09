# Alguns destes comando, poderiam ser usado como alias do git
# Recomendacao:
# sudo apt-get install git-extras
[[ -f /usr/bin/git ]] || { return ; }

## Config ##
ct_git_config_ignore_chmod()
{
	git config --global core.fileMode false
}
ct_git_config_auto_linefeed() {
	git config --global core.autocrlf true
}

# usado para o prompt PS1
_gitParseBranch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ [\1]/'
}

# https://www.jamescoyle.net/how-to/1891-git-ssl-certificate-problem-caused-by-self-signed-certificates
ct_gitSSLIgnore() {
	git config --global http.sslVerify false
}

ct_git_config_default_global() {
	# Allow Extended Regular Expressions
	git config --global grep.extendRegexp true
	# Always Include Line Numbers
	git config --global grep.lineNumber true

	# Last commit
	git config --global alias.last 'log -1 HEAD'
	
	git config --global alias.co checkout
	git config --global alias.br branch
	git config --global alias.ci commit
	git config --global alias.st status	
}

# mostra branch atual
#export PS1="\n\w $(_gitParseBranch)\n${CCyan}\u@\h${NC} >${NC}"
#export PS1="$CCyan\u@\h>\[\033[32m\]\w$BIYellow\$(_gitParseBranch)\[\033[00m\]>"
#export PS1="\$(_gitParseBranch)\n\u@\h \w >"
#export PS1="\u@\h\n\w\$(_gitParseBranch)>"



# $1 (Hash do commit a qual voce que voltar, ver 'git log')
ct_gitResetTocommit() {
	hashDoCommit=$1
	git reset --hard $hashDoCommit
	git push origin master --force
}

# https://stackoverflow.com/questions/4858047/the-following-untracked-working-tree-files-would-be-overwritten-by-checkout
# Limpar todas alterações do commit atual.
ct_gitClean() {
	git clean  -d  -fx
}

### LOCAL ####
ct_gitResetCopiaBranchParaOutro()
{
	HELPTXT="Copia a branch <param1> para a branch corrente\n\n${FUNCNAME[0]} <nomeDaBranch>"
	ct_help $1

	nomeDaBranchRemoto=$1
	nomeDaBranchDestino=$(git rev-parse --abbrev-ref HEAD)
	#git reset -- hard $nomeDaBranchOrigem
}

ct_gitDesfazUltimoCommit() {
	git reset HEAD~
}

ct_gitCloneUltimoCommit() {
	git clone --depth=1 "$1"
}


ct_gitListaTodasBranchs() {
	git branch -vv
}

# Remove todas as branchs local, que foram deletadas no remoto 
# Obs: Branchs locais que nunca foram para o remoto, n�o ser�o removidas
# http://erikaybar.name/git-deleting-old-local-branches/
ct_gitSyncRemoteBranchToLocal() {
	git remote prune origin  
	git branch -vv | grep 'origin/.*: gone]' | awk '{print $1}' | xargs git branch -D
}

ct_gitStashSalvar() {
	local NOME="$1"
	echo "Salvo todos itens modificados ou criados"
	git stash push -m "$NOME"
}
ct_gitStashRestauraUltimo() {
	echo "Recuperado último stash gravado"
	git stash apply
}



#### REMOTO ####
ct_gitRemotoDeleteBranch()
{
	HELPTXT="Apaga uma branch remota\n\n${FUNCNAME[0]} <nomeDaBranch>"
	ct_help $1

	nomeDaBranchRemoto=$1
	git push origin --delete $nomeDaBranchRemoto
}


ct_gitDeleteRemoteBranch() {
	local BRANCH_NAME="$1"
	git push origin --delete "$BRANCH_NAME"
}

ct_gitDeleteLocalBranch() {
	local BRANCH_NAME="$1"
	git branch --delete "$BRANCH_NAME"
}

ct_gitMakeIgnoreFile() {
	echo "
# Develop #
.classpath
.project
target

# Compiled source #
###################
*.com
*.class
*.dll
*.exe
*.o
*.so

# Temporary files #
###################
*.swp
*.swo
*~

# Packages #
############
*.7z
*.dmg
*.gz
*.iso
*.jar
*.rar
*.tar
*.zip

# Logs and databases #
######################
*.log
*.sql
*.sqlite

# OS generated files #
######################
.DS_Store*
ehthumbs.db
Icon?
Thumbs.db
" > .gitignore
}