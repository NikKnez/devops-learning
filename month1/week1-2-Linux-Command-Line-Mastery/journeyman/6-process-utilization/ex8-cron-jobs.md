# Exercise 8: Cron Jobs


## Task 8.1: Understanding Cron
cat > cron-guide.txt << 'EOF'
=== Cron Jobs Complete Guide ===

What is Cron?
- Time-based job scheduler
- Runs commands/scripts at specified times
- Daemon process (crond)
- User-level and system-level jobs

Cron Syntax:
* * * * * command
│ │ │ │ │
│ │ │ │ └─── Day of week (0-7, Sun=0 or 7)
│ │ │ └───── Month (1-12)
│ │ └─────── Day of month (1-31)
│ └───────── Hour (0-23)
└─────────── Minute (0-59)

Special Characters:
*     - Any value
,     - List (1,3,5)
-     - Range (1-5)
/     - Step (*/5 = every 5)

Examples:

0 0 * * *           # Daily at midnight
0 */6 * * *         # Every 6 hours
30 2 * * 0          # Sunday at 2:30 AM
0 9-17 * * 1-5      # 9 AM-5 PM, Mon-Fri, every hour
*/15 * * * *        # Every 15 minutes
0 0 1 * *           # First day of month at midnight
0 0 * * 0           # Every Sunday at midnight
@reboot             # At system boot
@daily              # Once a day (0:00)
@weekly             # Once a week (Sun 0:00)
@monthly            # Once a month (1st 0:00)
@yearly             # Once a year (Jan 1 0:00)

Managing Cron Jobs:

View cron jobs:
crontab -l              # List your cron jobs
crontab -l -u username  # List other user's jobs (root only)

Edit cron jobs:
crontab -e              # Edit with default editor

Remove all cron jobs:
crontab -r              # Careful!

System-wide cron:
/etc/crontab            # System crontab
/etc/cron.d/            # Additional cron files
/etc/cron.daily/        # Daily scripts
/etc/cron.weekly/       # Weekly scripts
/etc/cron.monthly/      # Monthly scripts

Crontab Format:
SHELL=/bin/bash
PATH=/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin
MAILTO=admin@example.com

# m h dom mon dow command
0 2 * * * /home/user/backup.sh
*/10 * * * * /usr/local/bin/healthcheck.sh

Environment Variables:
SHELL    - Shell to use (default: /bin/sh)
PATH     - Search path for commands
MAILTO   - Email output to this address
HOME     - Home directory
LOGNAME  - Username

Cron Best Practices:

1. Use absolute paths:
   # Bad:  */5 * * * * backup.sh
   # Good: */5 * * * * /home/user/backup.sh

2. Redirect output:
   */5 * * * * /home/user/script.sh >> /var/log/script.log 2>&1

3. Set environment:
   SHELL=/bin/bash
   PATH=/usr/local/bin:/usr/bin:/bin

4. Test scripts manually first:
   Run script before scheduling

5. Handle failures:
   Script should log errors
   Use exit codes properly

6. Don't overlap jobs:
   Ensure job finishes before next run
   Use locking mechanisms

7. Email notifications:
   MAILTO=admin@example.com
   Or: command 2>&1 | mail -s "Job" admin@example.com

Cron Logging:

Check cron logs:
grep CRON /var/log/syslog
journalctl -u cron

Enable detailed logging:
# Edit /etc/rsyslog.conf
cron.* /var/log/cron.log

Debugging Cron Jobs:

Job not running? Check:
1. Is cron running?
   systemctl status cron

2. Syntax correct?
   crontab -l

3. Check logs:
   grep CRON /var/log/syslog

4. Test script manually:
   /path/to/script.sh

5. Check permissions:
   ls -l /path/to/script.sh

6. Environment issues:
   Add: * * * * * env > /tmp/cron-env.txt
   Compare with normal environment

Common Cron Patterns:

Backups:
0 2 * * * /usr/local/bin/backup-database.sh
0 3 * * 0 /usr/local/bin/backup-full.sh

Monitoring:
*/5 * * * * /usr/local/bin/check-disk-space.sh
*/10 * * * * /usr/local/bin/check-services.sh

Maintenance:
0 4 * * * /usr/local/bin/cleanup-logs.sh
0 0 * * 0 /usr/local/bin/update-system.sh

Log Rotation:
0 0 * * * /usr/sbin/logrotate /etc/logrotate.conf

Security:
0 */4 * * * /usr/local/bin/security-scan.sh

Cron vs Systemd Timers:

Cron:
- Simple, well-known
- User-level and system-level
- Limited logging
- No dependencies

Systemd Timers:
- More features (dependencies, retries)
- Better logging (journalctl)
- More complex setup
- Modern approach

For DevOps:
- Simple scheduled tasks: Cron
- Complex workflows: Systemd timers
- CI/CD: External tools (Jenkins, GitLab CI)

Cron Gotchas:

1. % is special in cron:
   # Bad:  date +%Y-%m-%d
   # Good: date +\%Y-\%M-\%d
   Or use $(date +%Y-%m-%d)

2. PATH is minimal:
   Always use absolute paths

3. Different user environment:
   Cron runs in minimal environment
   Source ~/.bashrc if needed

4. No terminal:
   Interactive commands fail
   Use -y flags for auto-yes

5. Timezone:
   Cron uses system timezone
   Check: timedatectl

6. Concurrent execution:
   Job can run while previous still running
   Use flock or custom locking
EOF

cat cron-guide.txt


## Task 8.2: Practice Cron Jobs
# Create test scripts for cron
cat > test-cron-script.sh << 'EOF'
#!/bin/bash

# Test script for cron
echo "$(date): Cron test script executed" >> /tmp/cron-test.log
EOF

chmod +x test-cron-script.sh

# Create cron examples document
cat > cron-examples.txt << 'EOF'
=== Practical Cron Examples ===

1. Backup script every day at 2 AM:
0 2 * * * /home/user/backup.sh >> /var/log/backup.log 2>&1

2. Check disk space every 15 minutes:
*/15 * * * * /usr/local/bin/check-disk.sh

3. Clean temp files daily at 3 AM:
0 3 * * * find /tmp -type f -mtime +7 -delete

4. Send system report weekly (Sunday 8 AM):
0 8 * * 0 /usr/local/bin/weekly-report.sh | mail -s "Weekly Report" admin@example.com

5. Restart service every 6 hours:
0 */6 * * * systemctl restart myservice

6. Check website every 5 minutes:
*/5 * * * * curl -s http://example.com > /dev/null || echo "Site down!" | mail -s "Alert" admin@example.com

7. Database backup on first of month:
0 1 1 * * /usr/local/bin/db-backup.sh

8. Clean logs older than 30 days:
0 0 * * * find /var/log/myapp -name "*.log" -mtime +30 -delete

9. Update SSL certificates monthly:
0 0 1 * * /usr/bin/certbot renew

10. Run security audit weekly:
0 2 * * 1 /usr/local/bin/security-audit.sh >> /var/log/security.log

To add these:
1. crontab -e
2. Add line
3. Save and exit

To test without waiting:
- Change time to next minute
- Add line and save
- Check log after 1 minute
- Remove test line
EOF

cat cron-examples.txt

# Create cron setup guide
cat > setup-cron-job.sh << 'EOF'
#!/bin/bash

echo "=== Cron Job Setup Guide ==="
echo ""
echo "Step 1: Create your script"
echo "  nano ~/my-script.sh"
echo ""
echo "Step 2: Make it executable"
echo "  chmod +x ~/my-script.sh"
echo ""
echo "Step 3: Test it manually"
echo "  ~/my-script.sh"
echo ""
echo "Step 4: Edit crontab"
echo "  crontab -e"
echo ""
echo "Step 5: Add line (example: every 5 minutes)"
echo "  */5 * * * * /home/$(whoami)/my-script.sh >> /tmp/script.log 2>&1"
echo ""
echo "Step 6: Save and exit"
echo ""
echo "Step 7: Verify it was added"
echo "  crontab -l"
echo ""
echo "Step 8: Check execution (wait 5 minutes)"
echo "  tail /tmp/script.log"
echo ""
echo "Current crontab:"
crontab -l 2>/dev/null || echo "  (No crontab installed)"
EOF

chmod +x setup-cron-job.sh
./setup-cron-job.sh
