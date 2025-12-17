#!/bin/bash

echo "=== Hardware Detection via Kernel Logs ==="
echo ""

echo "1. CPU Detection:"
sudo dmesg | grep -i "cpu" | head -3

echo ""
echo "2. Memory Detection:"
sudo dmesg | grep -i "memory" | head -3

echo ""
echo "3. Disk Detection:"
sudo dmesg | grep -E "sd[a-z]|nvme" | head -5

echo ""
echo "4. Network Interfaces:"
sudo dmesg | grep -i "eth\|wlan\|network" | grep -i "link\|up" | head -5

echo ""
echo "5. USB Devices:"
sudo dmesg | grep -i "usb" | grep -i "new\|detected" | tail -5

echo ""
echo "6. Recent Errors:"
sudo dmesg -l err | tail -5

echo ""
echo "7. Boot Time:"
echo "System booted: $(uptime -s)"
echo "Uptime: $(uptime -p)"
