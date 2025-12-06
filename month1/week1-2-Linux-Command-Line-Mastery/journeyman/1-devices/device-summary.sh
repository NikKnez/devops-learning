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
