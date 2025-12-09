# Filesystems


## Key Concepts

### Filesystem Hierarchy
- / (root) - top of tree
- /etc - configuration
- /var - variable data (logs)
- /home - user data
- /tmp - temporary files


### Filesystem Types
- ext4 - Most common Linux filesystem
- xfs - High performance
- tmpfs - RAM-based
- swap - Virtual memory


### Disk Structure
- Partitions divide physical disks
- MBR (legacy) vs GPT (modern)
- /dev/sdX for disks
- /dev/sdX1 for partitions


### Important Operations
- mkfs - Create filesystem
- mount/umount - Attach/detach filesystems
- /etc/fstab - Automatic mounting
- fsck - Check and repair
- df/du - Disk usage

### Advanced Concepts
- Inodes - File metadata
- Can run out even with free space
- Symlinks - Shortcuts to files/directories
- Hard links - Multiple names, same data

## Commands Learned
- `df -h` - disk space
- `du -sh` - directory size
- `lsblk` - block devices
- `mount/umount` - mount operations
- `ln -s` - create symlink
- `fsck` - filesystem check

## Time Spent
[About total of 4 to 5 hours streched in two days]
