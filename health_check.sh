#!/bin/sh

pingIP=8.8.8.8

rootDir=$(dirname $(realpath $0))

logFile=$rootDir/vpn_health.log
exec 1>$logFile 2>&1

echo "Starting script at $(date)"

/bin/ping -I eth0 -c4 $pingIP
wanPing=$?

/bin/ping -I vtun0 -c 4 $pingIP
vpnPing=$?

if [[ $wanPing -eq 0 && $vpnPing -gt 0 ]]; then
echo "Bad ping"
curl -g -o $rootDir/servers.json 'https://nordvpn.com/wp-admin/admin-ajax.php?action=servers_recommendations&filters="servers_technologies":[3]'
$rootDir/update_vpn_server.py
$rootDir/recycle_vpn.sh
else
echo "Good Ping"
fi

echo "Script complete"
