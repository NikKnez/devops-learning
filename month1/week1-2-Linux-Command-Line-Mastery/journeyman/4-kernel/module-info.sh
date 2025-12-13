#!/bin/bash

echo "=== Kernel Module Information ==="
echo ""

# Pick a common module
MODULE="e1000e"  # Intel ethernet driver

echo "Module: $MODULE"
echo ""

# Check if loaded
if lsmod | grep -q "^$MODULE"; then
    echo "Status: LOADED"
    echo ""
    lsmod | grep "^$MODULE"
else
    echo "Status: Not loaded"
fi

echo ""
echo "Module Information:"
modinfo $MODULE 2>/dev/null | head -15

echo ""
echo "Module Location:"
find /lib/modules/$(uname -r) -name "$MODULE.ko*" 2>/dev/null

echo ""
echo "=== Common Useful Modules ==="
echo ""

modules=("usbcore" "ext4" "nf_conntrack" "ip_tables")

for mod in "${modules[@]}"; do
    if lsmod | grep -q "^$mod"; then
        echo "✓ $mod - LOADED"
    else
        echo "✗ $mod - not loaded"
    fi
done
