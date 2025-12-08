# Exercise 2: Filesystem Types


## Task 2.1: Understanding Filesystem Types
cat > filesystem-types.txt << 'EOF'
=== Linux Filesystem Types ===

EXT4 (Fourth Extended Filesystem)
- Most common on Linux
- Journaling filesystem (crash recovery)
- Max file size: 16 TB
- Max volume size: 1 EB
- Use: General purpose, root partitions

XFS
- High performance, scalability
- Good for large files
- Used by RHEL/CentOS by default
- Use: Large databases, media servers

BTRFS (B-Tree Filesystem)
- Copy-on-write (COW)
- Built-in snapshots, compression
- Self-healing capabilities
- Use: Advanced users, NAS systems

FAT32
- Universal compatibility (Windows, Mac, Linux)
- Max file size: 4 GB (limitation!)
- Use: USB drives, SD cards

NTFS
- Windows filesystem
- Linux can read/write with ntfs-3g driver
- Use: Dual-boot systems, external drives

TMPFS
- RAM-based filesystem
- Very fast, volatile (lost on reboot)
- Use: /tmp, /dev/shm

SWAP
- Virtual memory extension
- Not a traditional filesystem
- Use: System swap space

Network Filesystems:
NFS  - Network File System (Unix/Linux)
CIFS - Common Internet File System (Windows shares)

Virtual Filesystems:
/proc - Process information
/sys  - Kernel and device info
/dev  - Device files
EOF

cat filesystem-types.txt


## Task 2.2: Check Current Filesystems
# Show all mounted filesystems with types
df -Th

# More detailed filesystem info
lsblk -f

# Show only specific filesystem types
df -t ext4
df -t tmpfs

# Find what filesystem your root is using
df -T / | tail -1 | awk '{print $2}'

# Document your system's filesystems
cat > my-filesystems.txt << EOF
=== My System's Filesystems ===

All mounted filesystems:
$(df -Th)

Root filesystem type: $(df -T / | tail -1 | awk '{print $2}')

All filesystems with details:
$(lsblk -f)
EOF

cat my-filesystems.txt
