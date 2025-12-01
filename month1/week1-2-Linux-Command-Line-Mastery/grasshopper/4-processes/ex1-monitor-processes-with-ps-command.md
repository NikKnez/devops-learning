# Exercise 1: Monitor Processes with ps Command


## Task 1.1: Basic ps Usage
# Show YOUR processes
ps

# Show all processes (BSD style)
ps aux

# Show all processes (UNIX style)
ps -ef

# Show processes in tree format
ps auxf

# Your task: What's the difference in output?
ps aux > ps-aux-output.txt
ps -ef > ps-ef-output.txt

# Compare
head -20 ps-aux-output.txt
head -20 ps-ef-output.txt


## Task 1.2: Understanding ps Output
# Create explanation file
cat > ps-output-explained.txt << 'EOF'
=== ps aux Output Columns ===

USER    = User who owns the process
PID     = Process ID (unique identifier)
%CPU    = CPU usage percentage
%MEM    = Memory usage percentage
VSZ     = Virtual memory size (KB)
RSS     = Resident Set Size - physical memory (KB)
TTY     = Terminal associated with process
        ? = no terminal (daemon/background)
STAT    = Process state
        R = Running
        S = Sleeping (waiting)
        D = Uninterruptible sleep (usually I/O)
        Z = Zombie (terminated but not cleaned up)
        T = Stopped
        < = High priority
        N = Low priority
        s = Session leader
        + = In foreground process group
START   = When process started
TIME    = CPU time used
COMMAND = Command that started process
EOF

cat ps-output-explained.txt


## Task 1.3: Filtering and Searching Processes
# Find specific process by name
ps aux | grep bash

# Find processes by user
ps aux | grep ^nikola

# Find processes using most CPU
ps aux --sort=-%cpu | head -10

# Find processes using most memory
ps aux --sort=-%mem | head -10

# Show only specific columns
ps -eo pid,ppid,user,cmd

# Show process tree
ps -ef --forest

# Your task: Find nginx process (if running)
ps aux | grep nginx

# Find all processes with "python" in name
ps aux | grep python


## Task 1.4: Watching Processes in Real-Time
# Use watch to monitor ps output
watch -n 2 'ps aux | head -20'
# Press Ctrl+C to exit

# Alternative: top command (better for monitoring)
top
# Press 'q' to quit

# htop (if installed, much better UI)
htop
# Press q to quit
# If not installed: sudo apt install htop
