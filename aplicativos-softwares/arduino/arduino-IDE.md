


# Preparando ambiente Linux (ubuntu)

Acesse https://github.com/juliagoda/CH341SER

```sh

# https://unix.stackexchange.com/questions/670636/unable-to-use-usb-dongle-based-on-usb-serial-converter-chip

sudo systemctl mask brltty.path
sudo systemctl stop brltty.path
sudo systemctl mask system-brltty\x2ddevice.slice
sudo systemctl stop system-brltty\x2ddevice.slice
sudo systemctl mask system-brltty.slice
sudo systemctl stop system-brltty.slice
sudo systemctl mask brltty@-etc-brltty.conf.service
sudo systemctl stop brltty@-etc-brltty.conf.service


```
