# Exercise 5: Kernel Location


## Task 5.1: Finding Kernel Files
cat > kernel-locations.txt << 'EOF'
=== Kernel File Locations ===

Key Kernel Files:

/boot/vmlinuz-*
- Compressed kernel image
- "vmlinuz" = Virtual Memory Linux (compressed with Z)
- Loaded by bootloader (GRUB)
- Example: /boot/vmlinuz-5.15.0-91-generic

/boot/initrd.img-* or /boot/initramfs-*
- Initial RAM disk
- Temporary root filesystem
- Contains drivers needed to mount real root
- Loaded before real root filesystem

/boot/System.map-*
- Kernel symbol table
- Maps function names to memory addresses
- Used for debugging kernel crashes

/boot/config-*
- Kernel configuration used during compilation
- Shows what features are enabled
- Useful for troubleshooting

/proc/
- Virtual filesystem
- Kernel exposes runtime information
- /proc/version - Kernel version
- /proc/cmdline - Boot parameters
- /proc/modules - Loaded modules
- /proc/cpuinfo - CPU info
- /proc/meminfo - Memory info

/sys/
- sysfs virtual filesystem
- Kernel objects and attributes
- Device information
- Driver parameters

/lib/modules/$(uname -r)/
- Kernel modules directory
- Loadable kernel modules (.ko files)
- One directory per installed kernel

/usr/src/linux-headers-*
- Kernel headers
- For compiling external modules
- Development files

File Sizes (Typical):
vmlinuz       ~8-10 MB  (compressed kernel)
initrd        ~50-100 MB (initial ramdisk)
System.map    ~5 MB (symbol table)
config        ~200 KB (configuration)
modules       ~200-500 MB (all modules)

GRUB Location:
/boot/grub/grub.cfg      - GRUB config (auto-generated)
/etc/default/grub        - GRUB settings (edit this)
/etc/grub.d/             - GRUB scripts

Bootloader Process:
1. BIOS/UEFI loads GRUB
2. GRUB reads /boot/grub/grub.cfg
3. GRUB loads kernel (vmlinuz)
4. GRUB loads initrd
5. Kernel starts, mounts initrd as /
6. initrd finds real root filesystem
7. initrd switches to real root
8. Kernel starts init (PID 1)
EOF

cat kernel-locations.txt


## Task 5.2: Explore Kernel Files
# List all kernel files in /boot
ls -lh /boot

# Current kernel image
ls -lh /boot/vmlinuz-$(uname -r)

# Size of kernel image
du -h /boot/vmlinuz-$(uname -r)

# Current kernel config
ls -lh /boot/config-$(uname -r)

# Check what's enabled in kernel
grep -E "CONFIG_EXT4|CONFIG_BTRFS|CONFIG_XFS" /boot/config-$(uname -r)

# Kernel modules location
ls /lib/modules/$(uname -r)

# Count kernel modules
find /lib/modules/$(uname -r) -name "*.ko" | wc -l

# Size of modules directory
du -sh /lib/modules/$(uname -r)

# Check /proc kernel info
ls -l /proc | grep -E "version|cmdline|modules|cpuinfo|meminfo"

# Create kernel file map
cat > kernel-file-map.txt << EOF
=== Kernel Files on This System ===

Kernel version: $(uname -r)

Boot files:
$(ls -lh /boot/vmlinuz-$(uname -r) /boot/initrd.img-$(uname -r) /boot/config-$(uname -r))

Module count: $(find /lib/modules/$(uname -r) -name "*.ko" | wc -l) modules

Modules size: $(du -sh /lib/modules/$(uname -r) | cut -f1)

Proc files:
$(ls -lh /proc/version /proc/cmdline /proc/modules)

Kernel boot parameters:
$(cat /proc/cmdline)
EOF

cat kernel-file-map.txt
