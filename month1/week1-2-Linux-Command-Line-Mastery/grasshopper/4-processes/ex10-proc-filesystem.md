# Exercise 10: /proc Filesystem


## Task 10.1: Understanding /proc
cat > proc-filesystem.txt << 'EOF'
=== /proc Filesystem ===

What is /proc?
- Virtual filesystem (not on disk)
- Kernel exposes process info through files
- Each process has /proc/[PID] directory

Important files in /proc/[PID]:
- cmdline  = Command line arguments
- environ  = Environment variables
- status   = Process status (detailed)
- fd/      = Open file descriptors
- cwd      = Current working directory (symlink)
- exe      = Executable file (symlink)
- maps     = Memory mappings
- stat     = Process statistics

System-wide info:
- /proc/cpuinfo  = CPU information
- /proc/meminfo  = Memory information
- /proc/uptime   = System uptime
- /proc/loadavg  = Load average
EOF

cat proc-filesystem.txt


## Task 10.2: Explore /proc for Your Shell
# Your shell's PID
echo "My shell PID: $$"

# Command line
echo "Command line:"
cat /proc/$$/cmdline | tr '\0' ' '
echo ""

# Environment variables (first 10)
echo "Environment (first 10):"
cat /proc/$$/environ | tr '\0' '\n' | head -10

# Status file
echo "Process status:"
cat /proc/$$/status | head -20

# Current working directory
echo "Working directory:"
ls -l /proc/$$/cwd

# Executable
echo "Executable:"
ls -l /proc/$$/exe

# Open file descriptors
echo "Open files:"
ls -l /proc/$$/fd/


## Task 10.3: System Information from /proc
# CPU information
echo "=== CPU Info ===" > system-info.txt
cat /proc/cpuinfo | grep "model name" | head -1 >> system-info.txt

# Memory information
echo "" >> system-info.txt
echo "=== Memory Info ===" >> system-info.txt
cat /proc/meminfo | head -5 >> system-info.txt

# System uptime
echo "" >> system-info.txt
echo "=== Uptime ===" >> system-info.txt
cat /proc/uptime >> system-info.txt

# Load average
echo "" >> system-info.txt
echo "=== Load Average ===" >> system-info.txt
cat /proc/loadavg >> system-info.txt

cat system-info.txt


## Task 10.4: Monitor Process in /proc
# Start long-running process
sleep 200 &
PID=$!

# Create monitoring script
cat > monitor-process.sh << EOF
#!/bin/bash
PID=$PID

while ps -p \$PID > /dev/null; do
    clear
    echo "=== Monitoring Process \$PID ==="
    echo ""
    echo "Status:"
    cat /proc/\$PID/status | grep -E 'Name|State|VmSize|VmRSS|Threads'
    echo ""
    echo "File descriptors:"
    ls -l /proc/\$PID/fd/ 2>/dev/null | wc -l
    echo ""
    sleep 2
done

echo "Process finished"
EOF

chmod +x monitor-process.sh
# Run this in another terminal or background
# ./monitor-process.sh

# Kill the sleep process when done
kill $PID
