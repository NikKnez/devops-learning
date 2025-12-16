# Exercise 3: Process Threads


## Task 3.1: Understanding Threads
cat > threads-guide.txt << 'EOF'
=== Process Threads ===

What are Threads?
- Lightweight sub-processes
- Share same memory space
- Run concurrently within process
- Cheaper than creating new process

Process vs Thread:
Process:
- Own memory space
- Own resources
- Heavy to create
- Isolated from other processes

Thread:
- Shares process memory
- Shares resources
- Light to create
- Can affect other threads

Why Threads Matter in DevOps:
1. Web servers (Nginx, Apache) use threads
2. Database connections are threads
3. High CPU usage might be one thread
4. Thread leaks cause performance issues

Viewing Threads:

With top:
- top (press 'H' to toggle threads view)
- Each thread shown separately

With ps:
ps -eLf                 # All threads
ps -eL                  # Thread info
ps -T -p PID            # Threads for specific process
ps -p PID -L            # Threads with details

With htop:
- htop (press 'H' to toggle threads)
- Shows threads in tree view

Thread States:
Same as processes: R, S, D, Z, T

Thread Info Columns:
PID    - Process ID
TID    - Thread ID
NLWP   - Number of threads
LWP    - Light Weight Process (thread) ID

Common Thread Issues:

1. Thread Leak:
   - Threads created but not destroyed
   - Memory slowly increases
   - Eventually OOM

2. Thread Contention:
   - Multiple threads competing for resource
   - Slow performance
   - High CPU but low throughput

3. Deadlock:
   - Threads waiting for each other
   - System hangs
   - Requires restart

Finding Thread Info:
cat /proc/PID/status | grep Threads
ls /proc/PID/task/        # One directory per thread
top -H -p PID             # Monitor threads for process
EOF

cat threads-guide.txt


## Task 3.2: Explore Threads
# Create multi-threaded script
cat > threaded-script.sh << 'EOF'
#!/bin/bash

echo "Creating processes with threads..."

# Start some background jobs (each is a thread)
sleep 100 &
P1=$!
sleep 100 &
P2=$!
sleep 100 &
P3=$!

echo "Started processes: $P1, $P2, $P3"
echo ""

# Show threads for current shell
echo "Threads in current shell:"
ps -T -p $$ | head -5

echo ""
echo "Thread count for bash:"
ps -o pid,nlwp,cmd -p $$ | head -5

# Cleanup
kill $P1 $P2 $P3 2>/dev/null
wait 2>/dev/null
EOF

chmod +x threaded-script.sh
./threaded-script.sh

# Check threads for init/systemd (PID 1)
echo "" >> thread-analysis.txt
echo "=== Thread Analysis ===" > thread-analysis.txt
echo "Systemd threads:" >> thread-analysis.txt
ps -T -p 1 2>/dev/null | head -10 >> thread-analysis.txt || echo "Cannot access PID 1" >> thread-analysis.txt

# Find processes with most threads
echo "" >> thread-analysis.txt
echo "=== Processes with Most Threads ===" >> thread-analysis.txt
ps -eo pid,nlwp,cmd --sort=-nlwp | head -10 >> thread-analysis.txt

cat thread-analysis.txt
