# Tinc VPN
https://www.digitalocean.com/community/tutorials/how-to-install-tinc-and-set-up-a-basic-vpn-on-ubuntu-14-04


**Modo Debug no servidor**
sudo tincd -n netname -D -d3


```bash
# Criar uma configuracao no cliente
tincClientSetup claros dockerCliente 10.0.0.100 server
tincMakeConf claros dockerCliente server claros
tincServerHostClient claros dockerCliente 10.0.0.100 clarosoffice.no-ip.biz


```