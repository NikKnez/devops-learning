# Exercise 2: Kernel Privilege Levels


## Task 2.1: Understanding Ring Levels
cat > privilege-levels.txt << 'EOF'
=== CPU Privilege Levels (Protection Rings) ===

x86 Architecture has 4 rings (0-3):

Ring 0 (Most Privileged) - KERNEL MODE
- Complete hardware access
- All CPU instructions available
- Direct memory access
- I/O port access
- Linux kernel runs here
- Device drivers run here

Ring 1 & 2 (Medium Privilege)
- Rarely used in modern systems
- Originally for device drivers
- Linux doesn't use these

Ring 3 (Least Privileged) - USER MODE
- Restricted access
- Cannot access hardware directly
- Cannot execute privileged instructions
- User applications run here
- Protected from each other

Why Privilege Levels?

1. Security:
   - User code can't crash kernel
   - Processes can't access each other's memory
   - Malware has limited damage potential

2. Stability:
   - Buggy applications can't crash system
   - Kernel protected from user errors
   - System remains operational

3. Isolation:
   - Each process in its own space
   - Fair resource allocation
   - Controlled hardware access

Mode Switching:

User Mode → Kernel Mode:
- System call
- Hardware interrupt
- Exception/fault
- Saves state, switches to ring 0

Kernel Mode → User Mode:
- Return from system call
- Return from interrupt
- Restores state, switches to ring 3

Cost of Context Switching:
- Save all registers
- Switch page tables
- Load new context
- Overhead: microseconds
- Too many = performance hit

Checking Current Mode:
- User processes always ring 3
- Cannot check from user space
- Kernel knows its ring level
EOF

cat privilege-levels.txt


## Task 2.2: Observe Privilege Separation
# Processes run in user mode (ring 3)
ps aux | head -10

# Kernel threads (run in ring 0)
ps aux | grep "\[.*\]" | head -10

# Try to access kernel memory (will fail - protection!)
cat > privilege-test.sh << 'EOF'
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
EOF

chmod +x privilege-test.sh
./privilege-test.sh
rm /tmp/userfile.txt
