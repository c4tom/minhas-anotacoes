# Alguns destes comando, poderiam ser usado como alias do git
# Recomendacao:
# sudo apt-get install git-extras
[[ -f /usr/bin/git ]] || { return ; }

ct_git_config_ignore_chmod()
{
	git config --global core.fileMode false
}

# usado para o prompt PS1
_gitParseBranch() {
     git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
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
# Limpar todas alteraÃ§Ãµes do commit atual.
ct_gitClean() {
	git clean  -d  -fx ""
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


