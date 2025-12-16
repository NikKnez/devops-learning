#!/bin/bash

echo "=== Memory Monitoring Report ==="
date
echo ""

echo "1. Memory Overview:"
free -h
echo ""

echo "2. Memory Available:"
AVAILABLE=$(free -m | grep Mem | awk '{print $7}')
TOTAL=$(free -m | grep Mem | awk '{print $2}')
PERCENT=$((100 * AVAILABLE / TOTAL))
echo "   Available: ${AVAILABLE}MB / ${TOTAL}MB (${PERCENT}%)"
echo ""

echo "3. Swap Usage:"
free -h | grep Swap
echo ""

echo "4. Top 5 Memory-Using Processes:"
ps aux --sort=-%mem | head -6 | awk '{printf "   %-10s %5s %5s %s\n", $1, $3, $4, $11}'
echo ""

echo "5. Memory Details:"
cat /proc/meminfo | grep -E "MemTotal|MemFree|MemAvailable|Buffers|Cached|SwapTotal|SwapFree"
echo ""

echo "6. Virtual Memory Stats:"
if command -v vmstat &> /dev/null; then
    echo "   si/so (swap in/out):"
    vmstat 1 2 | tail -1 | awk '{print "   Swap In: " $7 ", Swap Out: " $8}'
else
    echo "   vmstat not available"
fi
