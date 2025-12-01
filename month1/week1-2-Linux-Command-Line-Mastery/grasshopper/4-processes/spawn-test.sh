#!/bin/bash

echo "Parent: $$"

# Spawn child process
bash -c 'echo "Child: $$, Parent: $PPID; sleep 5' &
CHILD_PID=$!

echo "Spawned child: $CHILD_PID"

# Show relationship
ps -f -p $$ -p $CHILD_PID

wait $CHILD_PID
echo "Child finished"
