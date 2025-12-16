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
