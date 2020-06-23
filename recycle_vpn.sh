#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
configure
set interfaces openvpn vtun0 disable
commit
delete interfaces openvpn vtun0 disable
commit
exit
