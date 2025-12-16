#!/bin/bash

echo "=== I/O Monitoring Report ==="
date
echo ""

echo "1. Disk Space:"
df -h | grep -E "Filesystem|^/dev"
echo ""

echo "2. Disk I/O Stats:"
if command -v iostat &> /dev/null; then
    iostat -x 1 2 | tail -n +4
else
    echo "   iostat not installed (sudo apt install sysstat)"
fi
echo ""

echo "3. System I/O (vmstat):"
if command -v vmstat &> /dev/null; then
    echo "   bi/bo = blocks in/out per second"
    vmstat 1 3 | tail -2
else
    echo "   vmstat not available"
fi
echo ""

echo "4. Open Files Count:"
echo "   $(lsof 2>/dev/null | wc -l) files open system-wide"
echo ""

echo "5. Largest Directories in /var:"
sudo du -sh /var/* 2>/dev/null | sort -rh | head -5
