#!/bin/bash

echo "=== System Calls in Daily Commands ==="
echo ""

echo "1. 'cat' command syscalls:"
echo "   Creating test file..."
echo "test data" > /tmp/testfile.txt
echo ""
echo "   System calls used by 'cat':"
strace -e open,read,write,close cat /tmp/testfile.txt 2>&1 | grep -E "open|read|write|close"
echo ""

echo "2. 'ls' command syscalls:"
echo "   System calls for listing directory:"
strace -e openat,getdents64 ls /tmp 2>&1 | grep -E "openat|getdents" | head -5
echo ""

echo "3. Creating a file (touch):"
strace -e openat,close touch /tmp/newfile.txt 2>&1 | grep -E "openat|close"
echo ""

echo "4. Network syscalls (ping):"
echo "   Socket-related calls:"
timeout 1 strace -e socket,sendto,recvfrom ping -c 1 8.8.8.8 2>&1 | grep -E "socket|send|recv" | head -5
echo ""

# Cleanup
rm /tmp/testfile.txt /tmp/newfile.txt

echo "Every program uses system calls to interact with kernel!"
