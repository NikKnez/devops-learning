# Exercise 4: sysfs Filesystem


## Task 4.1: Understanding sysfs
cat > sysfs-explained.txt << 'EOF'
=== sysfs Filesystem (/sys) ===

What is sysfs?
- Virtual filesystem mounted at /sys
- Exposes kernel objects to userspace
- Information about devices and drivers
- Can configure some kernel parameters

Structure:
/sys/block/       - Block devices
/sys/bus/         - Bus types (pci, usb, etc.)
/sys/class/       - Device classes
/sys/devices/     - Physical devices tree
/sys/firmware/    - Firmware info
/sys/kernel/      - Kernel parameters
/sys/module/      - Loaded modules
/sys/power/       - Power management

Purpose:
- Device discovery
- Hardware information
- Driver information
- Runtime configuration

vs /proc:
- /proc: Process info + some kernel info
- /sys: Device and driver info
EOF

cat sysfs-explained.txt


## Task 4.2: Explore sysfs
# Main sysfs directories
ls /sys

# Block devices
ls /sys/block/

# Show info about your main disk
ls /sys/block/sda/ 2>/dev/null || ls /sys/block/nvme* 2>/dev/null | head -1

# Device classes
ls /sys/class/

# Network devices
ls /sys/class/net/

# Your network interface info
IFACE=$(ls /sys/class/net/ | grep -v lo | head -1)
echo "Network interface: $IFACE"
ls /sys/class/net/$IFACE/

# Read some device properties
cat /sys/class/net/$IFACE/address 2>/dev/null # MAC address
cat /sys/class/net/$IFACE/mtu 2>/dev/null     # MTU size


## Task 4.3: Device Information from sysfs
# Find your disk in sysfs
DISK=$(lsblk -ndo NAME | head -1)
echo "Main disk: $DISK"

# Disk information from sysfs (if available)
if [ -d /sys/block/$DISK ]; then
    echo "Size: $(cat /sys/block/$DISK/size 2>/dev/null) sectors"
    echo "Removable: $(cat /sys/block/$DISK/removable 2>/dev/null)"
    echo "Read-only: $(cat /sys/block/$DISK/ro 2>/dev/null)"
fi

# USB devices
ls /sys/bus/usb/devices/ 2>/dev/null

# PCI devices
ls /sys/bus/pci/devices/ | head -10

# CPU information from sysfs
ls /sys/devices/system/cpu/

# Create sysfs exploration document
cat > sysfs-exploration.txt << EOF
=== sysfs Exploration ===

Network interfaces:
$(ls /sys/class/net/)

Block devices:
$(ls /sys/block/)

CPU info:
$(ls /sys/devices/system/cpu/ | grep cpu[0-9])

Bus types:
$(ls /sys/bus/)
EOF

cat sysfs-exploration.txt
