#!/bin/bash

echo "=== Process Management Tool ==="
echo ""
echo "1. Show top CPU processes"
echo "2. Show top memory processes"
echo "3. Find process by name"
echo "4. Kill process by PID"
echo "5. Show process tree"
echo "6. Monitor specific process"
echo "7. Exit"
echo ""

read -p "Select option (1-7): " option

case $option in
    1)
        echo "=== Top 10 CPU Processes ==="
        ps aux --sort=-%cpu | head -11
        ;;
    2)
        echo "=== Top 10 Memory Processes ==="
        ps aux --sort=-%mem | head -11
        ;;
    3)
        read -p "Enter process name: " name
        echo "Searching for: $name"
        ps aux | grep -i $name | grep -v grep
        ;;
    4)
        read -p "Enter PID to kill: " pid
        read -p "Force kill (-9)? (y/n): " force
        if [ "$force" = "y" ]; then
            kill -9 $pid
        else
            kill $pid
        fi
        echo "Signal sent to PID $pid"
        ;;
    5)
        echo "=== Process Tree ==="
        pstree -p | head -50
        ;;
    6)
        read -p "Enter PID to monitor: " pid
        echo "Monitoring PID $pid (Ctrl+C to stop)"
        watch -n 1 "ps -p $pid -o pid,ppid,user,%cpu,%mem,stat,start,time,cmd"
        ;;
    7)
        echo "Goodbye!"
        exit 0
        ;;
    *)
        echo "Invalid option"
        ;;
esac
