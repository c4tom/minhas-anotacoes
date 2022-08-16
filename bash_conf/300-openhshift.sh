# https://manage.openshift.com/account/index Testar Online Gratis

# http://rafabene.com/2016/01/09/docker-images-openshift-network/
# https://github.com/rafabene/devops-demo

# Cliente OpenShift
# Baixe em https://github.com/openshift/origin/releases ou https://www.openshift.org/download.html

# Versão 4
# https://docs.openshift.com/container-platform/4.6/cli_reference/openshift_cli/developer-cli-commands.html

## Utilizado a versao
## https://github.com/openshift/origin/releases/download/v3.9.0/openshift-origin-client-tools-v3.9.0-191fece-linux-64bit.tar.gz

# Pegar o Token
# Acesse pelo navegador e pegue o token https://<server>:8443/console/command-line então execute o comando abaixo:
# oc login https://<server>:8443 --token=<TOKEN>

#Observação: Profile é gravado em ~/.kube/config

[[ -f /usr/bin/oc ]] || { return; }
OC="/usr/bin/oc"

ct_oc_info_install() {
    echo "- baixar e descompactar o oc.exe
- adicionar o caminho no PATH do sistema, da pasta aonde esta o oc.exe
- aqui no bash execute o comando: type oc.exe
- criar um link simbolico: ln -sf /caminho/do/oc.exe /usr/bin/oc
- setar nas variaveis de ambiente OC_SERVER_ADDR=https://endereco.da.API.do.servidor
    "
}

# Autocomplete para o comando oc , no bash
ct_oc_bashEnableCompletion() {
    local command=$($OC completion bash >/tmp/bash_completion.sh)
    echoColor $cmd
    $(command)
    echo_and_run source /tmp/bash_completion.sh
}

__askToPassword() {
    local password
    local prompt=${1:-"Enter Password:"}
    while IFS= read -p "$prompt" -r -s -n 1 char; do
        if [[ $char == $'\0' ]]; then
            break
        fi
        prompt="*"
        password+=$char
    done
    echo $password
}

# Login com usuario e senha
ct_oc_login() {
    
    if test -z $OC_SERVER_ADDR; then
        echo "Favor, setar a variável OC_SERVER_ADDR"
        return 0
    fi
    
    # Fazer login no openshift
    if [ $(_oc_isLogged) = "0" ]; then
        
        if [ $(isWin) == "1" ]; then
            LOGNAME=$USERNAME
        fi
        
        echoColor "Logando em: $OC_SERVER_ADDR como: $LOGNAME"
        
        password=$(__askToPassword "Digite a senha: ")
        
        $OC login --insecure-skip-tls-verify --username=$LOGNAME $OC_SERVER_ADDR -p $password
        $OC project $1
    else
        echo ">>> Já esta logado"
    fi
}

# Login via Token, get it from
# https://<URL-openshift-server>/console/command-line
ct_oc_loginByToken() {
    : ${1?' <token>'}
    $OC login $OC_SERVER_ADDR --token=$1
}

############### ADMIN ##################

# $1 = Registro do usuario com C
# $2 = Nome do projeto
ct_oc_addRole() {
    local REGISTRO=$1
    local PROJETO=$2
    $OC project $PROJETO
    $OC policy add-role-to-user admin $REGISTRO -n $PROJETO
}

# Apaga um usuario do projeto
# $1 chave/registro do usuário
# $2 nome do projeto
ct_oc_delRole() {
    local REGISTRO=$1
    local PROJETO=$2
    $OC project $PROJETO
    $OC policy remove-role-from-user admin $REGISTRO -n $PROJETO
}

# Lista as permissoes de um determinado projeto
# $1 = Nome do projeto
ct_oc_listRole() {
    $OC describe policyBindings :default -n $1
}

# $1 = Nome do projeto
ct_oc_describeProject() {
    : ${1?' <project>'}
    ct_oc_listRole $1
}

_ocGetRunningPOD() {
    echo $($OC get pod --sort-by={metadata.creationTimestamp} | grep -v "deploy" | grep Running | awk '{print $1}' | head -n 1)
}
# Verifica se esta logado no servidor do openshift
_oc_isLogged() {
    result=$($OC status 2>&1 | grep -i error)
    if [ -n "$result" ]; then
        echo 0
    else
        echo 1
    fi
}

# abre ssh no pod do PHP
ct_oc_ssh() {
    $OC rsh $(_ocGetRunningPOD)
}

# executa o bash no POD
ct_oc_exec() {
    : ${1?' <comando>'}
    echo_and_run $OC exec $(_ocGetRunningPOD) -- $1
}

ct_oc_copyLocal2Remote() {
    : ${1?' <local folder>'}
    : ${2?' <remote folder>'}
    echo_and_run $OC cp $1 "$(_ocGetRunningPOD):$2"
}

# Abre a porta 8787 para fazer debug com um POD
# $1 nome do projeto (opcional)
# https://blog.openshift.com/debugging-java-applications-on-openshift-kubernetes/
# Adicione um novo "Remote Java Aplication" e setar a porta 8787

# https://tools.jboss.org/documentation/howto/openshift_debug.html
# https://servicesblog.redhat.com/2019/03/06/remote-debugging-of-java-applications-on-openshift/
ct_oc_debug() {
    echo 'https://blog.openshift.com/debugging-java-applications-on-openshift-kubernetes/'
    echo 'Adicione um novo "Remote Java Aplication" e setar a porta 8787'
    
    local portas=${1:-"8787:8787"}
    
    local pod=$(_ocGetRunningPOD)
    local projeto=$($OC project -q)
    $OC set env dc/$projeto DEBUG=true
    echo "$OC POD: $pod"
    $OC port-forward $pod $portas
}

# $1 = container name (ou nome do projeto, ex.: doahml, atihml, etc)
ct_oc_serverLog() {
    local projeto=$($OC project -q)
    $OC logs -f dc/$projeto
}

ifSet() {
    : ${1?' <default value>'}
    ${2:-""}
    local any=$()
}

# faz um rsync do host para guest (pod)
# $1 pasta local (host)
# $2 pasta guest (pod)
ct_oc_rsyncLocalToRemote() {
    : ${1?' <local folder>'}
    : ${2?' <remote folder>'}
    $OC rsync "$1" "$(_ocGetRunningPOD):$2"
}

ct_oc_rsysnRemoteToLocal() {
    : ${1?' <local folder>'}
    : ${2?' <remote folder>'}
    $OC rsync "$(_ocGetRunningPOD):$2" "$1"
}

ct_ocClusterUp() {
    sudo oc cluster up --public-hostname='127.0.0.1' \
    --host-data-dir=$HOME/.oc/profiles/$PROFILE/data \
    --host-config-dir=$HOME/.oc/profiles/$PROFILE/config \
    --use-existing-config
    --insecure-registry 172.30.0.0/16
}

ct_oc_portForward() {
    : ${1?' portToListenOnLocal:portToConnectRemote'}
    $OC port-forward $(_ocGetRunningPOD) $1
}

ct_oc_scaleSet() {
    : ${1?' <quantidade de pods>'}
    local projeto=$($OC project -q)
    echo_and_run $OC scale --replicas=$1 dc --all -n $projeto
}

ct_oc_projectStatus() {
    local projeto=$($OC project -q)
    echo_and_run $OC describe dc/$projeto
}

ct_oc_envList() {
    echo_and_run $OC set env pod/$(_ocGetRunningPOD) --list
}

_oc_project() {
    echo $($OC project -q)
}

ct_oc_envSet() {
    : ${1?' <key=value>'}
    local project=${2:-$(_oc_project)}
    echo_and_run $OC set env dc $project $1 -n $project
}

# Copia o template para a pasta local
# GITHOSTPRD deve ser setado no .bashrc
ct_openshiftMakeSkelByTemplate() {
    local TEMPLATEDIR="/tmp/template_eap_6.4"
    rm -fr $TEMPLATEDIR
    cd /tmp
    git clone --dissociate --depth 1 git@$GITHOSTPRD:template/template_eap_6.4.git
    rm -fr $TEMPLATEDIR/.git
    
    cp -arv $TEMPLATEDIR/* .
    cp -av $TEMPLATEDIR/.gitignore .
}


ct_oc_get_imagehash() {
    local buildName=$1
    echo_and_run $OC describe build $buildName | grep Digest
}

ct_oc_noproxy() {
    export HTTP_PROXY=
    export HTTPS_PROXY=
}