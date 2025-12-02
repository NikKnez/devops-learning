#!/bin/bash
PID=$PID

while ps -p \$PID > /dev/null; do
    clear
    echo "=== Monitoring Process \$PID ==="
    echo ""
    echo "Status:"
    cat /proc/\$PID/status | grep -E 'Name|State|VmSize|VmRSS|Threads'
    echo ""
    echo "File descriptors:"
    ls -l /proc/\$PID/fd/ 2>/dev/null | wc -l
    echo ""
    sleep 2
done

echo "Process finished"
