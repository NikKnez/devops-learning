# Exercise 1: Tracking Processes with top


## Task 1.1: Understanding top
cat > top-guide.txt << 'EOF'
=== Mastering top Command ===

What is top?
- Real-time process viewer
- Shows CPU, memory, process info
- Updates every 3 seconds (default)
- Interactive - can kill processes, renice, etc.

Starting top:
top           # Basic
top -u nikola # Show only user's processes
top -d 5      # Update every 5 seconds
top -b -n 1   # Batch mode, one iteration (for scripts)

Top Display Sections:

1. SUMMARY (Top 5 lines):
   - System uptime, users, load average
   - Tasks: total, running, sleeping, stopped, zombie
   - CPU usage: us, sy, ni, id, wa, hi, si, st
   - Memory: total, used, free, buffers
   - Swap: total, used, free, cached

2. PROCESS LIST:
   PID    - Process ID
   USER   - Owner
   PR     - Priority
   NI     - Nice value
   VIRT   - Virtual memory
   RES    - Resident memory (actual RAM)
   SHR    - Shared memory
   S      - State (R=running, S=sleeping, Z=zombie)
   %CPU   - CPU usage
   %MEM   - Memory usage
   TIME+  - Total CPU time
   COMMAND - Process name

Interactive Commands Inside top:
h or ? - Help
q      - Quit
k      - Kill process (enter PID)
r      - Renice process
M      - Sort by memory usage
P      - Sort by CPU usage
T      - Sort by time
u      - Filter by user
c      - Show full command path
1      - Show individual CPU cores
z      - Color toggle
W      - Write config to ~/.toprc

CPU States Explained:
us - User space (normal programs)
sy - System/kernel space
ni - Nice (low priority processes)
id - Idle
wa - IO wait (disk/network)
hi - Hardware interrupts
si - Software interrupts
st - Stolen (VMs only)

Load Average:
Three numbers: 1min, 5min, 15min
- 1.00 = 100% CPU usage (1 core)
- On 4-core system:
  * 4.00 = 100% utilized
  * 8.00 = 200% overloaded
- Rule: Load > number of cores = overloaded

Memory Types:
VIRT - Virtual memory allocated (can be > physical RAM)
RES  - Actual physical RAM used
SHR  - Shared with other processes

DevOps Use Cases:
1. Find process eating CPU
2. Find memory leaks
3. Check system load
4. Identify zombies
5. Quick health check
EOF

cat top-guide.txt


## Task 1.2: Practice with top
# Create CPU-intensive script
cat > cpu-hog.sh << 'EOF'
#!/bin/bash
# CPU intensive task
while true; do
    echo "scale=5000; a(1)*4" | bc -l > /dev/null
done
EOF

chmod +x cpu-hog.sh

# Create memory-intensive script
cat > mem-hog.sh << 'EOF'
#!/bin/bash
# Memory intensive task
array=()
while true; do
    array+=("$(seq 1 1000000)")
    sleep 1
done
EOF

chmod +x mem-hog.sh

# Document top usage patterns
cat > top-usage-patterns.sh << 'EOF'
#!/bin/bash

echo "=== top Command Usage Patterns ==="
echo ""

echo "1. Quick system overview:"
echo "   top -b -n 1 | head -20"
echo ""

echo "2. Find top 10 CPU processes:"
echo "   top -b -n 1 | head -17 | tail -10"
echo ""

echo "3. Monitor specific user:"
echo "   top -u username"
echo ""

echo "4. Batch mode for logging:"
echo "   top -b -n 5 > top-log.txt"
echo ""

echo "5. Show individual CPU cores:"
echo "   top (then press '1')"
echo ""

echo "6. Sort by memory:"
echo "   top (then press 'M')"
echo ""

echo "7. Filter processes:"
echo "   top (then press 'o', type 'COMMAND=nginx')"
echo ""

# Run actual top snapshot
echo "Current top snapshot:"
top -b -n 1 | head -20
EOF

chmod +x top-usage-patterns.sh
./top-usage-patterns.sh

# Start CPU hog in background
./cpu-hog.sh &
CPU_PID=$!

# Wait a moment
sleep 3

# Capture top output
echo "=== Top Output with CPU Hog ===" > top-capture.txt
top -b -n 1 >> top-capture.txt

# Show top CPU processes
echo "" >> top-capture.txt
echo "=== Top 5 CPU Processes ===" >> top-capture.txt
top -b -n 1 | head -17 | tail -5 >> top-capture.txt

# Kill CPU hog
kill $CPU_PID

cat top-capture.txt


## Task 1.3: Alternative: htop
cat > htop-vs-top.txt << 'EOF'
=== htop vs top ===

htop Advantages:
- Color-coded display
- Mouse support
- Easier to read
- Shows CPU bars visually
- Tree view of processes
- Easier to kill/renice
- Horizontal/vertical scrolling

Installation:
sudo apt install htop

htop Features:
F1 - Help
F2 - Setup
F3 - Search
F4 - Filter
F5 - Tree view
F6 - Sort by
F9 - Kill process
F10 - Quit

Space - Tag process
U - Untag all
c - Tag with children
H - Hide/show threads
K - Show/hide kernel threads
t - Tree view
/ - Search

htop Keyboard:
M - Sort by memory
P - Sort by CPU
T - Sort by time
u - Filter by user

When to use top vs htop:
top:  Already installed, scripting, remote systems
htop: Interactive work, better UX, when available

Both show same data, htop just presents it better.
EOF

cat htop-vs-top.txt
