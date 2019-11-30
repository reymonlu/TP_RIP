## Commandes :
rtquery -n -> Interroger la base RIP
netstat -rnf -> Afficher les routes
netstat -rnf -inet6 -> Afficher les routes IPV6
# Switch
configure
vlan 2
tagged 1,2
vlan 3
tagged 2,3
vlan 4
tagged 3,4

# PC 1
ifconfig bge0 -vlanhwtag
ifconfig bge0.2 create
ifconfig bge0.2 192.168.2.1 netmask 255.255.255.0
routed -Pripv2 -Pno_rdisc -i -q
########## IP V6 ###########
ifconfig bge0.2 inet6 -nud
ifconfig bge0.2 inet6 -ifdisabled up
ifconfig bge0.2 inet6 add 2001:db8::1/32

# PC 2
ifconfig bge0 -vlanhwtag
sysctl net.inet.ip.forwarding=1
ifconfig bge0.2 create
ifconfig bge0.2 192.168.2.2 netmask 255.255.255.0
ifconfig bge0.3 create
ifconfig bge0.3 192.168.3.2 netmask 255.255.255.0
routed -Pripv2 -Pno_rdisc -i -s
####### IPV6 ########
sysctl net.inet6.ip6.forwarding=1
ifconfig bge0.2 inet6 -nud
ifconfig bge0.2 inet6 -ifdisabled up
ifconfig bge0.2 inet6 add 2001:db8::2/32
####### TUNNELING ########
ifconfig gif0 create
ifconfig gif0 tunnel 192.168.3.2 192.168.4.4
ifconfig gif0 inet6 2001:db8::3/32
route  add -host -inet6 2001:db8::12 dev gif0
ifconfig gif0 up

# PC 3
ifconfig bge0 -vlanhwtag
sysctl net.inet.ip.forwarding=1
ifconfig bge0.3 create
ifconfig bge0.3 192.168.3.3 netmask 255.255.255.0
ifconfig bge0.4 create
ifconfig bge0.4 192.168.4.3 netmask 255.255.255.0
routed -Pripv2 -Pno_rdisc -i -s

# PC 4
ifconfig bge0 -vlanhwtag
ifconfig bge0.4 create
ifconfig bge0.4 192.168.4.4 netmask 255.255.255.0
routed -Pripv2 -Pno_rdisc -i -q


####### TUNNELING ########
ifconfig gif0 create
ifconfig gif0 tunnel 192.168.4.4 192.168.3.2
ifconfig gif0 inet6 2001:db8::12/32
#route -n add -inet6 default 2001:db8::3/32
ifconfig gif0 up
