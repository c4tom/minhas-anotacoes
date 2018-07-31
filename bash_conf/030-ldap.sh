[[ -f /usr/bin/ldapsearch ]] || { return ; }

# Obtem informação de um determinado usuário da rede
# Obs: as duas variaveis abaixo deve estar setado
# LDAP_USER="?"
# LDAP_DOMAIN="?"
# LDAP_IP=""
ct_ldapGetInfoUser() {
	ldapsearch -x -W -b DC=$LDAP_DOMAIN,DC=nt -D $LDAP_DOMAIN\\$LDAP_USER -h $LDAP_IP uid=$1
}

ct_ldapGetUserOfGroup() {
	ldapsearch -x -W -b DC=$LDAP_DOMAIN,DC=nt -D $LDAP_DOMAIN\\$LDAP_USER -h $LDAP_IP uid=$1 search="(&(objectClass=user)(memberOf='$2'))" attrs=sAMAccountName
}