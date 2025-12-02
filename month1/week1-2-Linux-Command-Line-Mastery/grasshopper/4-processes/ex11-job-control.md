# Exercise 11: Job Control


## Task 11.1: Foreground and Background Jobs
# Job control works in interactive shells

# Start job in foreground
sleep 30
# Press Ctrl+Z to suspend it

# List jobs
jobs

# Resume in background
bg

# List jobs again
jobs
# Shows [1]+ Running

# Bring back to foreground
fg

# Press Ctrl+C to kill it



## Task 11.2: Managing Multiple Jobs
# Start multiple background jobs
sleep 100 &
sleep 200 &
sleep 300 &

# List all jobs
jobs

# Output example:
# [1]   Running     sleep 100 &
# [2]-  Running     sleep 200 &
# [3]+  Running     sleep 300 &

# Bring specific job to foreground
# fg %1  # Would bring job 1 to foreground

# Kill specific job
kill %1
jobs

# Kill all jobs
kill $(jobs -p)


## Task 11.3: Job Control Commands
cat > job-control-reference.txt << 'EOF'
=== Job Control Commands ===

Starting jobs:
command &           # Start in background
command             # Start in foreground

Suspending:
Ctrl+Z              # Suspend foreground job

Listing jobs:
jobs                # List all jobs
jobs -l             # List with PIDs
jobs -p             # List PIDs only

Resuming jobs:
bg                  # Resume suspended job in background
bg %1               # Resume job 1 in background
fg                  # Bring last job to foreground
fg %2               # Bring job 2 to foreground

Killing jobs:
kill %1             # Kill job 1
kill %2             # Kill job 2

Job references:
%1, %2              # Job number
%%                  # Current job
%+                  # Current job (same as %%)
%-                  # Previous job
%string             # Job starting with "string"

Examples:
fg %sle             # Foreground job starting with "sle"
kill %?ython        # Kill job containing "ython"
EOF

cat job-control-reference.txt


## Task 11.4: Practical Job Control Scenario
# Scenario: Long-running task you need to background

# Start task in foreground (oops, forgot &)
cat > long-task.sh << 'EOF'
#!/bin/bash
for i in {1..60}; do
    echo "Processing... $i"
    sleep 1
done
EOF

chmod +x long-task.sh
./long-task.sh

# After a few seconds, realize you need terminal back
# Press Ctrl+Z (suspends it)

# List jobs
jobs
# Shows: [1]+  Stopped    ./long-task.sh

# Resume in background
bg

# List jobs
jobs
# Shows: [1]+ Running    ./long-task.sh &

# Continue using terminal while task runs
ls
pwd

# Check job status periodically
jobs

# When finished, you'll see:
# [1]+ Done    ./long-task.sh
