

Para abrir uma porta externa:

```bash

sudo apt install firewalld
sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
sudo firewall-cmd --reload

```
para testar usar o php php -S 0.0.0.0:80 -t /tmp
