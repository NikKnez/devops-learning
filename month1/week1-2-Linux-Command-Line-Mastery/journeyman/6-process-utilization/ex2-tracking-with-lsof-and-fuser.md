# Exercise 2: Tracking with lsof and fuser


## Task 2.1: Understanding lsof
cat > lsof-guide.txt << 'EOF'
=== lsof (List Open Files) ===

What is lsof?
- Lists all open files
- Remember: "Everything is a file" in Linux
- Shows files, directories, sockets, pipes, devices

Why lsof Matters:
- Find which process is using a file
- See network connections
- Troubleshoot "file in use" errors
- Find deleted files still held by processes

Basic Usage:
lsof                    # List all open files (huge output!)
lsof /path/to/file      # Who's using this file?
lsof -u username        # Files opened by user
lsof -c process_name    # Files opened by process
lsof -p PID             # Files opened by PID

Network Usage:
lsof -i                 # All network connections
lsof -i :80             # Who's using port 80?
lsof -i TCP             # TCP connections only
lsof -i TCP:22          # SSH connections
lsof -i @192.168.1.1    # Connections to specific IP

Common Scenarios:

1. Can't unmount drive:
   Problem: "device is busy"
   Solution: lsof /mnt/drive
   Find process, kill it, unmount

2. Can't bind to port:
   Problem: "Address already in use"
   Solution: lsof -i :8080
   Find conflicting process

3. Deleted file still using space:
   Problem: Deleted 10GB file, no space freed
   Solution: lsof | grep deleted
   Process still has file open, restart it

4. Find network connections:
   lsof -i -P -n
   -P: Show port numbers (not service names)
   -n: Show IP addresses (not hostnames)

Output Columns:
COMMAND - Process name
PID     - Process ID
USER    - Owner
FD      - File descriptor
TYPE    - File type (REG, DIR, CHR, IPv4, IPv6)
DEVICE  - Device numbers
SIZE    - File size
NODE    - Inode number
NAME    - File path or network connection

File Descriptors (FD):
cwd - Current working directory
txt - Program text (code)
mem - Memory-mapped file
0u  - stdin
1u  - stdout
2u  - stderr
3u  - File descriptor 3 (open file)
EOF

cat lsof-guide.txt


## Task 2.2: Practice with lsof
# Check if lsof is installed
if ! command -v lsof &> /dev/null; then
    echo "lsof not installed. Install with: sudo apt install lsof"
fi

# Create test file
echo "Test data" > test-file.txt

# Open file and keep it open
tail -f test-file.txt &
TAIL_PID=$!

# Find who's using the file
echo "=== Who's using test-file.txt? ===" > lsof-examples.txt
lsof test-file.txt >> lsof-examples.txt 2>&1 || echo "lsof not available" >> lsof-examples.txt

# Show current user's open files
echo "" >> lsof-examples.txt
echo "=== My open files (first 10): ===" >> lsof-examples.txt
lsof -u $(whoami) 2>/dev/null | head -10 >> lsof-examples.txt || echo "lsof not available" >> lsof-examples.txt

# Show network connections
echo "" >> lsof-examples.txt
echo "=== Network connections: ===" >> lsof-examples.txt
sudo lsof -i 2>/dev/null | head -10 >> lsof-examples.txt || echo "Need sudo for network info" >> lsof-examples.txt

# Cleanup
kill $TAIL_PID 2>/dev/null
rm test-file.txt

cat lsof-examples.txt


## Task 2.3: Understanding fuser
cat > fuser-guide.txt << 'EOF'
=== fuser (File User) ===

What is fuser?
- Identifies processes using files or sockets
- Simpler than lsof for basic tasks
- Can send signals to processes

Basic Usage:
fuser filename          # Show PIDs using file
fuser -v filename       # Verbose (show details)
fuser -m /mnt/disk      # All processes using mount point
fuser -k filename       # Kill processes using file
fuser -i -k filename    # Kill with confirmation

Network Usage:
fuser -n tcp 80         # Who's using TCP port 80?
fuser -n tcp 22         # Who's using SSH port?

Access Codes:
c - Current directory
e - Executable being run
f - Open file
F - Open file for writing
r - Root directory
m - Memory-mapped file

Common Use Cases:

1. Unmount busy filesystem:
   fuser -vm /mnt/backup
   fuser -km /mnt/backup  # Kill all
   umount /mnt/backup

2. Find process using port:
   fuser -n tcp 8080

3. Kill processes using file:
   fuser -k /var/log/app.log

fuser vs lsof:
fuser:  Simpler, focused on specific file/port
lsof:   More detailed, more options, network info

DevOps Tip:
Use fuser for quick checks and kills.
Use lsof for detailed investigation.
EOF

cat fuser-guide.txt


## Task 2.4: Practical Scenarios
cat > tracking-scenarios.sh << 'EOF'
#!/bin/bash

echo "=== Common Process Tracking Scenarios ==="
echo ""

echo "Scenario 1: Can't delete file"
echo "  Problem: rm file.txt → 'Device or resource busy'"
echo "  Solution:"
echo "    lsof file.txt              # Find process"
echo "    kill <PID>                 # Kill it"
echo "    rm file.txt                # Now works"
echo ""

echo "Scenario 2: Port already in use"
echo "  Problem: Starting server → 'Port 8080 already in use'"
echo "  Solution:"
echo "    lsof -i :8080              # Find process"
echo "    # or: fuser -n tcp 8080"
echo "    kill <PID>"
echo ""

echo "Scenario 3: Disk full but file deleted"
echo "  Problem: Deleted 10GB log, no space freed"
echo "  Solution:"
echo "    lsof | grep deleted        # Find process still holding it"
echo "    sudo systemctl restart service  # Release file"
echo ""

echo "Scenario 4: Can't unmount USB"
echo "  Problem: umount /mnt/usb → 'target is busy'"
echo "  Solution:"
echo "    lsof /mnt/usb              # Find what's using it"
echo "    cd ~                       # Get out of that directory"
echo "    fuser -km /mnt/usb         # Kill all processes"
echo "    umount /mnt/usb            # Now works"
echo ""

echo "Scenario 5: Find all SSH connections"
echo "  Solution:"
echo "    lsof -i :22"
echo "    # or: ss -tnp | grep :22"
echo ""
EOF

chmod +x tracking-scenarios.sh
./tracking-scenarios.sh
