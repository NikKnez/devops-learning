# Exercise 9: Process States


## Task 9.1: Understanding Process States
cat > process-states.txt << 'EOF'
=== Linux Process States ===

R = Running or Runnable
    - Currently executing on CPU
    - Or waiting in run queue

S = Sleeping (Interruptible)
    - Waiting for event (I/O, timer, signal)
    - Can be interrupted by signals
    - Most common state

D = Uninterruptible Sleep
    - Waiting for I/O (disk, network)
    - Cannot be interrupted by signals
    - Cannot be killed (wait for I/O to finish)

Z = Zombie
    - Terminated but not cleaned up by parent
    - Waiting for parent to collect exit status

T = Stopped
    - Process suspended (Ctrl+Z or SIGSTOP)
    - Can be resumed with SIGCONT or 'fg'

Additional modifiers:
< = High priority (nice < 0)
N = Low priority (nice > 0)
L = Has pages locked in memory
s = Session leader
l = Multi-threaded
+ = In foreground process group
EOF

cat process-states.txt


## Task 9.2: Observing Different States
# Create processes in different states

# State: S (Sleeping)
sleep 100 &
SLEEP_PID=$!
ps -o pid,stat,cmd -p $SLEEP_PID

# State: T (Stopped)
sleep 100 &
STOP_PID=$!
kill -STOP $STOP_PID
ps -o pid,stat,cmd -p $STOP_PID

# State: R (Running) - hard to catch, let's try
cat > cpu-hog.sh << 'EOF'
#!/bin/bash
while true; do
    : # Do nothing, but do it a lot
done
EOF
chmod +x cpu-hog.sh
./cpu-hog.sh &
CPU_PID=$!

# Check states quickly
ps -o pid,stat,cmd -p $SLEEP_PID -p $STOP_PID -p $CPU_PID

# Clean up
kill $SLEEP_PID $STOP_PID $CPU_PID


## Task 9.3: State Transition Exercise
# Watch a process change states

# Start process (S state)
sleep 100 &
PID=$!
echo "State after starting:"
ps -o pid,stat,cmd -p $PID

# Stop it (T state)
kill -STOP $PID
echo "State after SIGSTOP:"
ps -o pid,stat,cmd -p $PID

# Continue it (back to S state)
kill -CONT $PID
echo "State after SIGCONT:"
ps -o pid,stat,cmd -p $PID

# Terminate it (will briefly become Z, then disappear)
kill $PID
echo "State after SIGTERM (might see Z briefly):"
ps -o pid,stat,cmd -p $PID 2>/dev/null || echo "Process gone"
