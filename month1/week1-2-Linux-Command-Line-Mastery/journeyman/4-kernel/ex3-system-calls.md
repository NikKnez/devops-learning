# Exercise 3: System Calls


## Task 3.1: Understanding System Calls
cat > syscalls-guide.txt << 'EOF'
=== System Calls (syscalls) ===

What is a System Call?
- Request from user space to kernel
- Only way to access kernel services
- Controlled entry point to kernel
- Mediated by kernel

Why System Calls?
- User programs cannot access hardware directly
- Need kernel to perform privileged operations
- Provides abstraction and security

System Call Categories:

1. Process Control:
   fork()   - Create new process
   exec()   - Execute program
   exit()   - Terminate process
   wait()   - Wait for child process
   kill()   - Send signal

2. File Operations:
   open()   - Open file
   read()   - Read from file
   write()  - Write to file
   close()  - Close file
   stat()   - File information

3. Device Management:
   ioctl()  - Device control
   read()   - Read from device
   write()  - Write to device

4. Information Maintenance:
   getpid() - Get process ID
   time()   - Get current time
   getuid() - Get user ID

5. Communication:
   pipe()   - Create pipe
   socket() - Create socket
   send()   - Send data
   recv()   - Receive data

6. Memory Management:
   mmap()   - Map memory
   brk()    - Change heap size
   sbrk()   - Allocate memory

System Call Flow:

User Program
     │
     ├─→ 1. Call library function (e.g., printf)
     │
Library (glibc)
     │
     ├─→ 2. Setup syscall (write)
     │
     ├─→ 3. Execute INT 0x80 or SYSCALL instruction
     │
KERNEL
     │
     ├─→ 4. Validate parameters
     │
     ├─→ 5. Execute kernel code
     │
     ├─→ 6. Return result
     │
Back to User Program

Common System Calls:

Number  Name       Purpose
------  ----       -------
0       read       Read from file descriptor
1       write      Write to file descriptor
2       open       Open file
3       close      Close file
4       stat       Get file status
5       fstat      Get file status (fd)
39      getpid     Get process ID
57      fork       Create process
59      execve     Execute program
60      exit       Exit process

Example: What Happens When You Type "ls"

1. Shell forks (fork syscall)
2. Child executes ls (execve syscall)
3. ls opens directory (open syscall)
4. ls reads directory (read syscall)
5. ls writes to stdout (write syscall)
6. ls exits (exit syscall)
7. Shell waits (wait syscall)

All of these are system calls!
EOF

cat syscalls-guide.txt


## Task 3.2: Tracing System Calls with strace
# Install strace if needed
sudo apt install -y strace

# Trace system calls for simple command
strace ls /tmp 2>&1 | head -20

# Count system calls
strace -c ls /tmp 2>&1 | tail -20

# Trace specific syscall
strace -e open,read ls /tmp 2>&1 | head -20

# Create strace analysis script
cat > strace-demo.sh << 'EOF'
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
EOF

chmod +x strace-demo.sh
./strace-demo.sh


## Task 3.3: Common System Calls in Action
# Create system call examples
cat > syscall-examples.sh << 'EOF'
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
EOF

chmod +x syscall-examples.sh
./syscall-examples.sh
