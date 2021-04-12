ct_ssh_keygenComEmail() {
    local email=$1
    ssh-keygen -t rsa -b 4096 -C "$email"
}

# conecta com o remoto, e ouve uma porta como socks
ct_ssh_socksEnable() {
    ${1?' <host to connect>'}
    local port=${2:-"1080"};
    echo_and_run ssh $1 -D $port -f -C -q -N 
}

ct_ssh_forward_port() {
    ssh 
}