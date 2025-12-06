# Exercise 5: udev Device Manager


## Task 5.1: Understanding udev
cat > udev-explained.txt << 'EOF'
=== udev Device Manager ===

What is udev?
- Dynamic device management system
- Creates/removes device nodes in /dev
- Loads firmware
- Runs scripts when devices added/removed
- Manages device permissions

How udev works:
1. Kernel detects device
2. Kernel sends uevent
3. udev receives uevent
4. udev creates device node in /dev
5. udev applies rules
6. udev runs configured programs

udev rules:
- Location: /etc/udev/rules.d/, /lib/udev/rules.d/
- Match devices and perform actions
- Set permissions, create symlinks, run scripts

Key commands:
udevadm info    - Query device info
udevadm monitor - Watch udev events
udevadm trigger - Replay events
udevadm control - Control udev daemon

Persistent device names:
- /dev/disk/by-uuid/
- /dev/disk/by-label/
- /dev/disk/by-path/
- /dev/disk/by-id/
EOF

cat udev-explained.txt


## Task 5.2: Query Device Information with udevadm
# Find your main disk device
DISK=$(lsblk -ndo NAME | head -1)
echo "Querying: /dev/$DISK"

# Get detailed udev info
udevadm info /dev/$DISK

# Get specific properties
udevadm info --query=property /dev/$DISK

# Get just the symlinks
udevadm info --query=symlink /dev/$DISK

# Query network device
IFACE=$(ls /sys/class/net/ | grep -v lo | head -1)
udevadm info /sys/class/net/$IFACE


## Task 5.3: Monitor udev Events
# This monitors udev events in real-time
# Run in background and plug/unplug USB device to see events

cat > monitor-udev.sh << 'EOF'
#!/bin/bash

echo "Monitoring udev events..."
echo "Try plugging in a USB device"
echo "Press Ctrl+C to stop"
echo ""

# Monitor all udev events
udevadm monitor

# Or monitor specific subsystems:
# udevadm monitor --subsystem-match=block
# udevadm monitor --subsystem-match=usb
EOF

chmod +x monitor-udev.sh

# Document how to use it
cat > udev-monitoring.txt << 'EOF'
=== Monitoring udev Events ===

To monitor device events:
./monitor-udev.sh

What you'll see:
- KERNEL events (from kernel)
- UDEV events (after udev processes)

Example event:
KERNEL[1234.567890] add /devices/pci.../block/sdb (block)
UDEV  [1234.567900] add /devices/pci.../block/sdb (block)

This shows:
- Action: add
- Device path
- Subsystem: block
EOF

cat udev-monitoring.txt


## Task 5.4: Persistent Device Names
# Show persistent device name directories
ls -l /dev/disk/

# By UUID
ls -l /dev/disk/by-uuid/

# By Label
ls -l /dev/disk/by-label/ 2>/dev/null

# By ID
ls -l /dev/disk/by-id/ | head -10

# By Path
ls -l /dev/disk/by-path/ | head -10

# Find UUID of your root partition
ROOT_DEV=$(df / | tail -1 | awk '{print $1}')
echo "Root device: $ROOT_DEV"

# Get its UUID
sudo blkid $ROOT_DEV

# Document persistent names
cat > persistent-devices.txt << 'EOF'
=== Persistent Device Names ===

Why use them?
- Device names (sda, sdb) can change on reboot
- UUID/Label/ID remain constant
- Critical for /etc/fstab
- Prevent mounting wrong disk

Available methods:
1. by-uuid/   - Unique filesystem identifier
2. by-label/  - Filesystem label (if set)
3. by-id/     - Hardware identifier
4. by-path/   - Physical connection path

Examples from this system:
EOF

ls -l /dev/disk/by-uuid/ 2>/dev/null | head -3 >> persistent-devices.txt

cat persistent-devices.txt
