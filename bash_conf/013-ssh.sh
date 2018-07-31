ssh-keygen-com-email() {
    local email=$1
    ssh-keygen -t rsa -b 4096 -C "$email"
}