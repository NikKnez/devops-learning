#!/bin/bash

# Function to handle signals
cleanup() {
    echo ""
    echo "Recieved signal, cleaning up..."
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
