# Exercise 6: Complete Boot Process Timeline


## Task 6.1: Create Visual Boot Timeline
cat > boot-timeline.txt << 'EOF'
=== Complete Linux Boot Timeline ===

TIME    STAGE           COMPONENT       ACTION
----    -----           ---------       ------
0.0s    Power On        Hardware        Power button pressed
0.1s    POST            BIOS/UEFI       Self-test, hardware init
0.5s    Boot Device     BIOS/UEFI       Find bootable device
1.0s    Bootloader      GRUB Stage 1    Load from MBR/ESP
1.2s    Bootloader      GRUB Stage 2    Display menu (if timeout > 0)
3.0s    Kernel Load     GRUB            Load vmlinuz + initramfs to RAM
3.5s    Kernel Init     Kernel          Decompress, initialize
4.0s    Hardware        Kernel          Detect & init hardware, load drivers
4.5s    Initramfs       Kernel          Mount initramfs as temporary root
5.0s    Root Mount      initramfs       Mount real root filesystem
5.5s    Switch Root     initramfs       Pivot to real root
6.0s    Init            systemd         Start systemd (PID 1)
6.5s    Targets         systemd         Analyze dependencies
7.0s    Services        systemd         Start services in parallel
8.0s    Filesystems     systemd         Mount /home, /var, etc.
9.0s    Network         systemd         Start networking
10.0s   User Services   systemd         Start user-space services
12.0s   Target Reached  systemd         multi-user.target or graphical.target
13.0s   Login Ready     getty/GDM       Login prompt or desktop manager

Total Boot Time: ~10-15 seconds (typical)

Parallel vs Serial:

SysV Init (Serial - OLD):
[BIOS] → [GRUB] → [Kernel] → [Init] → [Service1] → [Service2] → [Service3] → [Login]
Total: ~45-60 seconds

systemd (Parallel - MODERN):
[BIOS] → [GRUB] → [Kernel] → [Init] → [Service1]
                                     ↓  [Service2]  → [Login]
                                     ↓  [Service3]
Total: ~10-15 seconds

What Can Slow Boot:
- Old/slow hardware (mechanical HDD vs SSD)
- Too many services
- Filesystem checks (fsck)
- Network timeouts
- Heavy services (databases, web servers)
- GUI initialization

Optimization Tips:
1. Use SSD instead of HDD
2. Disable unnecessary services
3. Use systemd-analyze to find bottlenecks
4. Parallel service starts (systemd does this)
5. Reduce GRUB timeout
6. Use systemd timers instead of cron (faster)
EOF

cat boot-timeline.txt


## Task 6.2: Boot Process Troubleshooting Guide
cat > boot-troubleshooting.txt << 'EOF'
=== Boot Process Troubleshooting ===

SYMPTOM: No power, no POST beep
STAGE: Power On
POSSIBLE CAUSES:
- Power supply failure
- Motherboard failure
- Power button not connected
SOLUTION:
- Check power connections
- Test with different power supply
- Check motherboard LED indicators

SYMPTOM: POST beeps, no video
STAGE: BIOS/UEFI
POSSIBLE CAUSES:
- RAM not seated properly
- Video card failure
- Monitor connection
SOLUTION:
- Reseat RAM modules
- Check monitor cable
- Try different video output
- Clear CMOS (reset BIOS)

SYMPTOM: "No bootable device" or "GRUB Rescue"
STAGE: Bootloader
POSSIBLE CAUSES:
- GRUB corrupted/missing
- Boot order wrong
- Disk failure
- MBR/GPT corruption
SOLUTION:
- Boot from live USB
- Reinstall GRUB:
  mount /dev/sdX1 /mnt
  grub-install --root-directory=/mnt /dev/sdX
- Check BIOS boot order
- Run: sudo update-grub

SYMPTOM: Kernel panic
STAGE: Kernel
POSSIBLE CAUSES:
- Corrupted kernel
- Wrong kernel parameters
- Hardware incompatibility
- Missing drivers in init ramfs
SOLUTION:
- Boot older kernel from GRUB
- Check kernel parameters
- Rebuild initramfs
- Update or downgrade kernel

SYMPTOM: Drops to initramfs prompt
STAGE: Initramfs/Root Mount
POSSIBLE CAUSES:
- Root filesystem not found
- UUID mismatch in /etc/fstab
- Filesystem corruption
- Encrypted disk not unlocking
SOLUTION:
- Check available devices: blkid
- Mount manually: mount /dev/sdX1 /root
- Check /etc/fstab for errors
- Run fsck on root partition

SYMPTOM: Services fail to start
STAGE: Init/systemd
POSSIBLE CAUSES:
- Service configuration error
- Dependency not met
- Port already in use
- Permission issues
SOLUTION:
- Check logs: journalctl -xe
- Check service: systemctl status service
- Test manually: /usr/sbin/service-binary
- Fix configuration files

SYMPTOM: Hangs at login screen
STAGE: Login
POSSIBLE CAUSES:
- Display manager issue
- X server configuration
- Graphics driver problem
SOLUTION:
- Switch to TTY: Ctrl+Alt+F2
- Check logs: /var/log/Xorg.0.log
- Restart display manager: systemctl restart gdm (or lightdm, sddm)
- Boot to multi-user target


Emergency Boot Modes:

Single User Mode:
- Add "single" to kernel parameters
- Root access without password
- Minimal services

Rescue Mode:
- Add "systemd.unit=rescue.target"
- Requires root password
- More services than single user

Emergency Mode:
- Add "systemd.unit=emergency.target"
- Absolute minimal environment
- Root filesystem mounted read-only

Recovery Shell:
- Add "init=/bin/bash"
- Direct bash shell
- No services, no network
- For password reset

Boot from Live USB:
- Ultimate recovery tool
- Full environment
- Can mount and fix system
- chroot into installed system
EOF

cat boot-troubleshooting.txt
