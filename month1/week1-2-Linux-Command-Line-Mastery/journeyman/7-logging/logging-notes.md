# System Logging


## Key Concepts

### Logging Systems
- **syslog/rsyslog** - Traditional text logging
- **journald** - Modern binary logging (systemd)
- **Application logs** - App-specific logs

### Important Log Files
- `/var/log/syslog` - System messages
- `/var/log/auth.log` - Authentication
- `/var/log/kern.log` - Kernel messages
- `/var/log/dmesg` - Boot messages

### Log Severity Levels
0. emerg - System unusable
1. alert - Immediate action needed
2. crit - Critical condition
3. err - Error
4. warning - Warning
5. notice - Normal but significant
6. info - Informational
7. debug - Debug messages

### Commands Learned
- `tail -f /var/log/syslog` - Follow logs
- `grep "error" /var/log/syslog` - Search logs
- `logger "message"` - Send to syslog
- `dmesg` - Kernel ring buffer
- `journalctl` - Query systemd journal
- `journalctl -f` - Follow journal
- `journalctl -u service` - Service logs

### Log Management
- **logrotate** - Automatic log rotation
- Compresses old logs
- Deletes very old logs
- Prevents disk fill

## DevOps Applications
- Troubleshooting application issues
- Security monitoring (failed logins)
- Performance analysis
- Compliance and auditing

## Time Spent
[It took about 4 hours in span of two days]
