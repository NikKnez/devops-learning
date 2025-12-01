# Exercise 5: Process Termination


## Task 5.1: Normal Process Exit
# Process can exit in several ways:
# 1. Normal completion (exit 0)
# 2. Error exit (exit 1-255)
# 3. Killed by signal
# 4. Segmentation fault (crash)

# Create test scripts
cat > exit-success.sh << 'EOF'
#!/bin/bash
echo "Doing work..."
sleep 1
echo "Success!"
exit 0
EOF

cat > exit-failure.sh << 'EOF'
#!/bin/bash
echo "Attempting something..."
sleep 1
echo "Failed!"
exit 1
EOF

chmod +x exit-success.sh exit-failure.sh

# Run and check exit codes
./exit-success.sh
echo "Exit code: $?"

./exit-failure.sh
echo "Exit code: $?"


## Task 5.2: Zombie Processes
# Create zombie demonstration
cat > create-zombie.sh << 'EOF'
#!/bin/bash

# Fork a child that exits immediately
bash -c 'exit 0' &
CHILD_PID=$!

# Parent doesn't wait (doesn't call wait)
# Child becomes zombie for a short time

echo "Child PID: $CHILD_PID"
echo "Check for zombie (Z state):"
ps -p $CHILD_PID -o pid,stat,cmd

# Sleep to keep zombie alive
sleep 2

# Now wait and clean up
wait $CHILD_PID
echo "Zombie cleaned up"
EOF

chmod +x create-zombie.sh
./create-zombie.sh


## Task 5.3: Understanding Zombie Processes
cat > zombie-explanation.txt << 'EOF'
=== Zombie Processes ===

What is a zombie?
- Process that finished executing
- Exit status not yet collected by parent
- Shows as "Z" or "<defunct>" in ps

Why do they exist?
- Parent needs to read child's exit status
- Until parent calls wait(), child remains zombie

How to identify:
ps aux | grep 'Z'

How to fix:
1. Parent process calls wait() → zombie cleaned up
2. Kill parent process → init adopts and cleans zombies
3. Cannot kill zombie directly (already dead)

Are they harmful?
- Use minimal resources (just PID table entry)
- Too many zombies can exhaust PID space
- Usually indicates buggy parent process
EOF

cat zombie-explanation.txt
