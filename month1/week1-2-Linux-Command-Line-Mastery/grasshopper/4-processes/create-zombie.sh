#!/bin/bash

# Fork a child that exits immediately
bash -c 'exit 0' &
CHILD_PID=$!

# Parent doesn't wait (doesn't call wait)
# Child becomes zombie for a short time

echo "Child PID: $CHILD_PID"
echo "Check for zombie (Z state):"
ps -p $CHILD_PID -o pid,stat.cmd

# Sleep to keep zombie alive
sleep 2

# Now wait and clean up
wait $CHILD_PID
echo "Zombie cleaned up"
