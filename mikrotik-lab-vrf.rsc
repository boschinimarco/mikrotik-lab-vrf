/system identity
set name=RB_1

/ip vrf
add interfaces=ether4 name=vrf4
add interfaces=ether3 name=vrf3
add interfaces=ether2 name=vrf2
add interfaces=ether1 name=vrf1

/ip address
add address=192.168.153.254/24 interface=ether1 network=192.168.153.0
add address=192.168.153.254/24 interface=ether2 network=192.168.153.0
add address=192.168.153.254/24 interface=ether3 network=192.168.153.0
add address=192.168.153.254/24 interface=ether4 network=192.168.153.0
add address=192.168.153.254/24 interface=ether5 network=192.168.153.0
add address=192.168.153.20/24 interface=ether5 network=192.168.153.0
add address=192.168.153.21/24 interface=ether5 network=192.168.153.0
add address=192.168.153.22/24 interface=ether5 network=192.168.153.0
add address=192.168.153.23/24 interface=ether5 network=192.168.153.0

/ip firewall mangle
add action=mark-routing chain=prerouting comment="Se ho pacchetti destinati a \
    192.168.153.20, li marchio e li faccio andare nella tabella di routing vrf\
    1" dst-address=192.168.153.20 new-routing-mark=vrf1 passthrough=no
add action=mark-routing chain=prerouting comment="Se ho pacchetti destinati a \
    192.168.153.21, li marchio e li faccio andare nella tabella di routing vrf\
    2" dst-address=192.168.153.21 new-routing-mark=vrf2 passthrough=no
add action=mark-routing chain=prerouting comment="Se ho pacchetti destinati a \
    192.168.153.22, li marchio e li faccio andare nella tabella di routing vrf\
    3" dst-address=192.168.153.22 new-routing-mark=vrf3 passthrough=no
add action=mark-routing chain=prerouting comment="Se ho pacchetti destinati a \
    192.168.153.23, li marchio e li faccio andare nella tabella di routing vrf\
    4" dst-address=192.168.153.23 new-routing-mark=vrf4 passthrough=no
add action=mark-routing chain=prerouting comment="Se ho pacchetti destinati a \
    192.168.153.61, li marchio e li faccio andare nella tabella di routing mai\
    n" dst-address=192.168.153.61 new-routing-mark=main passthrough=no
	
/ip firewall nat
add action=dst-nat chain=dstnat comment="NAT dell'IP destinatario da 192.168.1\
    53.20 a 192.168.153.1 - ether1 vrf1" dst-address=192.168.153.20 \
    in-interface=ether5 to-addresses=192.168.153.1
add action=dst-nat chain=dstnat comment="NAT dell'IP destinatario da 192.168.1\
    53.21 a 192.168.153.11 - ether2 vrf2" dst-address=192.168.153.21 \
    in-interface=ether5 to-addresses=192.168.153.11
add action=dst-nat chain=dstnat comment="NAT dell'IP destinatario da 192.168.1\
    53.22 a 192.168.153.1 - ether3 vrf3" dst-address=192.168.153.22 \
    in-interface=ether5 to-addresses=192.168.153.1
add action=dst-nat chain=dstnat comment="NAT dell'IP destinatario da 192.168.1\
    53.23 a 192.168.153.11 - ether4 vrf4" dst-address=192.168.153.23 \
    in-interface=ether5 to-addresses=192.168.153.11
add action=src-nat chain=srcnat comment=\
    "NAT dell'IP sorgente da (mittente) a 192.168.153.254 - IP ether1 vrf1" \
    out-interface=ether1 to-addresses=192.168.153.254
add action=src-nat chain=srcnat comment=\
    "NAT dell'IP sorgente da (mittente) a 192.168.153.254 - IP ether2 vrf2" \
    out-interface=ether2 to-addresses=192.168.153.254
add action=src-nat chain=srcnat comment=\
    "NAT dell'IP sorgente da (mittente) a 192.168.153.254 - IP ether3 vrf3" \
    out-interface=ether3 to-addresses=192.168.153.254
add action=src-nat chain=srcnat comment=\
    "NAT dell'IP sorgente da (mittente) a 192.168.153.254 - IP ether4 vrf4" \
    out-interface=ether4 to-addresses=192.168.153.254
	


