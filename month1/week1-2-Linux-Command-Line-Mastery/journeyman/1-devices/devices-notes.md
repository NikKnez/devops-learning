# Devices

## Key Concepts

### /dev Directory
- Contains device files
- Block devices (b) - disks, storage
- Character devices (c) - terminals, input
- Special files: /dev/null, /dev/zero, /dev/random

### Device Naming
- /dev/sdX - SCSI/SATA disks
- /dev/nvmeXnY - NVMe drives
- /dev/ttyX - Terminals
- /dev/loopX - Loop devices

### sysfs (/sys)
- Virtual filesystem
- Exposes kernel objects
- Device information
- Driver information

### udev
- Dynamic device management
- Creates /dev entries
- Manages permissions
- Persistent device names

## Commands Mastered
- `lsblk` - list block devices
- `lsusb`
- list USB devices
- lspci - list PCI devices
- udevadm info - query device
- udevadm monitor - watch events
- dd - disk duplication (DANGEROUS!)

## Important Files
- /dev/null - discard output
- /dev/zero - zeros
- /dev/urandom - random data
- /sys/* - device info
- /dev/disk/by-uuid/ - persistent names

## Time Spent
[It took dwo days at 2-4 hours each day]
