# Boot the System


## Boot Sequence (5 Stages)
1. BIOS/UEFI - Hardware initialization, POST
2. Bootloader (GRUB) - Load kernel
3. Kernel - Initialize hardware, mount root
4. Initramfs - Temporary root, load drivers
5. Init (systemd) - Start services, reach target

## Key Concepts

### BIOS vs UEFI
- BIOS: Legacy, MBR, 2TB limit
- UEFI: Modern, GPT, Secure Boot

### GRUB
- Stage between firmware and kernel
- /boot/grub/grub.cfg (auto-generated)
- /etc/default/grub (user settings)
- Can edit at boot for recovery

### Kernel
- vmlinuz - compressed kernel
- initramfs - temporary root with drivers
- Mounts real root filesystem
- Starts init (PID 1)

### systemd
- Modern init system
- Parallel service startup
- Units: .service, .target, .timer
- Targets replace runlevels
- journalctl for logs

## Commands Learned
- `systemctl` - service management
- `systemd-analyze` - boot timing
- `journalctl` - system logs
- `dmesg` - kernel messages
- `update-grub` - regenerate GRUB config

## Troubleshooting
- Boot to rescue mode
- Edit GRUB at boot
- Single-user mode
- Check journalctl -xe

## Time Spent
[It took to complete 3-4 hours in span of two days]
