# Exercise 2: Syslog and rsyslog


## Task 2.1: Understanding Syslog
cat > syslog-guide.txt << 'EOF'
=== Syslog and rsyslog ===

What is Syslog?
- Protocol for log message transport
- Standard way applications send logs
- rsyslog is modern implementation

rsyslog Configuration:
Main config: /etc/rsyslog.conf
Additional: /etc/rsyslog.d/*.conf

Syslog Message Format:
<priority>timestamp hostname application[PID]: message

Priority = Facility * 8 + Severity

Facilities (What generated the message):
0  - kern      Kernel messages
1  - user      User-level messages
2  - mail      Mail system
3  - daemon    System daemons
4  - auth      Security/authorization
5  - syslog    Syslog internal
6  - lpr       Line printer subsystem
7  - news      Network news
16 - local0    Local use 0-7
...
23 - local7    Local use 0-7

rsyslog Rules Format:
facility.severity    action

Examples:
*.info;mail.none     /var/log/messages
auth,authpriv.*      /var/log/auth.log
kern.*               /var/log/kern.log
*.emerg              :omusrmsg:*

Actions:
/path/to/file        Write to file
@remote-host:514     Send to remote (UDP)
@@remote-host:514    Send to remote (TCP)
|/path/to/script     Pipe to script
:omusrmsg:*          Message to all users

Testing rsyslog:
logger "Test message"                    # Send to syslog
logger -p user.err "Error test"          # With priority
logger -t myapp "Application log"        # With tag
EOF

cat syslog-guide.txt


## Task 2.2: Examine rsyslog Configuration
# Check if rsyslog is running
sudo systemctl status rsyslog

# View main config
sudo cat /etc/rsyslog.conf | grep -v "^#" | grep -v "^$"

# Check additional configs
ls -l /etc/rsyslog.d/

# Show rsyslog rules
sudo grep -v "^#" /etc/rsyslog.conf | grep -v "^$" | grep "*."

# Test logging with logger
logger "DevOps test message from $(whoami)"

# Check if it appeared in syslog
sudo tail -5 /var/log/syslog | grep "DevOps test"

# Test with priority
logger -p user.warning "Warning level test"
logger -p user.err "Error level test"

# Check the logs
sudo tail -10 /var/log/syslog | grep "test"

# Create rsyslog analysis
cat > rsyslog-analysis.txt << EOF
=== rsyslog Configuration Analysis ===

Service status:
$(sudo systemctl is-active rsyslog)

Configuration files:
$(ls /etc/rsyslog.d/)

Active rules (sample):
$(sudo grep -h "^\*\." /etc/rsyslog.conf /etc/rsyslog.d/*.conf 2>/dev/null | head -5)

Test message sent: "DevOps test message"
Found in log: $(sudo grep -c "DevOps test" /var/log/syslog) times
EOF

cat rsyslog-analysis.txt


## Task 2.3: Practice with logger Command
# Create logging practice script
cat > logger-practice.sh << 'EOF'
#!/bin/bash

echo "=== Logger Practice Script ==="
echo "Sending various log messages..."

# Basic message
logger "Basic log message from script"

# With facility and severity
logger -p user.info "Info: Script started"
logger -p user.notice "Notice: Processing data"
logger -p user.warning "Warning: Low disk space"
logger -p user.err "Error: Failed to connect"

# With tag (application name)
logger -t "myapp" "Application startup"
logger -t "myapp[$$]" "Application running with PID $$"

# With both
logger -p daemon.info -t "backup-script" "Backup completed successfully"

echo ""
echo "Messages sent to syslog!"
echo "Check with: sudo tail -20 /var/log/syslog"
EOF

chmod +x logger-practice.sh
./logger-practice.sh

# View the results
echo ""
echo "=== Recent Log Entries ==="
sudo tail -20 /var/log/syslog | grep -E "logger-practice|myapp|backup-script"
