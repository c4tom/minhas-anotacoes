# Comando Úteis


## Usuários / Grupos
- Adicionar Grupo
`addgroup <grupo>`
- adicionar usuário para grupo
`useradd -g <grupo> <usuario>`

## Route

- Mostrar rotas
```bash
# ip route show
default via 10.224.96.1 dev enp9s0  proto static  metric 100 
default via 192.168.42.129 dev enp0s29u1u2  proto static  metric 101 
10.4.3.142 via 10.224.96.1 dev enp9s0  proto dhcp  metric 100 
10.224.96.0/20 dev enp9s0  proto kernel  scope link  src 10.224.97.236  metric 100 
169.254.0.0/16 dev enp9s0  scope link  metric 1000 
172.17.0.0/16 dev docker0  proto kernel  scope link  src 172.17.0.1 
192.168.42.0/24 dev enp0s29u1u2  proto kernel  scope link  src 192.168.42.62  metric 100


route -n
Tabela de Roteamento IP do Kernel
Destino         Roteador        MáscaraGen.    Opções Métrica Ref   Uso Iface
0.0.0.0         10.224.96.1     0.0.0.0         UG    100    0        0 enp9s0
0.0.0.0         192.168.42.129  0.0.0.0         UG    101    0        0 enp0s29u1u2
10.4.3.142      10.224.96.1     255.255.255.255 UGH   100    0        0 enp9s0
10.224.96.0     0.0.0.0         255.255.240.0   U     100    0        0 enp9s0
169.254.0.0     0.0.0.0         255.255.0.0     U     1000   0        0 enp9s0
172.17.0.0      0.0.0.0         255.255.0.0     U     0      0        0 docker0
192.168.42.0    0.0.0.0         255.255.255.0   U     100    0        0 enp0s29u1u2

```

## Rota persistente em Debian / Ubuntu Linux
```bash
# editar : /etc/network/interfaces

auto lo
iface lo inet loopback

auto eth0
iface eth0 inet static
        address 10.9.38.76
        netmask 255.255.255.240
        network 10.9.38.64
        broadcast 10.9.38.79
	     ### static routing ###
        post-up route add -net 10.0.0.0 netmask 255.0.0.0 gw 10.9.38.65
        pre-down route del -net 10.0.0.0 netmask 255.0.0.0 gw 10.9.38.65

auto eth1
iface eth1 inet static
        address 204.186.149.140
        netmask 255.255.255.240
        network 204.186.149.128
        broadcast 204.186.149.143
        gateway 204.186.149.129
        # dns-* options are implemented by the resolvconf package, if installed
        dns-nameservers 10.0.80.11 10.0.80.12
        dns-search meudominio.nt

```


```bash

ip route del default
ip route add 
```

## Highligth
Saida colorida, como fazer
https://asciinema.org/a/108469