rem http://woshub.com/port-forwarding-in-windows/

rem Run this into VM Virtual Machine on Windows 10 Guest, this forward 3389 from VPN network to outside vm box

netsh interface portproxy add v4tov4 listenaddress=10.0.2.15 listenport=3390 connectaddress=10.224.98.17 connectport=3389
netsh advfirewall firewall add rule name=”forwarded_RDPport_3390” protocol=TCP dir=in localip=10.0.2.15 localport=3390 action=allow

rem VNC

netsh interface portproxy add v4tov4 listenaddress=10.0.2.15 listenport=5900 connectaddress=10.59.225.164 connectport=5900
netsh advfirewall firewall add rule name=”forwarded_RDPport_5900” protocol=TCP dir=in localip=10.0.2.15 localport=5900 action=allow