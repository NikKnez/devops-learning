# Exercise 4: Kernel Logging (dmesg)


## Task 4.1: Understanding Kernel Logs
cat > kernel-logging.txt << 'EOF'
=== Kernel Logging with dmesg ===

What is dmesg?
- Displays kernel ring buffer
- Boot messages
- Hardware detection
- Device driver messages
- Kernel errors/warnings

When to Use dmesg:
- System won't boot properly
- New hardware not detected
- Driver issues
- Kernel panics
- USB device problems

dmesg Output Format:
[timestamp] message

Timestamp:
- Seconds since boot
- Use -T for human-readable

Common Use Cases:
1. Check boot messages
2. USB device detection
3. Disk errors
4. Network card issues
5. Memory problems

Persistent Kernel Logs:
dmesg is in RAM (lost on reboot)
Persistent logs: /var/log/kern.log or /var/log/dmesg
EOF

cat kernel-logging.txt


## Task 4.2: Explore Kernel Messages
# View recent kernel messages
dmesg | tail -50

# Human-readable timestamps
dmesg -T | tail -20

# Colored output (easier to read)
dmesg -T --color=always | tail -20

# Filter by facility
dmesg -f kern | tail -20     # Kernel messages
dmesg -f daemon | tail -20   # Daemon messages

# Filter by level
dmesg -l err     # Errors only
dmesg -l warn    # Warnings only

# Search for specific hardware
dmesg | grep -i usb
dmesg | grep -i network
dmesg | grep -i disk

# Show only new messages since last call
# dmesg -c  # (This clears the buffer, don't run unless needed)

# Save kernel messages to file
dmesg -T > kernel-messages.txt

# Create kernel analysis
cat > kernel-analysis.txt << EOF
=== Kernel Message Analysis ===

Total kernel messages: $(dmesg | wc -l)

Recent messages (last 10):
$(dmesg -T | tail -10)

Errors found:
$(dmesg -l err | wc -l) error messages

Warnings found:
$(dmesg -l warn | wc -l) warning messages

USB related:
$(dmesg | grep -i usb | wc -l) USB messages

Network related:
$(dmesg | grep -i network | wc -l) network messages
EOF

cat kernel-analysis.txt


## Task 4.3: Hardware Detection with dmesg
# Create hardware detection script
cat > hardware-detect.sh << 'EOF'
#!/bin/bash

echo "=== Hardware Detection via Kernel Logs ==="
echo ""

echo "1. CPU Detection:"
dmesg | grep -i "cpu" | head -3

echo ""
echo "2. Memory Detection:"
dmesg | grep -i "memory" | head -3

echo ""
echo "3. Disk Detection:"
dmesg | grep -E "sd[a-z]|nvme" | head -5

echo ""
echo "4. Network Interfaces:"
dmesg | grep -i "eth\|wlan\|network" | grep -i "link\|up" | head -5

echo ""
echo "5. USB Devices:"
dmesg | grep -i "usb" | grep -i "new\|detected" | tail -5

echo ""
echo "6. Recent Errors:"
dmesg -l err | tail -5

echo ""
echo "7. Boot Time:"
echo "System booted: $(uptime -s)"
echo "Uptime: $(uptime -p)"
EOF

chmod +x hardware-detect.sh
./hardware-detect.sh
