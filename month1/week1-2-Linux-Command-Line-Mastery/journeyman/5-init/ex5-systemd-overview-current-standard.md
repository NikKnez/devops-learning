# Exercise 5: Systemd Overview (Current Standard)


## Task 5.1: Understanding Systemd
cat > systemd-overview.txt << 'EOF'
=== Systemd Init System ===

What is Systemd?
- Modern init system and service manager
- Standard on most Linux distributions
- Created by Lennart Poettering (Red Hat)
- First released 2010
- Default since RHEL 7, Ubuntu 15.04, Debian 8

Why Systemd Won:
- Parallel service startup (fast boot)
- Proper dependency management
- Socket and D-Bus activation
- On-demand service starting
- Unified logging (journald)
- Resource management (cgroups)
- Timer units (replaces cron)
- Backwards compatible with SysV

Core Components:

systemd (PID 1)
- Init process
- Service manager
- Process supervisor

systemctl
- Control systemd
- Manage services
- Query system state

journalctl
- Query systemd journal
- View logs

systemd-analyze
- Boot time analysis
- System performance

Key Concepts:

Units:
- Service units (.service) - Daemons/services
- Mount units (.mount) - Filesystem mounts
- Target units (.target) - Group of units
- Timer units (.timer) - Scheduled tasks
- Socket units (.socket) - IPC sockets
- Device units (.device) - Hardware devices
- Path units (.path) - File/directory watching

Unit File Locations:
/lib/systemd/system/       - Distribution defaults
/etc/systemd/system/       - Administrator overrides
/run/systemd/system/       - Runtime units

Dependencies:
Requires=    - Hard dependency
Wants=       - Soft dependency
Before=      - Order dependency
After=       - Order dependency
Conflicts=   - Negative dependency

Advantages:
✓ Fast parallel startup
✓ Automatic dependency resolution
✓ Socket activation (lazy loading)
✓ Resource limits per service
✓ Better process tracking
✓ Transactional activation
✓ Snapshot and restore
✓ Powerful logging

Controversies:
- Binary logs (not plain text)
- Large scope (does many things)
- Breaking Unix philosophy
- Opinionated design
- Required by many desktop environments

DevOps Relevance:
- Industry standard
- Must know for modern Linux
- Container init systems
- Cloud instances
- Kubernetes nodes
EOF

cat systemd-overview.txt


## Task 5.2: Explore Systemd on Your System
# Verify systemd is running
ps -p 1

# Systemd version
systemctl --version

# List all units
systemctl list-units

# List only service units
systemctl list-units --type=service

# List all unit files (enabled/disabled)
systemctl list-unit-files --type=service | head -20

# Show failed units
systemctl --failed

# System state
systemctl status

# Analyze boot time
systemd-analyze

# Boot time by service
systemd-analyze blame | head -20

# Create systemd report
cat > systemd-report.txt << EOF
=== Systemd System Report ===

Version:
$(systemctl --version)

System State:
$(systemctl is-system-running)

Total Units:
$(systemctl list-units --all | wc -l)

Active Services:
$(systemctl list-units --type=service --state=running | wc -l)

Failed Units:
$(systemctl --failed | wc -l)

Boot Time:
$(systemd-analyze | head -1)

Slowest Services (Top 5):
$(systemd-analyze blame | head -5)

Recently Started Services:
$(systemctl list-units --type=service --state=running | head -10)
EOF

cat systemd-report.txt


## Task 5.3: Systemd Service Management
# Service management commands
cat > systemd-commands.txt << 'EOF'
=== Essential Systemd Commands ===

SERVICE CONTROL:
systemctl start SERVICE       # Start now
systemctl stop SERVICE        # Stop now
systemctl restart SERVICE     # Restart
systemctl reload SERVICE      # Reload config
systemctl status SERVICE      # Check status
systemctl is-active SERVICE   # Running?
systemctl is-enabled SERVICE  # Start at boot?

BOOT CONFIGURATION:
systemctl enable SERVICE      # Start at boot
systemctl disable SERVICE     # Don't start at boot
systemctl mask SERVICE        # Prevent starting (stronger than disable)
systemctl unmask SERVICE      # Remove mask

SYSTEM STATE:
systemctl list-units          # All active units
systemctl list-unit-files     # All installed units
systemctl --failed            # Failed units
systemctl status              # System overview

UNIT INFORMATION:
systemctl show SERVICE        # All properties
systemctl cat SERVICE         # Show unit file
systemctl list-dependencies SERVICE  # Dependencies

SYSTEM CONTROL:
systemctl reboot              # Reboot system
systemctl poweroff            # Shut down
systemctl suspend             # Suspend to RAM
systemctl hibernate           # Suspend to disk

ADVANCED:
systemctl daemon-reload       # Reload unit files
systemctl reset-failed        # Clear failed state
systemctl isolate TARGET      # Switch to target

LOGS:
journalctl                    # All logs
journalctl -u SERVICE         # Service logs
journalctl -f                 # Follow logs
journalctl -b                 # Current boot logs
journalctl --since "1 hour ago"  # Recent logs
EOF

cat systemd-commands.txt
