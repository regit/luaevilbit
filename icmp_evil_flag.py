#! /usr/bin/env python
# Written by Guillaume Prigent <greetz@guillaume.prigent@diateam.net>


#>>> x = IP(flags=(0,7))
#>>> [k for k in x]
#[<IP  flags= |>, <IP  flags=MF |>, <IP  flags=DF |>, <IP  flags=MF+DF |>, <IP  flags=evil |>, <IP  flags=MF+evil |>, <IP  flags=DF+evil |>, <IP  flags=MF+DF+evil |>]

import sys
from scapy.all import *

ip_packet = IP(flags="evil", dst=sys.argv[1])/ICMP()
send(ip_packet)

