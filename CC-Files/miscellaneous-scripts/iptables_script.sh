#!/bin/bash
# Author: David, assistance from https://javapipe.com/blog/iptables-ddos-protection/
# Block all packets that are not a syn and don't belong on an established TCP connection
iptables -t mangle -A PREROUTING -p tcp --dport 80 -m conntrack --ctstate INVALID -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 443 -m conntrack --ctstate INVALID -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 80 -m conntrack --ctstate INVALID -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 443 -m conntrack --ctstate INVALID -j DROP

# Does a similar action, but catches some other packets the previous doesn't
iptables -t mangle -A PREROUTING -p tcp --dport 80 ! --syn -m conntrack --ctstate NEW -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 443 ! --syn -m conntrack --ctstate NEW -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 80 ! --syn -m conntrack --ctstate NEW -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 443 ! --syn -m conntrack --ctstate NEW -j DROP

# Blocks TCP with uncommon maximum memory size
iptables -t mangle -A PREROUTING -p tcp --dport 80 -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 443 -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 80 -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 443 -m conntrack --ctstate NEW -m tcpmss ! --mss 536:65535 -j DROP

# Blocks all bogus TCP flag configurations
iptables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags FIN,SYN FIN,SYN -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags FIN,SYN FIN,SYN -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags SYN,RST SYN,RST -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags SYN,RST SYN,RST -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags FIN,RST FIN,RST -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags FIN,RST FIN,RST -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags FIN,ACK FIN -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags FIN,ACK FIN -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags ACK,URG URG -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags ACK,URG URG -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags ACK,PSH PSH -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags ACK,PSH PSH -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags ALL NONE -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags ALL NONE -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags FIN,SYN FIN,SYN -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags FIN,SYN FIN,SYN -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags SYN,RST SYN,RST -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags SYN,RST SYN,RST -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags FIN,RST FIN,RST -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags FIN,RST FIN,RST -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags FIN,ACK FIN -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags FIN,ACK FIN -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags ACK,URG URG -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags ACK,URG URG -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags ACK,PSH PSH -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags ACK,PSH PSH -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 80 --tcp-flags ALL NONE -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 443 --tcp-flags ALL NONE -j DROP


# Blocks packets from private subnets, likely spoofed packets
iptables -t mangle -A PREROUTING -s 224.0.0.0/3 -p tcp --dport 80 -j DROP
iptables -t mangle -A PREROUTING -s 224.0.0.0/3 -p tcp --dport 443 -j DROP
iptables -t mangle -A PREROUTING -s 169.254.0.0/16 -p tcp --dport 80 -j DROP
iptables -t mangle -A PREROUTING -s 169.254.0.0/16 -p tcp --dport 443 -j DROP
iptables -t mangle -A PREROUTING -s 172.16.0.0/12 -p tcp --dport 80 -j DROP
iptables -t mangle -A PREROUTING -s 172.16.0.0/12 -p tcp --dport 443 -j DROP
iptables -t mangle -A PREROUTING -s 192.0.2.0/24 -p tcp --dport 80 -j DROP
iptables -t mangle -A PREROUTING -s 192.0.2.0/24 -p tcp --dport 443 -j DROP
iptables -t mangle -A PREROUTING -s 192.168.0.0/16 -p tcp --dport 80 -j DROP
iptables -t mangle -A PREROUTING -s 192.168.0.0/16 -p tcp --dport 443 -j DROP
iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -p tcp --dport 80 -j DROP
iptables -t mangle -A PREROUTING -s 10.0.0.0/8 -p tcp --dport 443 -j DROP
iptables -t mangle -A PREROUTING -s 0.0.0.0/8 -p tcp --dport 80 -j DROP
iptables -t mangle -A PREROUTING -s 0.0.0.0/8 -p tcp --dport 443 -j DROP
iptables -t mangle -A PREROUTING -s 240.0.0.0/5 -p tcp --dport 80 -j DROP
iptables -t mangle -A PREROUTING -s 240.0.0.0/5 -p tcp --dport 443 -j DROP
iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -p tcp --dport 80 -j DROP
iptables -t mangle -A PREROUTING -s 127.0.0.0/8 ! -i lo -p tcp --dport 443 -j DROP
ip6tables -t mangle -A PREROUTING -s fe80::/10 -p tcp --dport 80 -j DROP
ip6tables -t mangle -A PREROUTING -s fe80::/10 -p tcp --dport 443 -j DROP
ip6tables -t mangle -A PREROUTING -s fc00::/7 -p tcp --dport 80 -j DROP
ip6tables -t mangle -A PREROUTING -s fc00::/7 -p tcp --dport 443 -j DROP

# Blocks all icmp packets
iptables -t mangle -A PREROUTING -p icmp -j DROP
ip6tables -t mangle -A PREROUTING -p icmpv6 -j DROP

# Rejects connections from hosts with more than 80 established connections
iptables -A INPUT -p tcp -m connlimit --connlimit-above 80 --dport 80 -j REJECT --reject-with tcp-reset
iptables -A INPUT -p tcp -m connlimit --connlimit-above 80 --dport 443 -j REJECT --reject-with tcp-reset
ip6tables -A INPUT -p tcp -m connlimit --connlimit-above 80 --dport 80 -j REJECT --reject-with tcp-reset
ip6tables -A INPUT -p tcp -m connlimit --connlimit-above 80 --dport 443 -j REJECT --reject-with tcp-reset

# Limits new TCP connections a client can establish
iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT
iptables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW -j DROP
iptables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW -j DROP
ip6tables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW -m limit --limit 60/s --limit-burst 20 -j ACCEPT
ip6tables -A INPUT -p tcp --dport 80 -m conntrack --ctstate NEW -j DROP
ip6tables -A INPUT -p tcp --dport 443 -m conntrack --ctstate NEW -j DROP

# Blocks fragmented packets
iptables -t mangle -A PREROUTING -p tcp --dport 80 -f -j DROP
iptables -t mangle -A PREROUTING -p tcp --dport 443 -f -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 80 -m frag --fragfirst -j DROP
ip6tables -t mangle -A PREROUTING -p tcp --dport 443 -m frag --fragfirst -j DROP
