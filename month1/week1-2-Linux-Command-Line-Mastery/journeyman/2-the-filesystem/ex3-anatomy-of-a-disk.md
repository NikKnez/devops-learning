# Exercise 3: Anatomy of a Disk


## Task 3.1: Understanding Disk Structure
cat > disk-anatomy.txt << 'EOF'
=== Anatomy of a Physical Disk ===

PHYSICAL STRUCTURE:
┌─────────────────────────────────────┐
│         Physical Disk (sda)         │
├─────────────────────────────────────┤
│  Master Boot Record (MBR) or GPT    │  ← Partition Table
├─────────────────────────────────────┤
│      Partition 1 (sda1)             │  ← Usually /boot
├─────────────────────────────────────┤
│      Partition 2 (sda2)             │  ← Usually / (root)
├─────────────────────────────────────┤
│      Partition 3 (sda3)             │  ← Usually swap
└─────────────────────────────────────┘

PARTITION TABLE TYPES:

MBR (Master Boot Record) - Legacy
- Max 4 primary partitions
- Max disk size: 2 TB
- Partition size stored in 32-bit
- Used on BIOS systems

GPT (GUID Partition Table) - Modern
- Up to 128 partitions
- Max disk size: 9.4 ZB (practically unlimited)
- Required for UEFI boot
- Backup partition table for redundancy

DISK DEVICE NAMING:
/dev/sda    - First SCSI/SATA disk
/dev/sdb    - Second SCSI/SATA disk
/dev/sda1   - First partition on first disk
/dev/sda2   - Second partition on first disk
/dev/nvme0n1    - First NVMe SSD
/dev/nvme0n1p1  - First partition on NVMe

SECTORS AND BLOCKS:
- Sector: Smallest addressable unit (512 bytes or 4KB)
- Block: Group of sectors (typically 4KB)
- Filesystem works with blocks, disk works with sectors
EOF

cat disk-anatomy.txt


## Task 3.2: Examine Your Disk Structure
# List all block devices
lsblk

# Show partition table
sudo fdisk -l

# For GPT disks (more modern)
sudo gdisk -l /dev/sda 2>/dev/null || echo "Not a GPT disk or permission denied"

# Show detailed disk info
sudo parted -l

# Create disk inventory
cat > disk-inventory.txt << EOF
=== Disk Inventory ===

Block devices:
$(lsblk)

Partition information:
$(sudo fdisk -l 2>/dev/null | grep -E "Disk /dev|Device")

Total disks: $(lsblk -d | tail -n +2 | wc -l)
Total partitions: $(lsblk | grep -E "part|crypt" | wc -l)
EOF

cat disk-inventory.txt
