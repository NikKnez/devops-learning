#!/bin/bash
# Check disk space and alert if low

THRESHOLD=80
USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "WARNING: Disk usage is ${USAGE}%"
    exit 1
else
    echo "Disk usage OK: ${USAGE}%"
    exit 0
fi
