# Exercise 3: Process Details and Hierarchy


## Task 3.1: Process Parent-Child Relationships
# Every process has a parent (except PID 1)

# Your shell and its parent
ps -f -p $$

# Show process tree
pstree

# Show detailed tree with PIDs
pstree -p

# Show tree for specific user
pstree nikola

# Find parent of a process
ps -o pid,ppid,cmd -p $$

# Your task: Trace your current process back to init
ps -ef --forest | grep $$


## Task 3.2: Detailed Process Information
# Full details of your shell
ps -fp $$

# All details of bash processes
ps -f -C bash

# Custom output format
ps -eo pid,ppid,user,pri,ni,vsz,rss,stat,start,time,cmd | head -20

# Process command line arguments
cat /proc/$$/cmdline | tr '\0' ' '
echo ""

# Process environment variables
cat /proc/$$/environ | tr '\0' '\n' | head -20


## Task 3.3: Process Relationships Exercise
# Create a script that shows process hierarchy
cat > process-tree.sh << 'EOF'
#!/bin/bash

echo "=== Process Hierarchy Analysis ==="
echo ""
echo "Current process (this script): $$"
echo "Parent process (shell): $PPID"
echo ""

# Show full ancestry
echo "Process ancestry:"
ps -o pid,ppid,cmd -p $$ -p $PPID

echo ""
echo "Full process tree:"
pstree -p $$
EOF

chmod +x process-tree.sh
./process-tree.sh
