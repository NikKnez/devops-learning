# Exercise 4: Process Creation (fork and exec)


## Task 4.1: Understanding Process Creation
# Create explanation
cat > process-creation.txt << 'EOF'
=== How Processes Are Created ===

1. fork()
   - Creates exact copy of parent process
   - Parent and child are identical
   - Child gets new PID

2. exec()
   - Replaces current process with new program
   - Same PID, different program

3. Common pattern: fork() + exec()
   - Shell forks itself
   - Child execs the command you typed
   - Parent waits for child

Example: When you run "ls"
1. bash forks → creates child bash
2. Child execs ls → becomes ls process
3. Parent waits for ls to complete
4. ls finishes, parent continues
EOF

cat process-creation.txt


## Task 4.2: Observe Process Creation
# Start a long-running process in background
sleep 100 &

# Note its PID
echo "Sleep process PID: $!"

# Check parent-child relationship
ps -f -p $! -p $$

# The sleep process:
# - Was forked from bash (your shell)
# - PPID = your shell's PID

# Kill it when done
kill $!


## Task 4.3: Chain of Process Creation
# Create script that spawns child processes
cat > spawn-test.sh << 'EOF'
#!/bin/bash

echo "Parent: $$"

# Spawn child process
bash -c 'echo "Child: $$, Parent: $PPID"; sleep 5' &
CHILD_PID=$!

echo "Spawned child: $CHILD_PID"

# Show relationship
ps -f -p $$ -p $CHILD_PID

wait $CHILD_PID
echo "Child finished"
EOF

chmod +x spawn-test.sh
./spawn-test.sh
