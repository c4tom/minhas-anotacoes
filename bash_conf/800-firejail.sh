[[ `isWin` == "1" ]] || { return ; }

# https://firejail.wordpress.com/

# apt-get install firejail firetools

# Veja:
# https://github.com/pigmonkey/firewarden/blob/master/firewarden

[[ -f /usr/bin/firejail ]] || { return ; }

ct_firejail_status() {
    /usr/lib/firetools/fstats
}