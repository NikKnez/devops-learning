# Exercise 7: Killing Processes


## Task 7.1: Different Ways to Kill
# Start test processes
sleep 100 &
PID1=$!
sleep 100 &
PID2=$!
sleep 100 &
PID3=$!

echo "Started processes: $PID1 $PID2 $PID3"

# Method 1: kill by PID
kill $PID1
echo "Killed PID $PID1"

# Method 2: kill by name (killall)
killall sleep
echo "Killed all 'sleep' processes"

# Method 3: pkill (pattern matching)
sleep 100 &
pkill -f "sleep 100"
echo "Killed by pattern"

# Verify all are gone
ps aux | grep sleep | grep -v grep


## Task 7.2: Force Kill When Normal Kill Fails
# Create unkillable process simulation
cat > stubborn-process.sh << 'EOF'
#!/bin/bash

# Ignore SIGTERM
trap '' SIGTERM

echo "Process PID: $$"
echo "I ignore SIGTERM! Try to kill me."
echo "Only SIGKILL (kill -9) will work."

while true; do
    sleep 1
done
EOF

chmod +x stubborn-process.sh
./stubborn-process.sh &
STUBBORN_PID=$!

# Try normal kill (won't work)
kill $STUBBORN_PID
sleep 2
ps -p $STUBBORN_PID
# Still alive!

# Force kill with SIGKILL
kill -9 $STUBBORN_PID
sleep 1
ps -p $STUBBORN_PID
# Now it's dead


## Task 7.3: Killing Process Trees
# Create parent with children
cat > process-family.sh << 'EOF'
#!/bin/bash

echo "Parent: $$"

# Spawn multiple children
for i in 1 2 3; do
    sleep 100 &
    echo "Child $i: $!"
done

wait
EOF

chmod +x process-family.sh
./process-family.sh &
PARENT=$!

# See the family
pstree -p $PARENT

# Kill parent only
kill $PARENT

# Children might still be running!
ps aux | grep sleep

# Kill entire process group
# pkill -P $PARENT  # Kill all children of parent
killall sleep  # Clean up
