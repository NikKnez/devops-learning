# Exercise 2: SysV Service Management (Legacy)


## Task 2.1: Understanding SysV Service Scripts
cat > sysv-services.txt << 'EOF'
=== SysV Service Management ===

Service Script Structure:
- Located in /etc/init.d/
- Shell scripts with standard functions
- Support: start, stop, restart, status, reload

Standard Functions:
start()    - Start the service
stop()     - Stop the service
restart()  - Stop then start
reload()   - Reload config without restart
status()   - Check if running

Basic SysV Script Template:
```bash
#!/bin/bash
# chkconfig: 2345 80 30
# description: My Service

case "$1" in
  start)
    echo "Starting myservice..."
    /usr/bin/myservice &
    ;;
  stop)
    echo "Stopping myservice..."
    killall myservice
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  status)
    ps aux | grep myservice
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|status}"
    exit 1
esac
```

Service Management Commands:

Start service:
/etc/init.d/apache2 start
service apache2 start

Stop service:
/etc/init.d/apache2 stop
service apache2 stop

Restart service:
/etc/init.d/apache2 restart
service apache2 restart

Check status:
/etc/init.d/apache2 status
service apache2 status

Enable at boot:
update-rc.d apache2 defaults

Disable at boot:
update-rc.d apache2 remove

Runlevel Configuration:
chkconfig apache2 on       # RHEL/CentOS
update-rc.d apache2 enable # Debian/Ubuntu

Priority Numbers:
- S scripts run in ascending order (S10, S20, S30)
- K scripts run in descending order (K90, K80, K70)
- Lower number = higher priority

Dependency Management:
- None built-in!
- Handled by script order
- Required manual coordination
- Major weakness of SysV
EOF

cat sysv-services.txt


## Task 2.2: Examine SysV Compatibility Layer
# Modern systems have 'service' command for compatibility
which service

# List services (SysV style)
service --status-all 2>/dev/null | head -10

# Try to check a service status (compatibility mode)
service ssh status 2>/dev/null || systemctl status ssh

# The 'service' command on systemd systems
# actually redirects to systemctl

# Create service command comparison
cat > service-compatibility.txt << 'EOF'
=== SysV vs Systemd Service Commands ===

SysV Commands → Systemd Equivalent:

service nginx start     → systemctl start nginx
service nginx stop      → systemctl stop nginx
service nginx restart   → systemctl restart nginx
service nginx status    → systemctl status nginx
service nginx reload    → systemctl reload nginx

chkconfig nginx on      → systemctl enable nginx
chkconfig nginx off     → systemctl disable nginx
chkconfig --list        → systemctl list-unit-files

service --status-all    → systemctl list-units --type=service

/etc/init.d/nginx start → systemctl start nginx

Why systemctl is better:
- Dependency management
- Parallel startup
- Better logging (journald)
- Socket activation
- Resource limits (cgroups)
- More reliable state tracking
EOF

cat service-compatibility.txt
