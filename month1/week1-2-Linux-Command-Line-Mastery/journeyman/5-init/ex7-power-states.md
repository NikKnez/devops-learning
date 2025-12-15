# Exercise 7: Power States


## Task 7.1: Understanding Power Management
cat > power-states.txt << 'EOF'
=== Linux Power States ===

Power Management Types:

1. SHUTDOWN (Poweroff)
   - System completely off
   - Power removed from hardware
   - Full boot required to start
   - Command: systemctl poweroff

2. REBOOT
   - Shutdown and restart
   - Loads kernel fresh
   - All services restart
   - Command: systemctl reboot

3. SUSPEND (Sleep / Suspend-to-RAM)
   - Low power state
   - RAM powered (keeps state)
   - CPU and disk off
   - Quick wake (seconds)
   - Loses state if power lost
   - Command: systemctl suspend

4. HIBERNATE (Suspend-to-Disk)
   - Saves RAM to disk (swap)
   - Completely powers off
   - Restores state on boot
   - Slower than suspend
   - Survives power loss
   - Requires swap space >= RAM
   - Command: systemctl hibernate

5. HYBRID SLEEP
   - Suspends AND hibernates
   - Quick wake like suspend
   - Safe like hibernate
   - Best of both worlds
   - Command: systemctl hybrid-sleep

6. SUSPEND-THEN-HIBERNATE
   - Suspends first (quick)
   - Hibernates after timeout
   - Saves battery
   - Command: systemctl suspend-then-hibernate

Power State Comparison:

State       Speed   Power   Data Safe   Requires
-----       -----   -----   ---------   --------
Suspend     Fast    Low     No          -
Hibernate   Slow    None    Yes         Swap
Hybrid      Fast    Low     Yes         Swap
Poweroff    N/A     None    Yes         -

Systemd Power Commands:
systemctl poweroff            # Shut down
systemctl reboot              # Restart
systemctl suspend             # Sleep
systemctl hibernate           # Hibernate
systemctl hybrid-sleep        # Hybrid
systemctl suspend-then-hibernate  # Combo

Legacy Commands (still work):
shutdown -h now     → systemctl poweroff
shutdown -r now     → systemctl reboot
halt                → systemctl halt
poweroff            → systemctl poweroff
reboot              → systemctl reboot

Scheduled Shutdown:
shutdown -h +10          # Shutdown in 10 minutes
shutdown -h 20:00        # Shutdown at 8 PM
shutdown -r +5 "Reboot"  # With message
shutdown -c              # Cancel shutdown

ACPI Events:
- Power button pressed
- Lid closed
- Battery low
- Configured in /etc/systemd/logind.conf
EOF

cat power-states.txt


## Task 7.2: Power Management Practice
# Check available power states
cat /sys/power/state

# Check if hibernate is available
systemctl hibernate --dry-run 2>&1

# Check power management configuration
cat /etc/systemd/logind.conf | grep -E "HandlePower|HandleLid|HandleSuspend"

# Create power management guide
cat > power-management.sh << 'EOF'
#!/bin/bash

echo "=== Power Management Operations ==="
echo ""
echo "SAFE operations (won't shut down):"
echo ""
echo "Check shutdown status:"
echo "  systemctl is-system-running"
echo ""
echo "List shutdown jobs:"
echo "  systemctl list-jobs"
echo ""
echo "DANGEROUS operations (actually power off):"
echo ""
echo "Shutdown now:"
echo "  sudo systemctl poweroff"
echo ""
echo "Reboot now:"
echo "  sudo systemctl reboot"
echo ""
echo "Shutdown in 10 minutes with warning:"
echo "  sudo shutdown -h +10 'System maintenance'"
echo ""
echo "Cancel scheduled shutdown:"
echo "  sudo shutdown -c"
echo ""
echo "Suspend (sleep):"
echo "  sudo systemctl suspend"
echo ""
echo "Hibernate (if swap configured):"
echo "  sudo systemctl hibernate"
echo ""
echo "DO NOT RUN THESE COMMANDS on a system you're using!"
echo "Only run on test VMs or with intention."
EOF

chmod +x power-management.sh
./power-management.sh


## Task 7.3: Check System Uptime and Boot Info
# System uptime
uptime

# Last boot time
who -b

# System boot history
last reboot | head -10

# Analyze boot process
systemd-analyze

# Critical services boot time
systemd-analyze critical-chain

# Create boot report
cat > boot-report.txt << EOF
=== System Boot and Uptime Report ===

Current uptime:
$(uptime)

Last boot:
$(who -b)

Boot time analysis:
$(systemd-analyze)

Critical chain (boot dependencies):
$(systemd-analyze critical-chain | head -15)

Recent reboot history:
$(last reboot | head -5)

System state:
$(systemctl is-system-running)
EOF

cat boot-report.txt
