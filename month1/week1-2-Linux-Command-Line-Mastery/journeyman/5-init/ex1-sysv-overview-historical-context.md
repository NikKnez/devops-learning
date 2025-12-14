# Exercise 1: SysV Overview (Historical Context)


## Task 1.1: Understanding SysV Init
cat > sysv-overview.txt << 'EOF'
=== SysV Init System (System V) ===

Historical Context:
- Traditional Unix init system
- Used from 1980s until mid-2000s
- Still found on older systems
- Replaced by Upstart (Ubuntu) and systemd (most modern distros)

What is Init?
- First process started by kernel (PID 1)
- Parent of all other processes
- Responsible for starting system services
- Manages system runlevels

SysV Components:

1. /sbin/init
   - The init process itself
   - Reads /etc/inittab

2. /etc/inittab
   - Configuration file
   - Defines runlevels
   - Specifies what to run at each level

3. /etc/init.d/
   - Service scripts
   - Start/stop/restart services
   - Shell scripts with standard functions

4. /etc/rc*.d/
   - Runlevel directories
   - rc0.d, rc1.d, rc2.d, rc3.d, rc4.d, rc5.d, rc6.d
   - Contain symlinks to /etc/init.d/ scripts

Runlevels:
0 - Halt (shutdown)
1 - Single-user mode (maintenance)
2 - Multi-user mode (no networking)
3 - Multi-user mode with networking
4 - Unused (custom)
5 - Multi-user with GUI (X11)
6 - Reboot

How SysV Works:
1. Kernel starts /sbin/init
2. Init reads /etc/inittab
3. Init enters default runlevel
4. Init runs scripts in /etc/rcN.d/
5. Scripts starting with S (Start) run in order
6. Scripts starting with K (Kill) stop services

Script Naming:
S10network  - Start, priority 10
S20apache   - Start, priority 20
K80apache   - Kill, priority 80

Problems with SysV:
- Sequential startup (slow)
- No dependency management
- Shell scripts (error-prone)
- No parallelization
- Difficult to debug

Why It's Still Relevant:
- Legacy systems still use it
- Understanding helps with systemd
- Init scripts still exist for compatibility
- Many concepts carried forward
EOF

cat sysv-overview.txt


## Task 1.2: Check If SysV Remnants Exist
# Your system (Ubuntu/Debian modern) uses systemd
# But may have SysV compatibility layer

# Check init system
ps -p 1 -o comm=
# Shows: systemd (not init)

# Check for SysV directories (compatibility)
ls -ld /etc/init.d/ 2>/dev/null
ls -ld /etc/rc*.d/ 2>/dev/null

# List SysV-style scripts (if any)
ls /etc/init.d/ 2>/dev/null | head -10

# These are maintained for backward compatibility
# but systemd actually manages the services

# Create comparison document
cat > init-system-check.txt << EOF
=== Current Init System ===

Init process (PID 1): $(ps -p 1 -o comm=)

SysV compatibility directories:
$(ls -ld /etc/init.d/ /etc/rc*.d/ 2>/dev/null)

Init system in use: $(ps -p 1 -o comm=)
- Modern systems use systemd
- SysV directories exist for compatibility
- Scripts redirect to systemd
EOF

cat init-system-check.txt
