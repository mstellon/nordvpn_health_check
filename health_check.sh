#!/bin/sh

pingIP=8.8.8.8
/bin/ping -I eth0 -c4 $pingIP
wanPing=$?

/bin/ping -I vtun0 -c 4 $pingIP
vpnPing=$?

if [[ $wanPing -eq 0 && $vpnPing -gt 0 ]]; then
echo "Bad ping"
curl -g -o servers.json 'https://nordvpn.com/wp-admin/admin-ajax.php?action=servers_recommendations&filters="servers_technologies":[3]'
./update_vpn_server.py
./recycle_vpn.sh
else
echo "Good Ping"
fi
