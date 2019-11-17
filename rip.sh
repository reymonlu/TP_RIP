# Switch
configure
vlan 2
tagged 1,2
vlan 3
tagged 2,3
# Dans une seconde partie
vlan 4
tagged 3,4
# Dans une troisième partie
vlan 5
tagged 1,4


# PC1 Port 1
ifconfig bge0 -vlanhwtag


ifconfig bge0.2 create
ifconfig bge0.2 192.168.20.1 netmask 255.255.255.0 broadcast 192.168.20.255
routed -Pripv2 -Pno_rdisc -d -i -q

# A faire dans une troisième partie
ifconfig bge0.5 create
ifconfig bge0.5 192.168.50.1 netmask 255.255.255.0 broadcast 192.168.50.255


# PC2 Port 2
ifconfig bge0 -vlanhwtag
sysctl net.inet.ip.forwarding=1

ifconfig bge0.2 create
ifconfig bge0.3 create

ifconfig bge0.2 192.168.20.2 netmask 255.255.255.0 broadcast 192.168.20.255
ifconfig bge0.3 192.168.30.2 netmask 255.255.255.0 broadcast 192.168.20.255


routed -Pripv2 -Pno_rdisc -d -i -s

# PC3 Port 3
ifconfig bge0 -vlanhwtag


ifconfig bge0.3 create
ifconfig bge0.3 192.168.30.3 netmask 255.255.255.0 broadcast 192.168.30.255

routed -Pripv2 -Pno_rdisc -d -i -q


# A faire dans une seconde partie
ifconfig bge0.4 create
ifconfig bge0.4 192.168.40.3 netmask 255.255.255.0 broadcast 192.168.40.255



# PC4 Port 4
ifconfig bge0 -vlanhwtag
ifconfig bge0 192.168.0.4 netmask 255.255.255.0 broadcast 192.168.0.255


# A faire dans une seconde partie
ifconfig bge0.4 create
ifconfig bge0.4 192.168.40.4 netmask 255.255.255.0 broadcast 192.168.40.255
routed -Pripv2 -Pno_rdisc -d -i -q

# A faire dans la troisième partie


ifconfig bge0.5 create
ifconfig bge0.5 192.168.50.4 netmask 255.255.255.0 broadcast 192.168.50.255
