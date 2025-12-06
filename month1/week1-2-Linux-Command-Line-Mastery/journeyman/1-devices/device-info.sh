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
