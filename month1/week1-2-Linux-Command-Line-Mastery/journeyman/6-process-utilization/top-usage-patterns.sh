#!/bin/bash

echo "=== top Command Usage Patterns ==="
echo ""

echo "1. Quick system overview:"
echo "   top -b -n 1 | head -20"
echo ""

echo "2. Find top 10 CPU processes:"
echo "   top -b -n 1 | head -17 | tail -10"
echo ""

echo "3. Monitor specific user:"
echo "   top -u username"
echo ""

echo "4. Batch mode for logging:"
echo "   top -b -n 5 > top-log.txt"
echo ""

echo "5. Show individual CPU cores:"
echo "   top (then press '1')"
echo ""

echo "6. Sort by memory:"
echo "   top (then press 'M')"
echo ""

echo "7. Filter processes:"
echo "   top (then press 'o', type 'COMMAND=nginx')"
echo ""

# Run actual top snapshot
echo "Current top snapshot:"
top -b -n 1 | head -20
