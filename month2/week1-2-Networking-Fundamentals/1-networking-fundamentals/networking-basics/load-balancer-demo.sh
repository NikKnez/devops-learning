#!/bin/bash
# Simple load balancer simulation

echo "=========================================="
echo "Load Balancer Algorithm Demo"
echo "=========================================="
echo ""

# Simulated servers
SERVERS=("Server-1" "Server-2" "Server-3")
WEIGHTS=(3 1 1)  # Server-1 is 3x more powerful

# Round Robin
echo "1. Round Robin Algorithm:"
echo "   Distributes requests evenly"
echo ""
for i in {1..9}; do
    server_idx=$((($i - 1) % ${#SERVERS[@]}))
    echo "   Request $i → ${SERVERS[$server_idx]}"
done
echo ""

# Weighted Round Robin
echo "2. Weighted Round Robin:"
echo "   Server-1 weight: 3, Others weight: 1"
echo ""
counter=1
for weight_idx in {0..2}; do
    weight=${WEIGHTS[$weight_idx]}
    for ((w=0; w<$weight; w++)); do
        echo "   Request $counter → ${SERVERS[$weight_idx]}"
        ((counter++))
        if [ $counter -gt 9 ]; then break 2; fi
    done
done
echo ""

# Least Connections (simulated)
echo "3. Least Connections:"
echo "   Routes to server with fewest connections"
echo ""
declare -A connections
connections[Server-1]=2
connections[Server-2]=5
connections[Server-3]=1

for server in "${SERVERS[@]}"; do
    echo "   ${server}: ${connections[$server]} active connections"
done
echo ""
echo "   New request → Server-3 (least connections)"
echo ""

# IP Hash (simulated)
echo "4. IP Hash Algorithm:"
echo "   Same client IP always goes to same server"
echo ""
CLIENT_IPS=("192.168.1.10" "192.168.1.20" "192.168.1.30" "192.168.1.10")
for ip in "${CLIENT_IPS[@]}"; do
    # Simple hash: sum of IP octets modulo server count
    hash=$(echo $ip | tr '.' '+' | bc)
    server_idx=$(($hash % ${#SERVERS[@]}))
    echo "   Client $ip → ${SERVERS[$server_idx]}"
done
echo ""

echo "=========================================="
