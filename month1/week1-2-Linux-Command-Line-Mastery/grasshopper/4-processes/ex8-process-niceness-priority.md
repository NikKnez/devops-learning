# Exercise 8: Process Niceness (Priority)


## Task 8.1: Understanding Nice Values
cat > niceness-explained.txt << 'EOF'
=== Process Niceness ===

Nice value range: -20 to 19
  -20 = Highest priority (least nice, most CPU)
   0  = Default priority
  19  = Lowest priority (most nice, least CPU)

Commands:
nice -n 10 command   # Start with nice value 10
renice -n 5 -p PID   # Change nice value of running process

Who can set what:
- Regular users: Can increase niceness (10-19)
- Regular users: Cannot decrease niceness (become less nice)
- Root: Can set any nice value

Priority in ps:
- PRI = Actual priority (lower = higher priority)
- NI = Nice value
EOF

cat niceness-explained.txt


## Task 8.2: Starting Processes with Nice
# Start process with default priority
sleep 100 &
DEFAULT_PID=$!

# Check its nice value
ps -o pid,ni,cmd -p $DEFAULT_PID

# Start process with nice value 10
nice -n 10 sleep 100 &
NICE_PID=$!

# Check its nice value
ps -o pid,ni,cmd -p $NICE_PID

# Start process with nice value 19 (lowest priority)
nice -n 19 sleep 100 &
NICER_PID=$!

# Compare all three
ps -o pid,pri,ni,cmd -p $DEFAULT_PID -p $NICE_PID -p $NICER_PID

# Clean up
kill $DEFAULT_PID $NICE_PID $NICER_PID


## Task 8.3: Changing Nice Value of Running Process
# Start process
sleep 100 &
PID=$!

# Check initial nice value
ps -o pid,ni,cmd -p $PID

# Increase niceness (make it less important)
renice -n 10 -p $PID

# Check new nice value
ps -o pid,ni,cmd -p $PID

# Try to decrease niceness (will fail as regular user)
renice -n -5 -p $PID
# Permission denied

# With sudo (would work)
# sudo renice -n -5 -p $PID

# Clean up
kill $PID


## Task 8.4: Practical Nice Usage
# Scenario: Running CPU-intensive task without slowing down system

cat > cpu-intensive.sh << 'EOF'
#!/bin/bash
# Simulate CPU-intensive work
count=0
while [ $count -lt 1000000 ]; do
    count=$((count + 1))
done
echo "Done: $count iterations"
EOF

chmod +x cpu-intensive.sh

# Run normally (high priority)
time ./cpu-intensive.sh

# Run with low priority (nice)
time nice -n 19 ./cpu-intensive.sh

# Notice: nice version might take slightly longer
# But won't slow down other processes as much
