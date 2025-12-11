# Exercise 3: Bootloader (GRUB)


## Task 3.1: Understanding GRUB
cat > grub-guide.txt << 'EOF'
=== GRUB (GRand Unified Bootloader) ===

What is GRUB?
- Stage between firmware and kernel
- Loads kernel into memory
- Passes parameters to kernel
- Provides boot menu
- Allows rescue/recovery

GRUB Versions:
- GRUB Legacy (0.9x): Obsolete
- GRUB 2 (1.9x+): Current standard

GRUB 2 Structure:

Stage 1: boot.img
- Stored in MBR or ESP
- Very small (512 bytes for MBR)
- Loads Stage 1.5

Stage 1.5: core.img
- Understands filesystems
- Loads Stage 2 from disk

Stage 2: GRUB files
- /boot/grub/ directory
- Configuration files
- Modules for filesystems
- Theme and graphics

Key Files:

/boot/grub/grub.cfg
- Main configuration (auto-generated)
- DO NOT EDIT DIRECTLY
- Contains boot menu entries

/etc/default/grub
- User-editable settings
- Timeout, default OS, kernel parameters
- Edit this, then run update-grub

/etc/grub.d/
- Scripts that generate grub.cfg
- 00_header, 10_linux, 30_os-prober, etc.
- Custom entries go in 40_custom

Common GRUB Settings (/etc/default/grub):

GRUB_TIMEOUT=5               # Menu timeout
GRUB_DEFAULT=0               # Default OS (0=first)
GRUB_CMDLINE_LINUX=""        # Kernel parameters
GRUB_DISABLE_RECOVERY=true   # Hide recovery mode

Kernel Parameters (passed to kernel):
quiet           - Minimize boot messages
splash          - Show splash screen
ro              - Mount root read-only initially
root=UUID=...   - Root filesystem
init=/bin/bash  - Use different init (recovery)

GRUB Boot Process:
1. Display menu (if timeout > 0)
2. User selects OS or waits
3. Load selected kernel
4. Load initramfs
5. Pass kernel parameters
6. Execute kernel

DevOps Use Cases:
- Add kernel parameters for troubleshooting
- Boot different kernels
- Recovery mode
- Single-user mode
- Custom OS entries
EOF

cat grub-guide.txt


## Task 3.2: Explore GRUB Configuration
# View GRUB configuration
sudo cat /boot/grub/grub.cfg | head -50

# User-editable settings
cat /etc/default/grub

# GRUB directory structure
ls -l /boot/grub/

# Installed kernels
ls -l /boot/vmlinuz-*

# Initramfs files
ls -l /boot/initrd.img-* 2>/dev/null || ls -l /boot/initramfs-* 2>/dev/null

# Check GRUB version
grub-install --version

# Create GRUB analysis
cat > grub-analysis.txt << EOF
=== GRUB Configuration Analysis ===

GRUB version: $(grub-install --version)

User settings (/etc/default/grub):
$(cat /etc/default/grub | grep -v "^#")

Installed kernels:
$(ls /boot/vmlinuz-*)

Boot directory contents:
$(ls -lh /boot/ | head -20)

Current grub menu entries:
$(sudo grep "menuentry" /boot/grub/grub.cfg | head -5)
EOF

cat grub-analysis.txt


## Task 3.3: GRUB Recovery and Editing
cat > grub-recovery.txt << 'EOF'
=== GRUB Recovery Procedures ===

Accessing GRUB Menu:
- Hold Shift during boot (BIOS)
- Press Esc during boot (UEFI)

GRUB Menu Options:
- Arrow keys: Navigate
- Enter: Boot selected
- 'e': Edit boot parameters (temporary)
- 'c': GRUB command line

Editing Boot Parameters (Recovery):
1. Select menu entry
2. Press 'e' to edit
3. Find line starting with 'linux'
4. Add parameters to end
5. Press Ctrl+X or F10 to boot

Common Recovery Parameters:

single or 1
- Boot to single-user mode
- Root access without password
- No network, minimal services

init=/bin/bash
- Boot directly to bash shell
- For password recovery
- Root filesystem is read-only

ro
- Mount root read-only (safe mode)

rw
- Mount root read-write

nomodeset
- Disable kernel mode setting
- For video driver issues

systemd.unit=rescue.target
- Boot to rescue mode
- Similar to single-user mode

Password Recovery Procedure:
1. Boot to GRUB menu
2. Press 'e' on default entry
3. Find 'linux' line
4. Add: init=/bin/bash
5. Boot with Ctrl+X
6. Remount root rw: mount -o remount,rw /
7. Change password: passwd username
8. Sync and reboot: sync; reboot -f

GRUB Reinstallation (if broken):
Boot from live USB, then:
sudo mount /dev/sdX1 /mnt           # Mount root
sudo mount /dev/sdX2 /mnt/boot      # Mount boot (if separate)
sudo grub-install --root-directory=/mnt /dev/sdX
sudo chroot /mnt
update-grub
exit
reboot

Update GRUB After Config Changes:
sudo update-grub     # Ubuntu/Debian
sudo grub2-mkconfig -o /boot/grub2/grub.cfg  # RHEL/CentOS

Custom Menu Entry (Advanced):
Edit /etc/grub.d/40_custom:

menuentry "My Custom Entry" {
    set root=(hd0,1)
    linux /vmlinuz-5.15.0 root=/dev/sda1 ro quiet
    initrd /initrd.img-5.15.0
}

Then: sudo update-grub
EOF

cat grub-recovery.txt
