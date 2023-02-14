
[[ -f $(type -P ssh) ]] || { return; }

alias ssh-viapassword="ssh -o PreferredAuthentications=password"

ct_ssh_keygenComEmail() {
    local email=$1
    ssh-keygen -o -a 100 -t ed25519 -C "$email"
}

ct_ssh_keygenRSAComEmail() {
    local email=$1
    ssh-keygen -o -b 4096 -t rsa -C "$email"
}

ct_ssh_agentIsRunning() {
    echo_and_run ssh-agent -s
}

# conecta com o remoto, e ouve uma porta como socks
ct_ssh_socksEnable() {
    ${1?' <host to connect>'}
    local port=${2:-"1080"};
    cmd="ssh -f -C -q -N -D $port $1 "
    echo_and_run $cmd
}

## https://www.ssh.com/academy/ssh/tunneling/example
ct_ssh_forward_local_port() {
    # ssh -L 80:intra.example.com:80 gw.example.com
    # This example opens a connection to the gw.example.com jump server, and forwards any connection to port 80 on the local 
    # machine to port 80 on intra.example.com.

    ${1?' <ip/host to connect>'}
    ${2?' <80:intra.example.com:80>'}

    ssh 
}


ct_ssh_forward_remote_port() {
    # ssh -R 30022:localhost:22 <ip/host>

    ${1?' <ip/host to connect>'}
    ${2:-"30022:localhost:22"};
    ssh -R $2 $1
}

# https://www.tecmint.com/restrict-ssh-user-to-directory-using-chrooted-jail/
# Test on docker
# apt update -y; apt install -y ssh
ct_ssh_create_userAndJailHomeDir() {
    : ${1?: '<username>'}
    
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


    local JAIL_USER=$1
    local JAIL_USER_PW=$(__askToPassword "Digite a senha para o usuario ($JAIL_USER): ") 
    local JAIL_HOME=/home/jail
    local JAIL_DEV=${JAIL_HOME}/dev
    local JAIL_BIN=${JAIL_HOME}/bin
    local JAIL_ETC=${JAIL_HOME}/etc
    local JAIL_LIB64=${JAIL_HOME}/lib64
    local JAIL_HOME_DIR=${JAIL_HOME}/home/${JAIL_USER}


    echo "Create Home"
    mkdir -p $JAIL_HOME

    echo "Create DEVs"
    mkdir -p $JAIL_DEV
    cd $JAIL_DEV

    mknod -m 666 null c 1 3
    mknod -m 666 tty c 5 0
    mknod -m 666 zero c 1 5
    mknod -m 666 random c 1 8

    ls -la 

    chown root:root $JAIL_HOME
    chmod 0755 $JAIL_HOME

    echo "Create BIN $JAIL_BIN and copy files"

    mkdir -p $JAIL_BIN
    cp -v /bin/bash $JAIL_BIN
    cp -v /bin/sh $JAIL_BIN
    cp -v /bin/ls $JAIL_BIN

    echo "Copying LIBs"
    mkdir -p $JAIL_LIB64

    ldd /bin/bash | awk 'NF == 4 { system("echo cp -v " $3 " '$JAIL_LIB64'") }' > /tmp/cpscript.sh
    ldd /bin/ls | awk 'NF == 4 { system("echo cp -v ls " $3 " '$JAIL_LIB64'") }' >> /tmp/cpscript.sh
    

    sh /tmp/cpscript.sh
    cp -v /lib64/ld-linux-x86-64.so.2 $JAIL_LIB64
    cp -va /lib/x86_64-linux-gnu/libnss_files* $JAIL_LIB64

    echo "Adding user $JAIL_USER"
    useradd -s /bin/bash $JAIL_USER
    usermod --password $JAIL_USER_PW $JAIL_USER

    mkdir -p $JAIL_HOME_DIR
    chown -R $JAIL_USER:$JAIL_USER $JAIL_HOME_DIR
    chmod -R 0700 $JAIL_HOME_DIR


    echo "Create ETC $JAIL_ETC"
    mkdir -p $JAIL_ETC

    # Note: Each time you add more SSH users to the system, you will need to copy the updated account files into
    cp -vf /etc/{passwd,group} $JAIL_ETC

    echo "Configure SSH to Use Chroot Jail"

    echo "#define username to apply chroot jail to
Match User $JAIL_USER
   ChrootDirectory $JAIL_HOME" >> /etc/ssh/sshd_config

}
