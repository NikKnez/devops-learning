# Exercise 5: Creating Filesystems (mkfs)


## Task 5.1: Understanding mkfs
cat > mkfs-guide.txt << 'EOF'
=== Creating Filesystems with mkfs ===

mkfs (Make Filesystem) Family:
mkfs.ext4   - Create ext4 filesystem
mkfs.xfs    - Create XFS filesystem
mkfs.vfat   - Create FAT filesystem
mkfs.ntfs   - Create NTFS filesystem

Common syntax:
mkfs.<type> /dev/sdXN

Examples:
sudo mkfs.ext4 /dev/sdb1        # Format partition as ext4
sudo mkfs.ext4 -L mydata /dev/sdb1  # With label
sudo mkfs.xfs /dev/sdc1         # Format as XFS

Options:
-L label    - Set filesystem label
-t type     - Specify filesystem type
-c          - Check for bad blocks first

WARNING: mkfs DESTROYS ALL DATA!
- Triple-check device name
- Wrong device = data loss
- Always unmount before formatting

Filesystem Features:
ext4:  Journaling, large file support, backwards compatible
xfs:   High performance, good for large files
btrfs: Snapshots, compression, advanced features

Best Practices:
1. Always unmount first: sudo umount /dev/sdX1
2. Verify device: lsblk before mkfs
3. Use labels: easier to identify
4. Test mount after creating
EOF

cat mkfs-guide.txt


## Task 5.2: Practice with Loop Device (Safe)
# Create a file to use as virtual disk
dd if=/dev/zero of=virtual-disk.img bs=1M count=100

# Check the file
ls -lh virtual-disk.img

# Create loop device (treats file as block device)
sudo losetup -f virtual-disk.img

# Find which loop device was assigned
LOOP_DEV=$(sudo losetup -j virtual-disk.img | cut -d: -f1)
echo "Loop device: $LOOP_DEV"

# Create ext4 filesystem on loop device
sudo mkfs.ext4 -L "test-disk" $LOOP_DEV

# Verify filesystem
sudo file -s $LOOP_DEV
sudo blkid $LOOP_DEV

# Create mount point and mount it
mkdir test-mount
sudo mount $LOOP_DEV test-mount

# Check if mounted
df -h | grep test-mount

# Create test file
sudo bash -c 'echo "Test data" > test-mount/testfile.txt'
ls -l test-mount/

# Unmount and cleanup
sudo umount test-mount
sudo losetup -d $LOOP_DEV
rm virtual-disk.img
rmdir test-mount

echo "Filesystem creation practice completed successfully!"
