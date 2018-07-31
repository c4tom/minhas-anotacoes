#Firejail

https://firejail.wordpress.com/2017/05/15/linux-mint-sandboxing-guide/
https://github.com/netblue30/firejail

Sandboxe para linux

`apt-get install firejail`

Sintaxe:
`firejail <programa>`

exemplo:
```sh

firejail --debug --private --blacklist=/win  firefox

```

