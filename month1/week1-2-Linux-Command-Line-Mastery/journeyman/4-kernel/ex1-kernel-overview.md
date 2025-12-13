# Exercise 1: Kernel Overview


## Task 1.1: Understanding the Linux Kernel
cat > kernel-overview.txt << 'EOF'
=== Linux Kernel Overview ===

What is the Kernel?
- Core of the operating system
- Bridge between hardware and software
- First program loaded at boot (after bootloader)
- Runs in privileged mode
- Has complete control over everything

Kernel Responsibilities:

1. Process Management
   - Creating/destroying processes
   - Scheduling (which process runs when)
   - Context switching
   - Inter-process communication

2. Memory Management
   - RAM allocation
   - Virtual memory
   - Paging and swapping
   - Memory protection between processes

3. Device Management
   - Device drivers
   - Hardware abstraction
   - /dev filesystem
   - Interrupt handling

4. File System Management
   - VFS (Virtual File System)
   - Multiple filesystem support
   - File operations
   - Directory structure

5. Network Management
   - Network stack (TCP/IP)
   - Socket operations
   - Network device drivers
   - Routing

Kernel Types:

Monolithic Kernel (Linux):
- All services in kernel space
- Fast (no context switching)
- Large kernel size
- Less modular

Microkernel:
- Minimal kernel
- Services in user space
- More stable (crashes isolated)
- Slower (more context switching)

Hybrid Kernel:
- Mix of both
- Windows, macOS use this

Linux Kernel Architecture:
┌─────────────────────────────────┐
│      User Applications          │
├─────────────────────────────────┤
│      System Libraries           │
│      (glibc, etc.)              │
├─────────────────────────────────┤
│      System Calls               │ ← User/Kernel boundary
├─────────────────────────────────┤
│      Linux Kernel               │
│  ┌───────────────────────────┐  │
│  │ Process Scheduler         │  │
│  │ Memory Manager            │  │
│  │ Virtual File System       │  │
│  │ Network Stack             │  │
│  │ Device Drivers            │  │
│  └───────────────────────────┘  │
├─────────────────────────────────┤
│         Hardware                │
└─────────────────────────────────┘

Kernel Space vs User Space:
- Kernel Space: Privileged, unrestricted access
- User Space: Limited, protected, safe
- System calls bridge the two spaces
EOF

cat kernel-overview.txt


## Task 1.2: Check Your Kernel Information
# Current kernel version
uname -r

# All system information
uname -a

# Detailed kernel info
cat /proc/version

# Kernel command line (boot parameters)
cat /proc/cmdline

# How long kernel has been running
uptime

# Kernel ring buffer (boot messages)
dmesg | head -50

# Create kernel info report
cat > kernel-info.txt << EOF
=== My System's Kernel Information ===

Kernel version: $(uname -r)
Kernel name: $(uname -s)
Architecture: $(uname -m)
Hostname: $(uname -n)

Full system info:
$(uname -a)

Detailed kernel:
$(cat /proc/version)

Boot parameters:
$(cat /proc/cmdline)

System uptime:
$(uptime)

Kernel compile date:
$(uname -v)
EOF

cat kernel-info.txt


## Task 1.3: Kernel Version Numbering
cat > kernel-versioning.txt << 'EOF'
=== Linux Kernel Versioning ===

Version Format: X.Y.Z-BUILD

Example: 5.15.0-91-generic

X = Major version (5)
Y = Minor version (15)
Z = Patch level (0)
BUILD = Distribution build number (91)
-generic = Distribution-specific suffix

Version History:
- 2.6.x  - 2003-2011 (long-term)
- 3.x    - 2011-2015
- 4.x    - 2015-2019
- 5.x    - 2019-2022
- 6.x    - 2022-present

Release Types:

Mainline:
- Latest development
- Cutting edge features
- May be unstable

Stable:
- Bug fixes for mainline
- Safe for production
- Regular updates

Long-term (LTS):
- Supported for years
- Enterprise use
- Critical fixes only

Current Kernel Versions (as of 2024):
- Latest: 6.x series
- LTS: 6.1, 5.15, 5.10, 5.4, 4.19

Ubuntu Kernel Versions:
- Ubuntu 20.04 LTS: 5.4
- Ubuntu 22.04 LTS: 5.15
- Ubuntu 24.04 LTS: 6.8

Checking for Updates:
apt search linux-image    # Available kernels
uname -r                  # Current kernel
EOF

cat kernel-versioning.txt
