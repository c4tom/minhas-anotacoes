

[[ -f /usr/bin/sqlite3 ]] || { return ; }

ct_sqlite_check_integrity() {
	local DATABASE_FILE="$1"
	sqlite3 $DATABASE_FILE "PRAGMA integrity_check"
}
