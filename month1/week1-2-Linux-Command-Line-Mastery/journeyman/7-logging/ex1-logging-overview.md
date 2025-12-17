# Exercise 1: System Logging Overview


## Task 1.1: Understanding Linux Logging
cat > logging-overview.txt << 'EOF'
=== Linux Logging System ===

Why Logging Matters for DevOps:
- Troubleshooting application issues
- Security auditing (who accessed what)
- Performance monitoring
- Compliance requirements
- Root cause analysis after incidents

Linux Logging Components:

1. SYSLOG (Traditional)
   - Standard protocol for message logging
   - rsyslog (modern implementation)
   - Logs to /var/log/*

2. SYSTEMD-JOURNALD (Modern)
   - Binary logging system
   - Part of systemd
   - Accessed via journalctl
   - Can forward to syslog

3. APPLICATION LOGS
   - Applications write their own logs
   - Examples: Apache, Nginx, MySQL
   - Usually in /var/log/appname/

Log Severity Levels (Syslog Standard):
0 - emerg    System unusable
1 - alert    Action must be taken immediately
2 - crit     Critical conditions
3 - err      Error conditions
4 - warning  Warning conditions
5 - notice   Normal but significant
6 - info     Informational messages
7 - debug    Debug-level messages

Common Log Locations:
/var/log/syslog          System messages (Debian/Ubuntu)
/var/log/messages        System messages (RHEL/CentOS)
/var/log/auth.log        Authentication attempts
/var/log/kern.log        Kernel messages
/var/log/dmesg           Boot messages
/var/log/secure          Security/auth (RHEL)
/var/log/apache2/        Apache web server
/var/log/nginx/          Nginx web server

Log Rotation:
- Logs grow indefinitely
- logrotate manages old logs
- Compresses, archives, deletes old logs
- Runs daily via cron
EOF

cat logging-overview.txt


## Task 1.2: Explore Your Log Directory
# List all log files
ls -lh /var/log/

# Count log files
ls /var/log/ | wc -l

# Show log files by size
du -sh /var/log/* 2>/dev/null | sort -rh | head -10

# Check total log size
sudo du -sh /var/log/

# Find recently modified logs (active logs)
find /var/log -type f -mmin -60 2>/dev/null

# Create log inventory
cat > log-inventory.txt << EOF
=== System Log Inventory ===

Total log files: $(sudo find /var/log -type f 2>/dev/null | wc -l)
Total log size: $(sudo du -sh /var/log/ 2>/dev/null | cut -f1)

Largest log files:
$(sudo du -sh /var/log/* 2>/dev/null | sort -rh | head -5)

Recently modified (last hour):
$(sudo find /var/log -type f -mmin -60 -ls 2>/dev/null | wc -l) files

Available log files:
$(ls /var/log/)
EOF

cat log-inventory.txt
