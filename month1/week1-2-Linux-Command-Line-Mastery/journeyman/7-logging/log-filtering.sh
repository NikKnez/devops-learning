#!/bin/bash

LOG="/var/log/syslog"

echo "=== Log Filtering Techniques ==="
echo ""

# Time-based filtering
echo "1. Today's logs:"
sudo grep "$(date +%b' '%d)" $LOG | wc -l
echo "   lines from today"

# Severity filtering
echo ""
echo "2. By severity:"
echo "   Errors: $(sudo grep -i error $LOG | wc -l)"
echo "   Warnings: $(sudo grep -i warning $LOG | wc -l)"
echo "   Critical: $(sudo grep -i critical $LOG | wc -l)"

# Service filtering
echo ""
echo "3. By service:"
echo "   SSH: $(sudo grep sshd $LOG | wc -l) entries"
echo "   Systemd: $(sudo grep systemd $LOG | wc -l) entries"

# Time range (last hour)
echo ""
echo "4. Last hour activity:"
sudo awk -v d="$(date --date='1 hour ago' +'%b %d %H')" '$0 ~ d' $LOG | wc -l
echo "   messages in last hour"

# Pattern matching
echo ""
echo "5. Failed login attempts:"
sudo grep -i "failed" $LOG | grep -i "login\|authentication" | wc -l

# Multiple conditions
echo ""
echo "6. SSH errors today:"
sudo grep "$(date +%b' '%d)" $LOG | grep sshd | grep -i error | wc -l
