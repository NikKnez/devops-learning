#!/bin/bash
# Check open ports and listening services

echo "==================================="
echo "Port and Service Analysis"
echo "==================================="
echo ""

echo "1. Listening TCP Ports:"
ss -tuln | grep LISTEN | column -t
echo ""

echo "2. Listening UDP Ports:"
ss -tuln | grep -v LISTEN | grep -v "State" | column -t
echo ""

echo "3. Common Services Check:"
services=(
    "22:SSH"
    "80:HTTP"
    "443:HTTPS"
    "3306:MySQL"
    "5432:PostgreSQL"
    "6379:Redis"
    "9090:Prometheus"
    "3000:Grafana"
)

for service in "${services[@]}"; do
    port="${service%%:*}"
    name="${service##*:}"
    if ss -tuln | grep -q ":$port "; then
        echo "[OPEN] Port $port ($name)"
    else
        echo "[CLOSED] Port $port ($name)"
    fi
done
echo ""

echo "4. Established Connections:"
ss -tun | grep ESTAB | wc -l
echo "Total established connections"
echo ""

echo "5. Top 5 Ports in Use:"
ss -tuln | grep -E "LISTEN|ESTAB" | awk '{print $5}' | \
    sed 's/.*://' | sort | uniq -c | sort -rn | head -5
echo ""

echo "==================================="
