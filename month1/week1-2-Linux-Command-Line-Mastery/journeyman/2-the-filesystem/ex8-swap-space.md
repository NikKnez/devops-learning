# Exercise 8: Swap Space


## Task 8.1: Understanding Swap
cat > swap-guide.txt << 'EOF'
=== Linux Swap Space ===

What is Swap?
- Virtual memory extension
- Disk space used as RAM when RAM is full
- Slower than RAM but prevents OOM (Out Of Memory) kills

When is Swap Used?
- RAM is full
- Inactive pages moved to swap
- Hibernation (suspend-to-disk)

Swap Types:
1. Swap Partition - Dedicated disk partition
2. Swap File - Regular file used as swap

How Much Swap?
Old rule: 2x RAM
Modern recommendation:
- RAM <= 2GB:     2x RAM
- RAM 2-8GB:      Equal to RAM
- RAM > 8GB:      8GB or less
- Servers:        Depends on workload

Swap vs No Swap:
With Swap:  System slows but doesn't crash
Without Swap: OOM Killer terminates processes

Swappiness:
- Kernel parameter (0-100)
- How aggressively to use swap
- 0 = Avoid swap unless necessary
- 100 = Use swap aggressively
- Default: 60
- Desktops: 10
- Servers: 1-10
EOF

cat swap-guide.txt


## Task 8.2: Check Current Swap
# Show swap usage
free -h

# Show swap devices
swapon --show

# Detailed swap info
cat /proc/swaps

# Check swappiness value
cat /proc/sys/vm/swappiness

# Create swap report
cat > swap-report.txt << EOF
=== Swap Configuration Report ===

Memory and Swap:
$(free -h)

Swap devices:
$(swapon --show)

Swappiness: $(cat /proc/sys/vm/swappiness)

Total RAM: $(free -h | grep Mem | awk '{print $2}')
Total Swap: $(free -h | grep Swap | awk '{print $2}')
Swap Used: $(free -h | grep Swap | awk '{print $3}')
EOF

cat swap-report.txt


## Task 8.3: Create Swap File (Practice)
# Create swap file creation script
cat > create-swap.sh << 'EOF'
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
EOF

chmod +x create-swap.sh
./create-swap.sh
