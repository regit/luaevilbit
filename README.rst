=================================================
An Evil bit implementation in luajit for Suricata
=================================================

What's is this
==============

This is an implementation of RFC 3514 for Suricata written by
`Guillaume Prigent <http://www.diateam.net/>`_ and available in public
domain.

Description
===========

The `RFC 3514 <http://www.ietf.org/rfc/rfc3514.txt>`_ has been published 1 April 2003 and
define a security flag in the IPv4 header as a means of distinguishing good packets
from evil packets.

Implementation details are provided for IDS ::

 Because of their known propensity for false negatives and
 false positives, IDSs MUST apply a probabilistic correction
 factor when evaluating the evil bit.

To implement this in Suricata, we need to have access to random number. This is not
provided by classic rules, so a good way to do so is to create a luajit signature.

Testing
=======

To be able to use luajit signatures, you need to use at least suricata 1.4-beta2. And you
must build it with luajit enabled. For that you need to have luajit on your system.
On debian and ubuntu, you can install libluajit-5.1-dev ::

 sudo aptitude install libluajit-5.1-dev

Once this is done, you can build Suricata ::

 $ ./configure --enable-luajit
 $ make
 $ make install
 $ make install-full # install configuration and download rules

You can then run ::

 $ sudo suricata -i eth0 -S evilflag.rules

In another terminal #1 ::

  $ sudo tail -F /usr/local/var/log/suricata/fast.log 

In another terminal #2 (replace ip address 192.168.10.230 by what you want) ::
  
  $ sudo icmp_evil_flag.py 192.168.10.230

In the terminal #1 here you see ::

  10/20/2012-18:39:44.820424  [**] [1:2:0] LUAJIT Evil Flag [**] [Classification: (null)] [Priority: 3] {ICMP} 0.0.0.0:8 -> 192.168.10.230:0



