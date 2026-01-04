#!/bin/bash
# Network information gathering script

echo "==================================="
echo "Network Information Report"
echo "==================================="
echo ""

echo "1. IP Address Information:"
ip addr show | grep -E "inet |ether "
echo ""

echo "2. Routing Table:"
ip route show
echo ""

echo "3. Default Gateway:"
ip route | grep default
echo ""

echo "4. DNS Servers:"
cat /etc/resolv.conf | grep nameserver
echo ""

echo "5. Active Network Connections:"
ss -tuln | head -10
echo ""

echo "6. Network Interfaces:"
ls /sys/class/net/
echo ""

echo "==================================="
echo "Report Complete"
echo "==================================="
