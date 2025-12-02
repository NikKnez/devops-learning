# Exercise 6: Process Signals


## Task 6.1: Understanding Signals
# List all available signals
kill -l

# Create signal reference
cat > signals-reference.txt << 'EOF'
=== Common Linux Signals ===

SIGTERM (15) - Terminate gracefully (default for kill)
  - Process can catch and cleanup
  - Polite way to ask process to exit

SIGKILL (9) - Kill immediately (cannot be caught)
  - Process dies instantly, no cleanup
  - Use as last resort

SIGINT (2) - Interrupt (Ctrl+C)
  - User interruption from keyboard
  - Process can catch and handle

SIGHUP (1) - Hangup
  - Terminal closed
  - Often used to reload config

SIGSTOP (19) - Stop/pause (cannot be caught)
  - Freezes process

SIGCONT (18) - Continue
  - Resumes stopped process

SIGQUIT (3) - Quit and dump core (Ctrl+\)

Usage:
kill -TERM pid    # Graceful termination
kill -9 pid       # Force kill
kill -HUP pid     # Reload config
kill -STOP pid    # Pause
kill -CONT pid    # Resume
EOF

cat signals-reference.txt


## Task 6.2: Sending Signals
# Start long-running process
sleep 60 &
PID=$!
echo "Started process: $PID"

# Send SIGSTOP (pause it)
kill -STOP $PID
ps -p $PID -o pid,stat,cmd
# Should show T (stopped)

# Send SIGCONT (resume it)
kill -CONT $PID
ps -p $PID -o pid,stat,cmd
# Should show S (sleeping)

# Send SIGTERM (graceful termination)
kill -TERM $PID
# or just: kill $PID

# Verify it's gone
ps -p $PID
# Should say "no such process"


## Task 6.3: Signal Handling Script
# Create script that catches signals
cat > signal-handler.sh << 'EOF'
#!/bin/bash

# Function to handle signals
cleanup() {
    echo ""
    echo "Received signal, cleaning up..."
    echo "Goodbye!"
    exit 0
}

# Trap signals
trap cleanup SIGINT SIGTERM

echo "Process PID: $$"
echo "Try to interrupt me with Ctrl+C"
echo "Or from another terminal: kill $$"
echo ""

# Infinite loop
while true; do
    echo "Working... ($(date))"
    sleep 2
done
EOF

chmod +x signal-handler.sh

# Run it (press Ctrl+C to test signal handling)
./signal-handler.sh

# Or test from another terminal:
# kill -TERM [PID]
