#!/bin/bash

echo "=== Process Hierarchy Analysis ==="
echo ""
echo "Current process (this script): $$"
echo "Parent process (shell): $PPID"
echo ""

# Show full ancestry
echo "Process ancestry:"
ps -o pid,ppid,cmd -p $$ -p $PPID

echo ""
echo "Full process tree:"
pstree -p $$
