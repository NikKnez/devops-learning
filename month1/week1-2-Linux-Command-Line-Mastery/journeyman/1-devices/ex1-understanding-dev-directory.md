# Exercise 1: Understanding /dev Directory


## Task 1.1: What is /dev?
cat > dev-directory-explained.txt << 'EOF'
=== /dev Directory ===

What is /dev?
- Contains device files (special files)
- Interface between hardware and software
- Everything is a file in Linux philosophy
- Devices appear as files here

Types of files in /dev:
- Character devices (c)
- Block devices (b)
- Symbolic links (l)
- Named pipes (p)
- Sockets (s)

Why /dev exists:
- Uniform interface to hardware
- Programs interact with devices like files
- Kernel manages actual hardware communication

Historical note:
- Originally manually created
- Now dynamically managed by udev
EOF

cat dev-directory-explained.txt


## Task 1.2: Explore /dev Directory
# List /dev directory
ls /dev

# Count how many device files
ls /dev | wc -l

# List with details
ls -l /dev | head -20

# Show only block devices
ls -l /dev | grep "^b"

# Show only character devices
ls -l /dev | grep "^c"

# Show symbolic links in /dev
ls -l /dev | grep "^l" | head -10

# Document findings
cat > dev-exploration.txt << EOF
=== /dev Directory Analysis ===

Total device files: $(ls /dev | wc -l)
Block devices: $(ls -l /dev | grep "^b" | wc -l)
Character devices: $(ls -l /dev | grep "^c" | wc -l)
Symbolic links: $(ls -l /dev | grep "^l" | wc -l)

Examples of each type:
Block device: $(ls -l /dev | grep "^b" | head -1)
Character device: $(ls -l /dev | grep "^c" | head -1)
Symbolic link: $(ls -l /dev | grep "^l" | head -1)
EOF

cat dev-exploration.txt


## Task 1.3: Common Device Files
# Important device files
cat > important-devices.txt << 'EOF'
=== Important Device Files ===

/dev/null
- Discards all data written to it
- Returns EOF when read
- Use: Suppress output
- Example: command > /dev/null

/dev/zero
- Provides infinite stream of null bytes (0x00)
- Use: Create files filled with zeros
- Example: dd if=/dev/zero of=file bs=1M count=10

/dev/random
- True random number generator
- Uses hardware entropy
- Blocks when entropy pool empty

/dev/urandom
- Pseudo-random number generator
- Never blocks
- Use: Most random number needs

/dev/stdin, /dev/stdout, /dev/stderr
- Standard input/output/error
- Links to /proc/self/fd/0,1,2

/dev/tty
- Current terminal
- Always points to your terminal

/dev/sdX
- SCSI/SATA disks (sda, sdb, sdc)
- Partitions: sda1, sda2, etc.

/dev/nvmeXnY
- NVMe SSDs
- Example: nvme0n1, nvme0n1p1
EOF

cat important-devices.txt


## Task 1.4: Interacting with Device Files
# Write to /dev/null (data disappears)
echo "This goes nowhere" > /dev/null

# Read from /dev/zero (infinite zeros)
head -c 100 /dev/zero | od -An -tx1

# Read from /dev/urandom (random data)
head -c 20 /dev/urandom | od -An -tx1

# Generate random number
head -c 4 /dev/urandom | od -An -tu4

# Current terminal
tty

# Check if running in terminal
if [ -t 0 ]; then
    echo "Running in a terminal"
else
    echo "Not running in a terminal"
fi

# Redirect to your terminal directly
echo "Hello from /dev/tty" > /dev/tty
