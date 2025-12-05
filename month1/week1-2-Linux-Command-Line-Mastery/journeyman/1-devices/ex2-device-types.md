# Exercise 2: Device Types


## Task 2.1: Block vs Character Devices
cat > device-types.txt << 'EOF'
=== Device Types ===

BLOCK DEVICES (b)
- Transfer data in blocks (chunks)
- Buffered I/O
- Random access possible
- Examples: Hard drives, SSDs, USB drives
- Typical: /dev/sda, /dev/nvme0n1

Characteristics:
- Can seek to any position
- OS caches data
- Used for storage

CHARACTER DEVICES (c)
- Transfer data one character at a time
- Unbuffered I/O
- Sequential access only
- Examples: Keyboards, mice, terminals, serial ports
- Typical: /dev/tty*, /dev/input/*, /dev/null

Characteristics:
- Stream-oriented
- No seeking
- Immediate data transfer

Major and Minor Numbers:
- Major number: Identifies device driver
- Minor number: Identifies specific device
- Format: brw-rw---- 1 root disk 8, 0 ...
                                  │  │
                                  │  └─ Minor number
                                  └─ Major number
EOF

cat device-types.txt


## Task 2.2: Examine Device Types
# Show block devices with major/minor numbers
ls -l /dev | grep "^b" | head -10

# Show character devices with major/minor numbers
ls -l /dev | grep "^c" | head -10

# Your disk devices (block)
ls -l /dev/sd* 2>/dev/null | head -10
ls -l /dev/nvme* 2>/dev/null | head -10

# Terminal devices (character)
ls -l /dev/tty*

# Input devices (character)
ls -l /dev/input/

# Document major/minor numbers
cat > major-minor-analysis.txt << 'EOF'
=== Major/Minor Number Examples ===

Major number groups device types:
- 1 = Memory devices (ram, null, zero, random)
- 8 = SCSI disk devices (sda, sdb)
- 4 = TTY devices
- 13 = Input devices (mouse, keyboard)

Examples from this system:
EOF

ls -l /dev/sda /dev/null /dev/tty /dev/random 2>/dev/null >> major-minor-analysis.txt

cat major-minor-analysis.txt


## Task 2.3: Special Device Files
# Memory devices
ls -l /dev/null /dev/zero /dev/random /dev/urandom

# Loop devices (for mounting files as disks)
ls -l /dev/loop*

# Check if any loop devices are in use
losetup -a

# Terminal devices
ls -l /dev/tty /dev/console

# Create table of device types
cat > device-type-table.txt << 'EOF'
=== Device Type Classification ===

BLOCK DEVICES:
Device          Purpose
------          -------
/dev/sda        First SATA/SCSI disk
/dev/sdb        Second SATA/SCSI disk
/dev/nvme0n1    First NVMe SSD
/dev/loop0      Loop device (mount files)
/dev/sr0        CD/DVD drive

CHARACTER DEVICES:
Device          Purpose
------          -------
/dev/null       Null device (discard data)
/dev/zero       Zero byte generator
/dev/random     Random number generator
/dev/urandom    Pseudo-random generator
/dev/tty        Current terminal
/dev/console    System console
/dev/input/*    Input devices (mouse, keyboard)
EOF

cat device-type-table.txt

