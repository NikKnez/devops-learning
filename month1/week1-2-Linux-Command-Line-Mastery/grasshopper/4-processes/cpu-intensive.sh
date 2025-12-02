#!/bin/bash
# Simulate CPU-intensive work
count=0
while [ $count -lt 1000000 ]; do
    count=$((count + 1))
done
echo "Done: $count iterations"
