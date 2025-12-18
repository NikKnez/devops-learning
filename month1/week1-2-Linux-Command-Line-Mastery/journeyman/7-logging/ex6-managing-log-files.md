# Exercise 6: Managing Log Files


## Task 6.1: Understanding Log Rotation
cat > logrotate-guide.txt << 'EOF'
=== Log Rotation with logrotate ===

Why Rotate Logs?
- Logs grow forever
- Fill up disk space
- Old logs not needed
- Compliance (keep N days)

How logrotate Works:
1. Runs daily (via cron)
2. Checks log sizes/ages
3. Rotates according to rules
4. Compresses old logs
5. Deletes very old logs

Configuration:
Main config: /etc/logrotate.conf
App configs: /etc/logrotate.d/*

logrotate Directives:
daily, weekly, monthly    - Rotation frequency
rotate N                  - Keep N old logs
size 100M                 - Rotate when size reached
compress                  - Compress old logs
delaycompress            - Compress on next rotation
missingok                - Don't error if log missing
notifempty               - Don't rotate if empty
create 0640 user group   - Permissions for new log
postrotate...endscript   - Commands after rotation

Example Config:
/var/log/myapp/*.log {
    daily
    rotate 7
    compress
    delaycompress
    missingok
    notifempty
    create 0640 www-data www-data
    postrotate
        systemctl reload myapp
    endscript
}

This means:
- Rotate daily
- Keep 7 days of logs
- Compress old logs
- Don't compress yesterday's log
- Ignore if log doesn't exist
- Don't rotate empty logs
- Create new log with specific permissions
- Reload app after rotation

Testing logrotate:
sudo logrotate -d /etc/logrotate.conf      # Dry run
sudo logrotate -f /etc/logrotate.conf      # Force rotation
sudo logrotate -v /etc/logrotate.conf      # Verbose
EOF

cat logrotate-guide.txt


## Task 6.2: Examine logrotate Configuration
# View main logrotate config
sudo cat /etc/logrotate.conf

# List application-specific configs
ls -l /etc/logrotate.d/

# View a specific config (e.g., rsyslog)
sudo cat /etc/logrotate.d/rsyslog

# Check when logrotate last ran
ls -l /var/lib/logrotate/status

# See logrotate status
sudo cat /var/lib/logrotate/status | head -20

# Create logrotate analysis
cat > logrotate-analysis.txt << EOF
=== logrotate Configuration Analysis ===

Application configs:
$(ls /etc/logrotate.d/)

Main config settings:
$(sudo grep -v "^#" /etc/logrotate.conf | grep -v "^$" | head -10)

rsyslog rotation config:
$(sudo cat /etc/logrotate.d/rsyslog 2>/dev/null || echo "Not found")

Last rotation times (sample):
$(sudo cat /var/lib/logrotate/status | head -10)
EOF

cat logrotate-analysis.txt


## Task 6.3: Practice Log Rotation
# Create custom log rotation config
cat > custom-logrotate.conf << 'EOF'
# Custom logrotate config for testing
/tmp/test-app.log {
    daily
    rotate 3
    size 1M
    compress
    delaycompress
    missingok
    notifempty
    create 0644 nikola nikola
}
EOF

# Create test log file
mkdir -p /tmp/test-logs
for i in {1..1000}; do
    echo "$(date): Test log entry $i" >> /tmp/test-app.log
done

# Check log size
ls -lh /tmp/test-app.log

# Test logrotate with custom config (dry run)
sudo logrotate -d custom-logrotate.conf

# Actually rotate (if you want to test)
# sudo logrotate -f custom-logrotate.conf

# Cleanup
rm -f /tmp/test-app.log* custom-logrotate.conf


## Task 6.4: Manual Log Management
# Create log management script
cat > manage-logs.sh << 'EOF'
#!/bin/bash

echo "=== Log Management Utility ==="
echo ""

# Function to find large logs
find_large_logs() {
    echo "Large log files (>10MB):"
    sudo find /var/log -type f -size +10M -exec ls -lh {} \; 2>/dev/null | \
        awk '{print $5, $9}'
}

# Function to find old logs
find_old_logs() {
    echo ""
    echo "Old log files (>30 days):"
    sudo find /var/log -type f -mtime +30 -ls 2>/dev/null | wc -l
    echo "files older than 30 days"
}

# Function to show disk usage
show_disk_usage() {
    echo ""
    echo "Log directory disk usage:"
    sudo du -sh /var/log
    echo ""
    echo "Top 5 largest:"
    sudo du -sh /var/log/* 2>/dev/null | sort -rh | head -5
}

# Function to archive old logs
archive_old_logs() {
    echo ""
    echo "Compressing uncompressed logs older than 7 days..."
    sudo find /var/log -type f -name "*.log" -mtime +7 ! -name "*.gz" \
        -exec gzip {} \; 2>/dev/null
    echo "Done"
}

# Main menu
echo "1. Find large logs"
echo "2. Find old logs"
echo "3. Show disk usage"
echo "4. Archive old logs (compress)"
echo ""

read -p "Select option (1-4): " choice

case $choice in
    1) find_large_logs ;;
    2) find_old_logs ;;
    3) show_disk_usage ;;
    4) archive_old_logs ;;
    *) echo "Invalid option" ;;
esac
EOF

chmod +x manage-logs.sh
./manage-logs.sh
