[[ `isWin` == "1" ]] || { return ; }

[[ ! -f $(type -P openssl) ]] || { 

   ct_imap_test_ssl() {
      : ${1?: '<imap servername>'}
      : ${2?: '<email>'}
      : ${3:-'993'}

      password=$(askToPassword "Digite a senha do email ($2): ")

      openssl s_client -connect $1:993 -quiet <<EOF
a1 LOGIN $2 $password
a2 LIST "" "*"
a3 LOGOUT
EOF
   }

}


[[ ! -f $(type -P telnet) ]] || { 

   ct_imap_test() {
      : ${1?: '<imap servername>'}
      : ${2?: '<email>'}
      : ${3:-'993'}

      password=$(askToPassword "Digite a senha do email ($2): ")

      telnet $1 imap <<EOF
a1 LOGIN $2 $password
a2 LIST "" "*"
a3 LOGOUT
EOF

   }
}
