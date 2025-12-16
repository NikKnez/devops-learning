#!/bin/bash

# Simple monitoring dashboard
# Run with: watch -n 5 ./monitoring-dashboard.sh

clear
echo "============================================"
echo "     SYSTEM MONITORING DASHBOARD"
echo "============================================"
echo "Last Update: $(date)"
echo ""

# CPU
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | awk '{print "  User: " $2 ", System: " $4 ", Idle: " $8}'
echo "  Load Average: $(uptime | awk -F'load average:' '{print $2}')"
echo ""

# Memory
echo "Memory:"
free -h | grep Mem | awk '{print "  Total: " $2 ", Used: " $3 ", Available: " $7}'
free -h | grep Swap | awk '{print "  Swap Used: " $3 " / " $2}'
echo ""

# Disk
echo "Disk Usage:"
df -h | grep -E "^/dev" | awk '{print "  " $1 ": " $5 " used (" $3 " / " $2 ")"}'
echo ""

# Network
echo "Network (if ss available):"
if command -v ss &> /dev/null; then
    ESTABLISHED=$(ss -tan | grep ESTAB | wc -l)
    LISTENING=$(ss -tln | wc -l)
    echo "  Established connections: $ESTABLISHED"
    echo "  Listening ports: $LISTENING"
else
    echo "  ss command not available"
fi
echo ""

# Top Processes
echo "Top 3 CPU Processes:"
ps aux --sort=-%cpu | head -4 | tail -3 | awk '{printf "  %-10s %5s%% %s\n", $1, $3, $11}'
echo ""

echo "Top 3 Memory Processes:"
ps aux --sort=-%mem | head -4 | tail -3 | awk '{printf "  %-10s %5s%% %s\n", $1, $4, $11}'
echo ""

echo "============================================"
echo "Press Ctrl+C to exit"
