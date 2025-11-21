#!/bin/bash

# Daily command practice
# Run this every morning for Week 1

echo "=== Daily Command Practice ==="
echo "Date: $(date)"
echo ""


# Practice 1: Navigation
echo "1. Current directory"
pwd


# Practice 2: List files
echo "2. Files in current directory:"
ls -la


# Practice 3: System info
echo "3. Disk usage:"
df -h | grep -E '^/dev'

echo "4. Memory usage:"
free -h | grep Mem


# Practice 4: Find files
echo "5. Bash scripts in this directory:"
find . -name "*.sh"


echo ""
echo "Practice complete!"

