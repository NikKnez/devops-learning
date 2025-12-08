# Exercise 7: /etc/fstab (Filesystem Table)


## Task 7.1: Understanding /etc/fstab
cat > fstab-guide.txt << 'EOF'
=== /etc/fstab File System Table ===

Purpose:
- Defines how filesystems should be mounted at boot
- Automatic mounting without manual commands
- System boot depends on this file

Format (6 columns):
<device> <mount point> <type> <options> <dump> <pass>

Example Line:
UUID=abc-123 /home ext4 defaults 0 2

Column 1 - Device:
/dev/sda1                    # Device name (can change!)
UUID=abc-def-123             # UUID (preferred - never changes)
LABEL=mydisk                 # Filesystem label
//server/share               # Network share

Column 2 - Mount Point:
/                # Root
/home            # Home directories
/mnt/data        # Custom mount
none             # For swap

Column 3 - Filesystem Type:
ext4, xfs, vfat, ntfs, swap, nfs, tmpfs

Column 4 - Mount Options:
defaults         # rw, suid, dev, exec, auto, nouser, async
ro               # Read-only
rw               # Read-write
noexec           # Don't allow program execution
nosuid           # Ignore setuid bits
noauto           # Don't mount at boot (manual mount only)
user             # Allow regular users to mount
nofail           # Don't halt boot if device missing

Column 5 - Dump:
0 = Don't backup with dump utility
1 = Backup with dump

Column 6 - Pass (fsck order):
0 = Don't check
1 = Check first (root filesystem)
2 = Check after root

CRITICAL WARNINGS:
- Syntax errors prevent boot!
- Always test before rebooting
- Keep backup of working fstab
- Use UUID instead of /dev/sdX (device names can change)

Testing fstab Changes:
sudo mount -a      # Mount all in fstab
sudo findmnt --verify  # Verify fstab syntax
EOF

cat fstab-guide.txt


## Task 7.2: Examine Your /etc/fstab
# View current fstab
cat /etc/fstab

# Remove comments for clarity
grep -v "^#" /etc/fstab | grep -v "^$"

# Find UUID of your root partition
ROOT_DEV=$(df / | tail -1 | awk '{print $1}')
sudo blkid $ROOT_DEV

# Create fstab documentation
cat > fstab-analysis.txt << EOF
=== My System's /etc/fstab Analysis ===

Current fstab (without comments):
$(grep -v "^#" /etc/fstab | grep -v "^$")

Root partition device: $ROOT_DEV
Root partition UUID: $(sudo blkid $ROOT_DEV | grep -o 'UUID="[^"]*"')

Mounted filesystems:
$(mount | column -t)

FileSystems in fstab:
$(awk '{print $2, $3, $4}' /etc/fstab | column -t)
EOF

cat fstab-analysis.txt


## Task 7.3: Practice fstab Entry (Safe)
# Create practice documentation
cat > fstab-practice.txt << 'EOF'
=== Practice fstab Entries ===

Example 1: USB Drive
UUID=1234-5678  /mnt/usb  vfat  defaults,noauto,user  0  0
- noauto: Don't mount at boot
- user: Allow non-root users to mount

Example 2: External Backup Drive
UUID=abc-def  /mnt/backup  ext4  defaults,nofail  0  2
- nofail: Don't halt boot if missing

Example 3: Temporary RAM Disk
tmpfs  /mnt/ramdisk  tmpfs  defaults,size=1G  0  0
- In-memory filesystem
- Very fast, volatile

Example 4: Network Share
//192.168.1.100/share  /mnt/network  cifs  credentials=/root/.smbcreds  0  0
- Network filesystem
- Credentials file for security

Example 5: Swap Partition
UUID=swap-uuid  none  swap  sw  0  0
- none: No mount point
- sw: Swap priority

How to Add Entry:
1. sudo cp /etc/fstab /etc/fstab.backup  # Backup!
2. Get UUID: sudo blkid /dev/sdX1
3. sudo nano /etc/fstab
4. Add line
5. Test: sudo mount -a
6. If error: sudo cp /etc/fstab.backup /etc/fstab

Emergency Recovery:
If fstab prevents boot:
1. Boot from live USB
2. Mount root: sudo mount /dev/sdX2 /mnt
3. Fix: sudo nano /mnt/etc/fstab
4. Reboot
EOF

cat fstab-practice.txt
