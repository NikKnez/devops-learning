#!/bin/bash

echo "=== System Call Tracing Demo ==="
echo ""

# Simple program
cat > /tmp/hello.c << 'PROG'
#include <stdio.h>
int main() {
    printf("Hello, World!\n");
    return 0;
}
PROG

# Compile it
gcc /tmp/hello.c -o /tmp/hello 2>/dev/null

echo "1. Tracing 'Hello World' program:"
echo ""
strace /tmp/hello 2>&1 | grep -E "write|exit"

echo ""
echo "2. System call summary:"
echo ""
strace -c /tmp/hello 2>&1 | tail -15

echo ""
echo "3. What system calls does 'ls' use?"
echo ""
strace -c ls /tmp > /dev/null 2>&1
strace -c ls /tmp 2>&1 | tail -15

# Cleanup
rm /tmp/hello.c /tmp/hello

echo ""
echo "Key observations:"
echo "- Even 'Hello World' makes dozens of syscalls"
echo "- Opening libraries, allocating memory, writing output"
echo "- Every program interaction with OS is a syscall"
