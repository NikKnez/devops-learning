# Exercise 6: Systemd Targets (Runlevels)


## Task 6.1: Understanding Targets
cat > systemd-targets.txt << 'EOF'
=== Systemd Targets (vs SysV Runlevels) ===

What are Targets?
- Groupings of units
- Similar to SysV runlevels
- More flexible (can have multiple)
- Can depend on other targets

SysV Runlevel → Systemd Target:

Runlevel 0 → poweroff.target (Shut down)
Runlevel 1 → rescue.target (Single-user)
Runlevel 2,3,4 → multi-user.target (Multi-user, CLI)
Runlevel 5 → graphical.target (Multi-user, GUI)
Runlevel 6 → reboot.target (Reboot)

Common Targets:

default.target
- Symlink to actual target
- Usually multi-user or graphical

multi-user.target
- Multi-user system
- Command-line interface
- Network enabled
- Similar to runlevel 3

graphical.target
- Multi-user with GUI
- Includes multi-user.target
- Starts display manager
- Similar to runlevel 5

rescue.target
- Single-user maintenance mode
- Minimal services
- Similar to runlevel 1

emergency.target
- Most minimal environment
- Root filesystem only
- For emergency repairs

Target Commands:
systemctl get-default              # Show default target
systemctl set-default TARGET       # Set default target
systemctl list-units --type=target # List active targets
systemctl isolate TARGET           # Switch to target now

Target Files:
/lib/systemd/system/*.target
/etc/systemd/system/*.target

Example: multi-user.target requires:
- basic.target
- Allows networking
- Allows system login
- Does NOT require graphical.target
EOF

cat systemd-targets.txt


## Task 6.2: Explore Targets
# Show current target
systemctl get-default

# List all targets
systemctl list-units --type=target

# Show what default target requires
systemctl list-dependencies default.target

# Show graphical target dependencies
systemctl list-dependencies graphical.target | head -20

# Create target analysis
cat > target-analysis.txt << EOF
=== Target Analysis ===

Current default target:
$(systemctl get-default)

Active targets:
$(systemctl list-units --type=target --state=active)

Default target dependencies (first 15):
$(systemctl list-dependencies $(systemctl get-default) | head -15)

Graphical vs Multi-user:
$(systemctl list-dependencies graphical.target | grep multi-user)

System is in:
$(systemctl list-units --type=target --state=active | grep -E "multi-user|graphical")
EOF

cat target-analysis.txt


## Task 6.3: Target Management Practice
# Create target management guide
cat > target-management.sh << 'EOF'
#!/bin/bash

echo "=== Systemd Target Management ==="
echo ""
echo "Current default target: $(systemctl get-default)"
echo ""

echo "Common Operations:"
echo ""
echo "1. Switch to multi-user (CLI only):"
echo "   sudo systemctl isolate multi-user.target"
echo ""
echo "2. Switch to graphical (GUI):"
echo "   sudo systemctl isolate graphical.target"
echo ""
echo "3. Set default to multi-user:"
echo "   sudo systemctl set-default multi-user.target"
echo ""
echo "4. Set default to graphical:"
echo "   sudo systemctl set-default graphical.target"
echo ""
echo "5. Boot into rescue mode (next boot):"
echo "   sudo systemctl reboot --rescue"
echo ""
echo "6. Boot into emergency mode (next boot):"
echo "   sudo systemctl reboot --emergency"
echo ""
echo "Note: Changing targets affects running system!"
echo "Use with caution on production systems."
EOF

chmod +x target-management.sh
./target-management.sh
