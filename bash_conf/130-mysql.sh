

ct_mysql_add_MySqlUserOnLinux() {
	local ID=$1
	sudo groupadd -g $ID mysql
	sudo useradd -u $ID mysql -M -g mysql
}



ct_mysql_adm_AddUserOnlyDataAccess() {
	local MY_USER=$1
	local MY_HOST=$2
	local MY_PASS=$3
	echo "CREATE USER '$MY_USER'@'$MY_HOST' IDENTIFIED VIA mysql_native_password USING '$MY_PASS';GRANT SELECT, INSERT, UPDATE, DELETE, FILE ON *.* TO 'adver523_afcombr'@'localhost' REQUIRE NONE WITH MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;"
}

ct_mysql_adm_addUserAllDataAccess() {
	HELPTXT="

${FUNCNAME[0]} <user> <host> <pass>"
	ct_help $1

	: ${1?' user'}
	: ${2?' host'}
	: ${3?' pass'}

	local MY_USER=$1
	local MY_HOST=$2
	local MY_PASS=$3
	echo "CREATE USER '$MY_USER'@'$MY_HOST' IDENTIFIED VIA mysql_native_password USING '$MY_PASS';GRANT ALL PRIVILEGES ON *.* TO '$MY_USER'@'$MY_HOST' REQUIRE NONE WITH GRANT OPTION MAX_QUERIES_PER_HOUR 0 MAX_CONNECTIONS_PER_HOUR 0 MAX_UPDATES_PER_HOUR 0 MAX_USER_CONNECTIONS 0;GRANT ALL PRIVILEGES ON `$MY_USER\_$MY_HOST`.* TO '$MY_USER'@'$MY_HOST';"
}


ct_mysql_adm_addUserWithoutPermission() {
	local user=${1:-"root"};
    local passwd=${2:-"password"};
    local host=${4:-"localhost"};

	echo "CREATE USER '${user}'@'${host}' IDENTIFIED BY '${passwd}';"
}

# adicionar usuario com permissao para monitorar apenas
ct_mysql_monitor_addUser() {
	local user=${1:-"monitor"};
    local passwd=${2:-"password"};
    local host=${4:-"localhost"};
	echo "GRANT SELECT, REPLICATION CLIENT, SHOW DATABASES, SUPER, PROCESS ON *.* TO  '${user}'@'${host}' IDENTIFIED BY '${passwd}'";
}


# Data Control Language ( DCL )

# Data Definition Language ( DDL)
_ct_mysql_DB_DDL() {
	echo "ALTER, ALTER ROUTINE, CREATE, CREATE ROUTINE, CREATE TEMPORARY TABLES, CREATE VIEW "
}
# Data Manipulation Language ( DML)
_ct_mysql_DB_DML() {
	echo "SELECT INSERT, UPDATE, DELETE, LOCK TABLES"
}

_ct_mysql_DB_ALL() {
	echo "DROP, EVENT, EXECUTE, INDEX, REFERENCES, SHOW VIEW, TRIGGER, $(_ct_mysql_DB_DML), $(_ct_mysql_DB_DDL)"
}


__ct_mysql_RevokeLocal() {
	__ct_mysql_revoke "$@" 	
}

ct_mysql_adm_removePermsOnSpecificDataBase() { 
	__ct_mysql_RevokeLocal $@
}


### GLOBAL 
# Data Control Language ( DCL )

# Data Definition Language ( DDL)
_ct_mysql_GLOBAL_DDL() {
	echo "ALTER, ALTER ROUTINE, CREATE, CREATE ROUTINE, CREATE TEMPORARY TABLES, CREATE VIEW, CREATE TABLESPACE, CREATE TEMPORARY TABLES, CREATE USER, DROP"
}
# Data Manipulation Language ( DML)
_ct_mysql_GLOBAL_DML() {
	echo "SELECT INSERT, UPDATE, DELETE, LOCK TABLES"
}

_ct_mysql_GLOBAL_ALL() {
	# Pode usar ALL
	echo "EVENT, EXECUTE, FILE, INDEX, PROCESS, REFERENCES, RELOAD, REPLICATION CLIENT, REPLICATION SLAVE, SHOW DATABASES, SHOW VIEW, SHUTDOWN, SUPER, TRIGGER, $(_ct_mysql_GLOBAL_DDL), $(_ct_mysql_GLOBAL_DML)"
}

ct_mysql_adm_grantPermsGlobal() {
	__ct_mysql_grant "$1" "$2" "$3" "${4:-"$(_ct_mysql_GLOBAL_ALL)"}"
}

ct_mysql_adm_revokePermsGlobal() {
	__ct_mysql_revoke "$@"	
}


## DELETE USER
ct_mysql_drop_User() {
	local user=: ${1?" <user>"}
    local host=${2:-"localhost"};

	echo "DROP USER '${user}'@'${host}'; FLUSH PRIVILEGES;"
}

## 
ct_mysql_limites() {
	: ${1?" <user>"}
	: ${2?" <database>"}
	: ${3?' <hostname>'}
	__ct_mysql_usage "$@"
}



## Reset ROOT Password
ct_mysql_rect_mysql_reset_rootPasswordset_rootPassword() {
	echo "1. Stop mysql server";
	echo "2. Run: sudo mysqld_safe --skip-grant-tables &"
	echo "3. Execute: USE mysql; UPDATE user SET authentication_string=PASSWORD('password_here') WHERE User='root'; FLUSH PRIVILEGES;";
}




## lib
__ct_mysql_grant() {
	local user=${1:-"root"};
    local db=${2:-"*"};
    local host=${3:-"localhost"};
	local perms=${4:-"$(_ct_mysql_GLOBAL_ALL)"}

	echo "GRANT ${perms} ON \`${db}\`.* TO '${user}'@'${host}' WITH GRANT OPTION;"
}

__ct_mysql_revoke() {
	local user=${1:-"root"};
    local db=${2:-"*"};
    local host=${3:-"localhost"};
	local perms=${4:-"$(_ct_mysql_GLOBAL_ALL)"}

	echo "REVOKE ${perms} ON \`${db}\`.* FROM '${user}'@'${host}'; REVOKE GRANT OPTION ON \`${db}\`.* FROM '${user}'@'${host}';"; 	
}

__ct_mysql_usage() {
	local user=${1:-"root"};
    local db=${2:-"*"};
	local host=${3:-"localhost"};
    local QUERIES_PER_HOUR=${4:-"0"};
	local UPDATES_PER_HOUR=${5:-"0"}
	local CONNECTIONS_PER_HOUR=${6:-"0"};
	local USER_CONNECTIONS=${7:-"0"};

	echo "GRANT USAGE ON \`${db}\`.* TO '${user}'@'${host}' WITH MAX_QUERIES_PER_HOUR ${QUERIES_PER_HOUR} MAX_UPDATES_PER_HOUR ${UPDATES_PER_HOUR} MAX_CONNECTIONS_PER_HOUR ${CONNECTIONS_PER_HOUR} MAX_USER_CONNECTIONS ${USER_CONNECTIONS};"
}
