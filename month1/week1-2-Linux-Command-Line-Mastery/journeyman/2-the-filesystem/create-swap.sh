#!/bin/bash

# WARNING: Run this only if you need swap
# This is for learning, not production

echo "=== Swap File Creation (Educational) ==="
echo ""
echo "This script shows how to create swap."
echo "DO NOT run on production without understanding!"
echo ""

# Check if running as root
if [ "$EUID" -ne 0 ]; then
   echo "This script needs sudo to run"
   echo "Example commands:"
   echo ""
   echo "1. Create 1GB file:"
   echo "   sudo fallocate -l 1G /swapfile"
   echo "   OR: sudo dd if=/dev/zero of=/swapfile bs=1M count=1024"
   echo ""
   echo "2. Set permissions:"
   echo "   sudo chmod 600 /swapfile"
   echo ""
   echo "3. Format as swap:"
   echo "   sudo mkswap /swapfile"
   echo ""
   echo "4. Enable swap:"
   echo "   sudo swapon /swapfile"
   echo ""
   echo "5. Verify:"
   echo "   swapon --show"
   echo "   free -h"
   echo ""
   echo "6. Make permanent (add to /etc/fstab):"
   echo "   /swapfile none swap sw 0 0"
   echo ""
   echo "7. Disable swap:"
   echo "   sudo swapoff /swapfile"
   echo ""
   echo "8. Remove swap file:"
   echo "   sudo rm /swapfile"
   exit 1
fi
