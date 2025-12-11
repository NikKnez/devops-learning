# Exercise 4: Kernel Initialization


## Task 4.1: Understanding the Kernel
cat > kernel-guide.txt << 'EOF'
=== Linux Kernel Boot Process ===

What is the Kernel?
- Core of operating system
- Manages hardware and resources
- Provides system calls
- Schedules processes
- Handles memory management

Kernel Boot Sequence:

1. BOOTLOADER HANDOFF
   - Kernel loaded into RAM by GRUB
   - Kernel compressed (vmlinuz)
   - Initramfs loaded into RAM

2. KERNEL DECOMPRESSION
   - Kernel decompresses itself
   - First code: arch/x86/boot/compressed/head_64.S
   - Prepares protected mode

3. KERNEL INITIALIZATION
   - Initialize CPU
   - Setup memory management (MMU)
   - Initialize interrupt handlers
   - Detect and initialize hardware

4. DRIVER LOADING
   - Built-in drivers initialized
   - Kernel modules loaded as needed
   - Hardware detected and configured

5. INITRAMFS MOUNTING
   - Initial RAM filesystem mounted
   - Contains essential drivers and tools
   - Temporary root filesystem

6. ROOT FILESYSTEM MOUNT
   - Find real root filesystem (from kernel parameters)
   - Mount root filesystem
   - Switch from initramfs to real root

7. EXECUTE INIT
   - Start /sbin/init (PID 1)
   - Hand off control to user-space
   - Kernel continues running in background

Kernel Components:

vmlinuz
- Compressed kernel image
- Located in /boot/
- Example: vmlinuz-5.15.0-91-generic

initramfs (initrd)
- Initial RAM filesystem
- Contains drivers needed to mount root
- Modules for: disk controllers, filesystems, encryption
- Located in /boot/
- Example: initrd.img-5.15.0-91-generic

System.map
- Symbol table for kernel
- Used for debugging
- Maps function names to addresses

Kernel Parameters:
Passed by bootloader, control kernel behavior:

root=/dev/sda1              # Root filesystem
ro                          # Mount read-only initially  
quiet                       # Reduce boot messages
splash                      # Show splash screen
console=ttyS0               # Serial console
panic=10                    # Reboot 10s after kernel panic

Kernel Ring Buffer:
- Internal log of kernel messages
- View with: dmesg
- Preserved through boots with: dmesg --ctime

Kernel Boot Messages Show:
- Hardware detection
- Driver loading
- Filesystem mounting
- Error messages
- Timing information
EOF

cat kernel-guide.txt


## Task 4.2: Examine Kernel Information
# Current kernel version
uname -r

# Detailed kernel info
uname -a

# Kernel command line parameters
cat /proc/cmdline

# View kernel boot messages
dmesg | head -50

# Kernel boot messages with timestamps
dmesg --ctime | head -30

# Find when kernel was loaded
dmesg | grep -i "Linux version"

# Hardware detected by kernel
dmesg | grep -i "detected"

# Check loaded kernel modules
lsmod | head -20

# Kernel information files
ls -lh /boot/

# Create kernel report
cat > kernel-report.txt << EOF
=== Kernel Information Report ===

Kernel version: $(uname -r)
Full system info: $(uname -a)

Kernel command line:
$(cat /proc/cmdline)

Kernel boot message (first 20 lines):
$(dmesg | head -20)

Installed kernels:
$(ls /boot/vmlinuz-*)

Loaded modules count: $(lsmod | tail -n +2 | wc -l)

Top 10 loaded modules:
$(lsmod | head -11)
EOF

cat kernel-report.txt


## Task 4.3: Initramfs Exploration
cat > initramfs-guide.txt << 'EOF'
=== Initramfs (Initial RAM Filesystem) ===

What is Initramfs?
- Temporary root filesystem
- Loaded into RAM by bootloader
- Contains drivers needed to mount real root
- Modern replacement for initrd

Why Needed?
- Chicken-and-egg problem
- Kernel needs drivers to access disk
- Drivers might be on the disk
- Initramfs contains those drivers in RAM

Initramfs Contents:
- Essential kernel modules (drivers)
- Tools: mount, modprobe, fsck
- Scripts to mount real root
- Support for: LVM, RAID, encryption, network boot

Boot Process with Initramfs:
1. Bootloader loads kernel + initramfs into RAM
2. Kernel boots, mounts initramfs as /
3. Kernel executes /init script in initramfs
4. Script loads necessary modules
5. Script mounts real root filesystem
6. Script switches root (pivot_root)
7. Real init (/sbin/init) takes over

Initramfs vs Initrd:
- Initrd: Older, block device in RAM
- Initramfs: Modern, compressed cpio archive
- Initramfs: More flexible, smaller

Creating/Updating Initramfs:
Ubuntu/Debian: update-initramfs -u
RHEL/CentOS: dracut -f
Arch: mkinitcpio -p linux

When to Rebuild Initramfs:
- After kernel update (usually automatic)
- After adding storage drivers
- After changing disk encryption
- After filesystem changes
- Hardware changes (RAID, LVM)

Troubleshooting:
If system drops to initramfs prompt:
- Disk not found
- Filesystem corruption
- Wrong root parameter
- Missing drivers

Commands available in initramfs shell:
ls, cat, mount, lsblk, blkid, fsck
EOF

cat initramfs-guide.txt


## Task 4.4: Analyze Initramfs (Advanced)
# Check initramfs files
ls -lh /boot/initrd.img-* 2>/dev/null || ls -lh /boot/initramfs-* 2>/dev/null

# Initramfs is compressed, can extract to examine (careful!)
cat > examine-initramfs.sh << 'EOF'
#!/bin/bash

echo "=== Initramfs Examination ==="
echo ""
echo "Initramfs files:"
ls -lh /boot/initrd* 2>/dev/null || ls -lh /boot/initramfs-* 2>/dev/null

echo ""
echo "To examine initramfs contents (advanced):"
echo ""
echo "1. Copy initramfs to temp location:"
echo "   cp /boot/initrd.img-\$(uname -r) /tmp/initramfs.img"
echo ""
echo "2. Create extraction directory:"
echo "   mkdir /tmp/initramfs-extract"
echo ""
echo "3. Extract (requires root):"
echo "   cd /tmp/initramfs-extract"
echo "   unmkinitramfs /tmp/initramfs.img ."
echo "   OR"
echo "   lsinitramfs /boot/initrd.img-\$(uname -r) | head -50"
echo ""
echo "4. Examine contents:"
echo "   ls -la"
echo "   cat init  # Main init script"
echo ""
echo "WARNING: This is read-only examination."
echo "Don't modify initramfs unless you know what you're doing!"
EOF

chmod +x examine-initramfs.sh
./examine-initramfs.sh
