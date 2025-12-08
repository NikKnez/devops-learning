# Exercise 6: Mounting and Unmounting Filesystems


## Task 6.1: Understanding Mount
cat > mounting-guide.txt << 'EOF'
=== Mounting Filesystems ===

What is Mounting?
- Attaching a filesystem to the directory tree
- Makes files accessible at a specific path
- Only mounted filesystems are usable

Mount Command Syntax:
sudo mount /dev/sdX1 /mnt/mountpoint

Common Mount Options (-o):
ro          - Read-only
rw          - Read-write (default)
noexec      - Prevent execution of binaries
nosuid      - Ignore setuid/setgid bits
nodev       - Ignore device files
defaults    - rw, suid, dev, exec, auto, nouser, async

Examples:
sudo mount /dev/sdb1 /mnt/data          # Simple mount
sudo mount -o ro /dev/sdb1 /mnt/data    # Read-only
sudo mount -t ext4 /dev/sdb1 /mnt/data  # Specify type
sudo mount -a                           # Mount all in /etc/fstab

Unmount Command:
sudo umount /mnt/mountpoint
sudo umount /dev/sdX1

Common Unmount Issues:
"Device is busy" - Something is using it
- Check: lsof /mnt/mountpoint
- Or: fuser -m /mnt/mountpoint
- Solution: cd out of directory, close files, kill processes

Force unmount:
sudo umount -f /mnt/mountpoint    # Force
sudo umount -l /mnt/mountpoint    # Lazy (when possible)

Checking What's Mounted:
mount                  # All mounts
df -h                  # Mounted filesystems with usage
lsblk                  # Block devices and mount points
cat /proc/mounts       # Kernel view of mounts
EOF

cat mounting-guide.txt


## Task 6.2: Practice Mounting
# Create virtual disk
dd if=/dev/zero of=practice-disk.img bs=1M count=50

# Setup loop device
sudo losetup -f practice-disk.img
LOOP=$(sudo losetup -j practice-disk.img | cut -d: -f1)

# Format it
sudo mkfs.ext4 -L "practice" $LOOP

# Create mount point
mkdir -p ~/practice-mount

# Mount it
sudo mount $LOOP ~/practice-mount

# Verify mount
df -h | grep practice
mount | grep practice

# Create some files
sudo bash -c 'echo "Hello from mounted filesystem" > ~/practice-mount/hello.txt'
ls -l ~/practice-mount/

# Try to unmount while inside (will fail)
cd ~/practice-mount
sudo umount ~/practice-mount
# Error: target is busy

# Exit directory first
cd ~

# Now unmount (will work)
sudo umount ~/practice-mount

# Verify unmounted
df -h | grep practice
# Should show nothing

# Files are gone from mount point (but still on disk)
ls ~/practice-mount/

# Mount again to see files reappear
sudo mount $LOOP ~/practice-mount
ls -l ~/practice-mount/

# Cleanup
sudo umount ~/practice-mount
sudo losetup -d $LOOP
rm practice-disk.img
rmdir ~/practice-mount

echo "Mount/unmount practice completed!"
