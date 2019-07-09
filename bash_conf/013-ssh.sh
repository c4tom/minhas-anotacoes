ct_sshKeygenComEmail() {
    local email=$1
    ssh-keygen -t rsa -b 4096 -C "$email"
}