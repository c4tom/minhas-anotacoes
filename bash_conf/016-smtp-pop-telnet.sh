

   ct_imap_test_ssl() {
      : ${1?: '<imap servername>'}
      : ${2?: '<email>'}
      : ${3:-'993'}
      echo "Digite a senha do email:"
      read password

      openssl s_client -connect $1:993 -quiet <<EOF
   a1 LOGIN $2 $password
   a2 LIST "" "*"
   a3 LOGOUT
   EOF

   }

ct_imap_test() {
   : ${1?: '<imap servername>'}
   : ${2?: '<email>'}
   : ${3:-'993'}
   echo "Digite a senha do email:"
   read password

   telnet $1 imap <<EOF
a1 LOGIN $2 $password
a2 LIST "" "*"
a3 LOGOUT
EOF

}