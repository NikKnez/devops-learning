# Exercise 5: Init System (systemd)


## Task 5.1: Understanding Init and systemd
cat > init-systemd-guide.txt << 'EOF'
=== Init Systems: From SysV to systemd ===

What is Init?
- First process started by kernel (PID 1)
- Parent of all processes
- Starts all system services
- Manages system state

Init System Evolution:

1. SysV Init (1980s-2010) - LEGACY
   - Serial startup (one service at a time)
   - Shell scripts in /etc/init.d/
   - Runlevels (0-6)
   - Slow boot times
   - Simple but inflexible

2. Upstart (2006-2015) - TRANSITIONAL
   - Event-driven
   - Parallel startup
   - Used by Ubuntu 6.10-14.10
   - Replaced by systemd

3. systemd (2010-Present) - CURRENT
   - Parallel service startup
   - Dependency-based
   - Faster boot
   - More features
   - Controversial but dominant

systemd Core Concepts:

Units:
- .service  - Services (daemons)
- .socket   - IPC sockets
- .target   - Group of units
- .mount    - Mount points
- .timer    - Scheduled tasks (replaces cron)
- .path     - Path-based activation

Targets (like runlevels):
- poweroff.target       (Runlevel 0)
- rescue.target         (Runlevel 1)
- multi-user.target     (Runlevel 3) - CLI
- graphical.target      (Runlevel 5) - GUI
- reboot.target         (Runlevel 6)

systemd Boot Process:

1. Kernel starts systemd (PID 1)
2. systemd reads /etc/systemd/system/default.target
3. Default is usually multi-user.target or graphical.target
4. systemd analyzes dependencies
5. Starts services in parallel where possible
6. Mounts filesystems
7. Starts network
8. Starts user services
9. Reaches target state

Advantages of systemd:
✓ Parallel startup (faster boot)
✓ On-demand service activation
✓ Better dependency handling
✓ Integrated logging (journald)
✓ Unified management interface
✓ Socket and D-Bus activation
✓ Process supervision

Criticisms of systemd:
✗ Complexity (does too much)
✗ Binary logs (not plain text)
✗ Deviation from Unix philosophy
✗ Difficult to debug
✗ "System bloat"

DevOps Perspective:
- Love it or hate it, it's standard
- Must know systemctl commands
- Understanding units essential
- Logging via journalctl
- Service management in containers mimics systemd
EOF

cat init-systemd-guide.txt


## Task 5.2: Explore systemd
# Check systemd version
systemctl --version

# What's PID 1?
ps -p 1

# Default target
systemctl get-default

# List all targets
systemctl list-units --type=target

# List all services
systemctl list-units --type=service

# List failed services
systemctl --failed

# Show boot time
systemd-analyze

# Service dependency tree
systemctl list-dependencies graphical.target | head -30

# Create systemd analysis
cat > systemd-analysis.txt << EOF
=== systemd Analysis ===

systemd version: $(systemctl --version | head -1)

PID 1 process:
$(ps -p 1)

Default target: $(systemctl get-default)

Active targets:
$(systemctl list-units --type=target --state=active | grep target)

Total services: $(systemctl list-units --type=service | grep -c ".service")
Active services: $(systemctl list-units --type=service --state=active | grep -c ".service")
Failed services: $(systemctl --failed | grep -c ".service")

Boot analysis:
$(systemd-analyze)

Top 5 slowest services:
$(systemd-analyze blame | head -5)
EOF

cat systemd-analysis.txt


## Task 5.3: systemd Boot Targets
# List all targets
systemctl list-units --type=target --all

# Check what's in multi-user.target
systemctl list-dependencies multi-user.target

# Check what's in graphical.target
systemctl list-dependencies graphical.target

# Switch to different target (temporary)
# sudo systemctl isolate multi-user.target  # Switch to CLI
# sudo systemctl isolate graphical.target   # Switch to GUI

# Change default target
# sudo systemctl set-default multi-user.target
# sudo systemctl set-default graphical.target

# Create targets documentation
cat > systemd-targets.txt << 'EOF'
=== systemd Targets (Runlevels) ===

Common Targets:

poweroff.target
- Shutdown system
- Equivalent to: runlevel 0
- Command: systemctl poweroff

rescue.target
- Single-user mode
- Minimal services
- Root password required
- Equivalent to: runlevel 1
- Command: systemctl rescue

multi-user.target
- Multi-user, text mode
- Network enabled
- No GUI
- Equivalent to: runlevel 3
- Most common for servers
- Command: systemctl isolate multi-user.target

graphical.target
- Multi-user with GUI
- Includes multi-user.target
- Starts display manager
- Equivalent to: runlevel 5
- Default for desktops
- Command: systemctl isolate graphical.target

reboot.target
- Reboot system
- Equivalent to: runlevel 6
- Command: systemctl reboot

Commands:

View default:
systemctl get-default

Change default (permanent):
sudo systemctl set-default multi-user.target

Switch target (temporary):
sudo systemctl isolate rescue.target

Check target status:
systemctl status multi-user.target

See what's in target:
systemctl list-dependencies graphical.target
EOF

cat systemd-targets.txt
