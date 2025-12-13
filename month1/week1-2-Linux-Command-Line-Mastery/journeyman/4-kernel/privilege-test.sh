#!/bin/bash

echo "=== Privilege Level Demonstration ==="
echo ""

echo "1. User Mode Operation (Ring 3):"
echo "   Creating file..."
touch /tmp/userfile.txt
echo "   Success! User mode can access /tmp"
echo ""

echo "2. Attempting Privileged Operation:"
echo "   Trying to write to /proc/sys/kernel/hostname..."
echo "newname" > /proc/sys/kernel/hostname 2>&1
if [ $? -ne 0 ]; then
    echo "   Failed! Cannot modify kernel parameters from user mode"
fi
echo ""

echo "3. With sudo (temporarily elevated):"
echo "   Same operation with sudo..."
sudo bash -c 'echo "test" > /proc/sys/kernel/hostname' 2>/dev/null
if [ $? -eq 0 ]; then
    echo "   Success! Root can modify kernel parameters"
    sudo bash -c 'echo "'$(hostname)'" > /proc/sys/kernel/hostname'
fi
echo ""

echo "This demonstrates kernel protection:"
echo "- User mode: Limited access"
echo "- Kernel mode: Full access"
echo "- System calls bridge the gap"
