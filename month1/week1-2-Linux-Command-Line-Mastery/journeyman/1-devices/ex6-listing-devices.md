# Exercise 6: Listing Devices


## Task 6.1: lsblk Command
# Basic lsblk
lsblk

# With filesystem info
lsblk -f

# With more details
lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,UUID

# Show all columns available
lsblk --help | grep -A 50 "Available columns"

# Tree view with sizes
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT

# Create device report
cat > lsblk-report.txt << EOF
=== Block Device Report ===

Basic layout:
$(lsblk)

With filesystem info:
$(lsblk -f)

Detailed info:
$(lsblk -o NAME,SIZE,TYPE,FSTYPE,MOUNTPOINT,LABEL,UUID)
EOF

cat lsblk-report.txt


## Task 6.2: Other Device Listing Commands
# List USB devices
lsusb

# Detailed USB info
lsusb -v | head -50

# List PCI devices
lspci

# Detailed PCI info
lspci -v | head -50

# List CPU info
lscpu

# Hardware info (if available)
sudo lshw -short 2>/dev/null || echo "lshw not installed"

# DMI/SMBIOS info
sudo dmidecode -t system 2>/dev/null || echo "dmidecode not available"

# Create hardware inventory
cat > hardware-inventory.txt << EOF
=== Hardware Inventory ===

Block devices:
$(lsblk -o NAME,SIZE,TYPE)

USB devices:
$(lsusb)

PCI devices:
$(lspci | head -10)

CPU:
$(lscpu | grep -E "Model name|CPU\(s\)|Thread|Core")
EOF

cat hardware-inventory.txt


## Task 6.3: Find Specific Device Information
# Find your network card
lspci | grep -i network

# Find graphics card
lspci | grep -i vga

# Find USB controllers
lspci | grep -i usb

# List input devices
ls /dev/input/
cat /proc/bus/input/devices | head -30

# Show mounted filesystems
mount | column -t

# Show all filesystems (mounted and unmounted)
sudo blkid

# Create device summary
cat > device-summary.sh << 'EOF'
#!/bin/bash

echo "=== Quick Device Summary ==="
echo ""

echo "Block Devices:"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT

echo ""
echo "Mounted Filesystems:"
df -h | grep -E "Filesystem|^/dev"

echo ""
echo "Network Interfaces:"
ip -br addr

echo ""
echo "USB Devices:"
lsusb | wc -l
echo "devices connected"
EOF

chmod +x device-summary.sh
./device-summary.sh
