# Exercise 10: Filesystem Repair (fsck)


## Task 10.1: Understanding fsck
cat > fsck-guide.txt << 'EOF'
=== Filesystem Check and Repair (fsck) ===

What is fsck?
- File System Consistency Check
- Repairs filesystem corruption
- Checks and fixes metadata
- Should be run on UNMOUNTED filesystems

When to Use:
- System won't boot
- Disk errors in logs
- After unclean shutdown
- Scheduled maintenance

Types:
fsck.ext4   - For ext4 filesystems
fsck.xfs    - For XFS (rarely needed, self-healing)
fsck.vfat   - For FAT filesystems

Basic Syntax:
sudo fsck /dev/sdX1       # Check partition
sudo fsck -y /dev/sdX1    # Auto-fix (yes to all)
sudo fsck -n /dev/sdX1    # Dry run (no changes)

Options:
-y  - Assume yes to all questions
-n  - Dry run, don't fix
-f  - Force check even if clean
-v  - Verbose
-p  - Automatic repair (preen)

CRITICAL WARNINGS:
1. NEVER run fsck on MOUNTED filesystem
   - Will cause corruption
   - Always unmount first
   
2. For root filesystem:
   - Boot from live USB
   - Or use single-user mode
   
3. Backup before fsck
   - Repair can fail
   - Data might be lost

Auto fsck at Boot:
- Linux checks filesystem every N mounts
- Or after N days
- tune2fs -l /dev/sdX1  # Show check settings
- tune2fs -c 30 /dev/sdX1  # Check every 30 mounts

Emergency fsck:
If system won't boot:
1. Boot from live USB
2. Find partition: lsblk
3. fsck: sudo fsck -y /dev/sdX1
4. Reboot

Common Errors Fixed:
- Orphaned inodes
- Bad block references
- Incorrect link counts
- Missing directory entries
EOF

cat fsck-guide.txt


## Task 10.2: Filesystem Check Practice
# Create practice script
cat > fsck-practice.sh << 'EOF'
#!/bin/bash

echo "=== Filesystem Check Practice ===" 
echo ""
echo "SAFE fsck Commands (for unmounted filesystems):"
echo ""
echo "1. Check if filesystem is clean:"
echo "   sudo fsck -n /dev/sdX1"
echo ""
echo "2. Check and auto-repair:"
echo "   sudo fsck -y /dev/sdX1"
echo ""
echo "3. Force check even if clean:"
echo "   sudo fsck -f /dev/sdX1"
echo ""
echo "4. Check with progress:"
echo "   sudo fsck -V /dev/sdX1"
echo ""
echo "NEVER run fsck on mounted filesystem!"
echo "Check if mounted: mount | grep sdX1"
echo "Unmount first: sudo umount /dev/sdX1"
echo ""
echo "Check filesystem type first:"
echo "  lsblk -f"
echo "  Use correct fsck type (fsck.ext4, fsck.xfs, etc.)"
EOF
chmod +x fsck-practice.sh
./fsck-practice.sh
