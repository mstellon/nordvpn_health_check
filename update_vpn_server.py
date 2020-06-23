#!/usr/bin/python

import json
import os
import random
from string import Template

config_pth = '/config/nordvpn'

with open('servers.json','r') as f:
	servers = json.load(f)
server = random.choice(servers)

with open(os.path.join(config_pth,'nordvpn.ovpn'),'r') as f:
    s = Template(f.read())

with open(os.path.join(config_pth,'norvpn_active.ovpn'),'w') as f:
    f.write(s.substitute(dict(ip=server['station'])))

print("Config updated")