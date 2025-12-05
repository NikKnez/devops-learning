# Exercise 3: Device Names and Conventions


## Task 3.1: Understanding Device Naming
cat > device-naming.txt << 'EOF'
=== Device Naming Conventions ===

DISK DEVICES:
/dev/sdX        - SCSI/SATA disks (X = a, b, c...)
/dev/sdXN       - Partitions (N = 1, 2, 3...)
/dev/nvmeXnY    - NVMe drives (X = controller, Y = namespace)
/dev/nvmeXnYpZ  - NVMe partitions (Z = partition number)
/dev/mmcblkX    - SD/MMC cards
/dev/mmcblkXpY  - SD card partitions

Examples:
/dev/sda        - First disk
/dev/sda1       - First partition on first disk
/dev/sda2       - Second partition on first disk
/dev/sdb        - Second disk
/dev/nvme0n1    - First NVMe drive
/dev/nvme0n1p1  - First partition on first NVMe

TERMINAL DEVICES:
/dev/ttyN       - Virtual consoles (N = 1-6)
/dev/pts/N      - Pseudo-terminals (SSH, terminal emulator)
/dev/ttyS0      - Serial ports

LOOP DEVICES:
/dev/loopN      - Loop devices (mount files as disks)

INPUT DEVICES:
/dev/input/mouseN   - Mouse
/dev/input/eventN   - Generic input events

LEGACY NAMES (older systems):
/dev/hdX        - IDE/PATA disks (mostly obsolete)
EOF

cat device-naming.txt


## Task 3.2: Find Your Storage Devices
# List all block devices
lsblk

# More detailed block device info
lsblk -o NAME,SIZE,TYPE,MOUNTPOINT,FSTYPE

# Show disk devices only
ls -l /dev/sd* 2>/dev/null
ls -l /dev/nvme* 2>/dev/null

# Show your main disk
df -h /

# Which device is root partition?
df / | tail -1 | awk '{print $1}'

# Create disk inventory
cat > disk-inventory.txt << EOF
=== Disk Device Inventory ===

Block devices on this system:
$(lsblk -o NAME,SIZE,TYPE,MOUNTPOINT)

Root filesystem device:
$(df / | tail -1)

All disk-related devices:
$(ls /dev/sd* /dev/nvme* /dev/mmcblk* 2>/dev/null)
EOF

cat disk-inventory.txt


## Task 3.3: Terminal Device Names
# Your current terminal
tty

# List all TTY devices
ls /dev/tty[0-9]*

# List pseudo-terminals
ls /dev/pts/

# Show who's logged in and their terminals
who

# Your terminal info
w

# Document terminal info
cat > terminal-info.txt << EOF
=== Terminal Information ===

My current terminal: $(tty)

Active terminals:
$(who)

Pseudo-terminals:
$(ls /dev/pts/)

Virtual consoles available:
$(ls /dev/tty[1-6])
EOF

cat terminal-info.txt
