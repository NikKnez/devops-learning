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
