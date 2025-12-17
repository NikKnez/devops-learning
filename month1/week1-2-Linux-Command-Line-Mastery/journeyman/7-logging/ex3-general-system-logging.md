# Exercise 3: General System Logging


## Task 3.1: Reading System Logs
# View system log (last 50 lines)
sudo tail -50 /var/log/syslog

# Follow system log in real-time
# (Run in another terminal: sudo tail -f /var/log/syslog)

# Search for errors
sudo grep -i "error" /var/log/syslog | tail -20

# Search for warnings
sudo grep -i "warning" /var/log/syslog | tail -20

# Search for specific service (e.g., ssh)
sudo grep "sshd" /var/log/syslog | tail -20

# Count error messages today
sudo grep -i "error" /var/log/syslog | grep "$(date +%b' '%d)" | wc -l

# Find all logs from last hour
sudo find /var/log -type f -mmin -60 -exec ls -lh {} \; 2>/dev/null

# Create log analysis script
cat > analyze-logs.sh << 'EOF'
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
EOF

chmod +x analyze-logs.sh
./analyze-logs.sh > log-analysis-report.txt
cat log-analysis-report.txt


## Task 3.2: Log Filtering Techniques
# Create log filtering cheat sheet
cat > log-filtering.sh << 'EOF'
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
EOF

chmod +x log-filtering.sh
./log-filtering.sh
