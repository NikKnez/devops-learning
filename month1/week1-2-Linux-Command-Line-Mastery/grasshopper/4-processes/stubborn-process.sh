#!/bin/bash

# Ignore SIGTERM
trap '' SIGTERM

echo "Process PID: $$"
echo "I ignore SIGTERM! Try to kill me."
echo "Only SIGKILL (kill -9) will work."

while true; do
    sleep 1
done
