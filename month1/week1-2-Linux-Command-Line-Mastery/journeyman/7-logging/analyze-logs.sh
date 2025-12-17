#!/bin/bash

echo "=== System Log Analysis ==="
echo ""

LOG_FILE="/var/log/syslog"

if [ ! -f "$LOG_FILE" ]; then
    LOG_FILE="/var/log/messages"
fi

echo "Analyzing: $LOG_FILE"
echo ""

echo "Log size: $(sudo du -h $LOG_FILE 2>/dev/null | cut -f1)"
echo "Last modified: $(sudo stat -c %y $LOG_FILE 2>/dev/null | cut -d'.' -f1)"
echo ""

echo "Top 10 Most Frequent Messages:"
sudo cat $LOG_FILE 2>/dev/null | awk '{for(i=5;i<=NF;i++) printf $i" "; print""}' | sort | uniq -c | sort -rn | head -10

echo ""
echo "Error count today: $(sudo grep -i error $LOG_FILE 2>/dev/null | grep "$(date +%b' '%d)" | wc -l)"
echo "Warning count today: $(sudo grep -i warning $LOG_FILE 2>/dev/null | grep "$(date +%b' '%d)" | wc -l)"

echo ""
echo "Recent errors (last 5):"
sudo grep -i error $LOG_FILE 2>/dev/null | tail -5
