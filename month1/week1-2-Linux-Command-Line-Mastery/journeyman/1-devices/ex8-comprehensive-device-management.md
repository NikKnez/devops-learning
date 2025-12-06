# Exercise 8: Comprehensive Device Management


## Task 8.1: Create Device Information Script
cat > device-info.sh << 'EOF'
#!/bin/bash

echo "==================================="
echo "   Device Information Summary"
echo "==================================="
echo ""

echo "1. Block Devices:"
echo "-----------------"
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,FSTYPE

echo ""
echo "2. Disk Usage:"
echo "--------------"
df -h | grep -E "Filesystem|^/dev"

echo ""
echo "3. USB Devices:"
echo "---------------"
lsusb | wc -l
echo "USB devices connected"

echo ""
echo "4. Network Interfaces:"
echo "----------------------"
ip -br addr

echo ""
echo "5. Device Files in /dev:"
echo "------------------------"
echo "Block devices: $(ls -l /dev | grep "^b" | wc -l)"
echo "Character devices: $(ls -l /dev | grep "^c" | wc -l)"

echo ""
echo "6. Current Terminal:"
echo "--------------------"
tty

echo ""
echo "7. Memory Devices:"
echo "------------------"
ls -lh /dev/null /dev/zero /dev/random /dev/urandom

echo ""
echo "8. System Uptime:"
echo "-----------------"
uptime

echo ""
echo "==================================="
EOF

chmod +x device-info.sh
./device-info.sh


## Task 8.2: Device Troubleshooting Guide
cat > device-troubleshooting.txt << 'EOF'
=== Device Troubleshooting Guide ===

PROBLEM: USB device not detected
CHECK:
1. lsusb - Is device listed?
2. dmesg | tail - Any errors?
3. ls /dev/sd* - New device appeared?
4. udevadm monitor - Watch for events while plugging in

PROBLEM: Disk not mounting
CHECK:
1. lsblk - Is disk visible?
2. sudo fdisk -l - Partitions present?
3. sudo blkid - Filesystem detected?
4. dmesg | grep sd - Any error messages?
5. mount - Already mounted elsewhere?

PROBLEM: Permission denied on device
CHECK:
1. ls -l /dev/device - What permissions?
2. groups - Are you in right group?
3. sudo usermod -aG group user - Add to group

PROBLEM: Device disappeared
CHECK:
1. dmesg | tail - Kernel messages
2. journalctl -xe - System logs
3. lsblk - Still visible?
4. udevadm info /dev/device - Device info

USEFUL COMMANDS:
dmesg           - Kernel ring buffer (device messages)
journalctl -f   - Follow system log
udevadm monitor - Watch device events
lsblk           - List block devices
lsusb           - List USB devices
lspci           - List PCI devices
EOF

cat device-troubleshooting.txt
