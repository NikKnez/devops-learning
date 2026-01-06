#!/bin/bash
# Comprehensive network troubleshooting script

TARGET=${1:-8.8.8.8}
PORT=${2:-80}

echo "=========================================="
echo "Network Troubleshooting for: $TARGET:$PORT"
echo "=========================================="
echo ""

# Check local network configuration
echo "1. Local Network Configuration:"
echo "   IP Address:"
ip addr show | grep "inet " | grep -v 127.0.0.1
echo ""
echo "   Default Gateway:"
ip route | grep default
echo ""

# Check DNS resolution
echo "2. DNS Resolution:"
if host $TARGET > /dev/null 2>&1; then
    echo "   [OK] DNS resolution works"
    host $TARGET
else
    echo "   [FAIL] DNS resolution failed"
    echo "   Trying with 8.8.8.8..."
    dig @8.8.8.8 $TARGET +short
fi
echo ""

# Check basic connectivity
echo "3. ICMP Connectivity (ping):"
if ping -c 3 -W 2 $TARGET > /dev/null 2>&1; then
    echo "   [OK] Host is reachable"
    ping -c 3 $TARGET | tail -2
else
    echo "   [FAIL] Host is not reachable via ping"
    echo "   (Note: Some hosts block ICMP)"
fi
echo ""

# Check route
echo "4. Network Path:"
echo "   Traceroute (first 10 hops):"
traceroute -m 10 -w 2 $TARGET 2>/dev/null | head -11
echo ""

# Check port connectivity
echo "5. Port Connectivity ($PORT):"
if nc -zv -w 2 $TARGET $PORT 2>&1 | grep -q succeeded; then
    echo "   [OK] Port $PORT is open"
else
    echo "   [FAIL] Port $PORT is closed or filtered"
fi
echo ""

# Check local firewall
echo "6. Local Firewall Status:"
if command -v ufw &> /dev/null; then
    sudo ufw status | head -5
elif command -v firewall-cmd &> /dev/null; then
    sudo firewall-cmd --state
else
    echo "   No common firewall tool found"
fi
echo ""

# Summary
echo "=========================================="
echo "Troubleshooting Summary:"
echo "=========================================="
echo ""
echo "If connection failed, check:"
echo "1. Target server is running"
echo "2. Firewall rules (local and remote)"
echo "3. Security groups (if AWS/cloud)"
echo "4. Network ACLs"
echo "5. Service is listening on correct port"
echo ""
echo "Next steps:"
echo "- Check server logs"
echo "- Verify service status"
echo "- Test from different location"
echo ""
