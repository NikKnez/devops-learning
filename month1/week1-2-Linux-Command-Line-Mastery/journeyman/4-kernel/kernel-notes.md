# The Linux Kernel

## Key Concepts

### Kernel Overview
- Core of operating system
- Bridge between hardware and software
- Manages: processes, memory, devices, files, network
- Runs in privileged mode (Ring 0)

### Privilege Levels
- Ring 0 (Kernel Mode) - Full hardware access
- Ring 3 (User Mode) - Restricted access
- System calls bridge the two
- Protection prevents crashes and security issues

### System Calls
- Only way user programs access kernel
- Examples: read(), write(), fork(), exec()
- strace command traces syscalls
- Every program uses hundreds of syscalls

### Kernel Files
- /boot/vmlinuz - Compressed kernel image
- /boot/initrd - Initial RAM disk
- /boot/config - Kernel configuration
- /lib/modules - Loadable kernel modules
- /proc - Virtual filesystem (kernel info)

### Kernel Modules
- Dynamically loadable code
- Extend kernel without recompile
- Device drivers, filesystems, protocols
- Commands: lsmod, modprobe, modinfo

## Commands Learned
- `uname -r` - kernel version
- `lsmod` - list modules
- `modinfo` - module info
- `strace` - trace system calls
- `dmesg` - kernel messages

## Important Findings
- My kernel: $(uname -r)
- Modules loaded: ~XXX
- System calls: Every program uses them
- Kernel space vs user space separation

## Time Spent
[About 3 hours to finish]
