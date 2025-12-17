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
