[[ `isWin` == "1" ]] || { return ; }

ct_cpanel_add_email_forward() {
    
    if [[ -z $CT_CPANEL_HOST && -z $CT_CPANEL_USER && -z $CT_CPANEL_TOKEN ]]
    then
        echo "Favor setar variáveis CT_CPANEL_HOST CT_CPANEL_USER CT_CPANEL_TOKEN"
    else
        : ${1?' <email_de>'}
        : ${2?' <dominio>'}
        : ${3?' <email_para>'}
        
        echo_and_run curl --request POST \
        --url "$CT_CPANEL_HOST/execute/Email/add_forwarder?email=$1&domain=$2&fwdopt=fwd&fwdemail=$3" \
        --header "Authorization: cpanel $CT_CPANEL_USER:$CT_CPANEL_TOKEN"
        
    fi
}

ct_cpanel_add_email_forward_bulk() {
    : ${1?' <email_de>'}
    : ${2?' <dominio>'}
    : ${3?' <email_para, separado por espacos. Ex.: "fulano beltrano ciclano">'}

   for i in $3
   do
      echo $i
      ct_cpanel_add_email_forward $1 $2 "$i@$2"
   done
}