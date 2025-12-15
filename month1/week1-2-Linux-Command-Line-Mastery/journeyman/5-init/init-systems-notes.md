# Init Systems

## Evolution of Init

### SysV (Historical)
- Traditional Unix init
- Runlevels 0-6
- /etc/init.d/ scripts
- Sequential startup (slow)
- No dependency management

### Upstart (Ubuntu 2006-2014)
- Event-based
- Parallel startup
- /etc/init/*.conf
- Replaced by systemd

### Systemd (Current Standard)
- Modern init system
- Unit files
- Parallel startup
- Dependency management
- Industry standard

## Systemd Essentials

### Commands
- `systemctl start/stop/restart SERVICE`
- `systemctl enable/disable SERVICE`
- `systemctl status SERVICE`
- `journalctl -u SERVICE`
- `systemd-analyze` - boot time

### Targets (Runlevels)
- multi-user.target - CLI
- graphical.target - GUI
- rescue.target - Single-user
- poweroff.target - Shutdown

### Power Management
- `systemctl poweroff` - shutdown
- `systemctl reboot` - restart
- `systemctl suspend` - sleep
- `systemctl hibernate` - save to disk

## Key Concepts
- PID 1 is init system
- Services managed by systemd
- Unit files define services
- Dependencies auto-resolved
- Journald for logging

## Time Spent
[About 3 to 4 hours in span of two days]
