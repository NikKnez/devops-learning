#!/bin/bash

echo "=== CPU Monitoring Report ==="
date
echo ""

echo "1. CPU Information:"
echo "   Cores: $(nproc)"
echo "   Architecture: $(lscpu | grep Architecture | awk '{print $2}')"
echo ""

echo "2. Load Average:"
uptime
echo ""

echo "3. CPU Usage (snapshot):"
top -b -n 1 | grep "Cpu(s)" | awk '{print "   User: " $2 ", System: " $4 ", Idle: " $8}'
echo ""

echo "4. Top 5 CPU Processes:"
ps aux --sort=-%cpu | head -6 | tail -5
echo ""

echo "5. CPU Per Core (if mpstat available):"
if command -v mpstat &> /dev/null; then
    mpstat -P ALL 1 1 | grep Average
else
    echo "   mpstat not installed (sudo apt install sysstat)"
fi
echo ""

echo "6. Context Switches (if vmstat available):"
if command -v vmstat &> /dev/null; then
    vmstat 1 2 | tail -1 | awk '{print "   " $12 " context switches/sec"}'
else
    echo "   vmstat not available"
fi
