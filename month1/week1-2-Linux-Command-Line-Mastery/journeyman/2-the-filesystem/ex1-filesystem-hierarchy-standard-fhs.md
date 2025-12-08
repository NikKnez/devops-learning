# Exercise 1: Filesystem Hierarchy Standard (FHS)


## Task 1.1: Understanding FHS
# You already have the document from earlier, let's expand it
cat > fhs-complete.txt << 'EOF'
=== Complete Filesystem Hierarchy Standard ===

ROOT (/)
The root of everything. Only root user should write here.

ESSENTIAL BINARIES:
/bin        - User commands (ls, cp, cat, bash)
/sbin       - System administration commands (fsck, ip, reboot)
/usr/bin    - Non-essential user commands
/usr/sbin   - Non-essential system admin commands

CONFIGURATION:
/etc        - System-wide configuration files
/usr/local  - Locally installed software config

LIBRARIES:
/lib        - Essential shared libraries and kernel modules
/usr/lib    - Non-essential libraries

VARIABLE DATA:
/var        - Variable data (logs, mail, databases)
/var/log    - Log files
/var/tmp    - Temporary files (persistent across reboots)
/var/spool  - Print and mail queues

TEMPORARY:
/tmp        - Temporary files (deleted on reboot)

USER DATA:
/home       - User home directories
/root       - Root user's home directory

SYSTEM INFORMATION (Virtual Filesystems):
/proc       - Process information (virtual)
/sys        - Device and kernel information (virtual)
/dev        - Device files

MOUNT POINTS:
/mnt        - Temporary mount point
/media      - Removable media (USB, CD-ROM)

OPTIONAL:
/opt        - Optional application software packages
/srv        - Data for services (web, FTP)

BOOT:
/boot       - Boot loader files (kernel, initramfs)

DevOps Priority Directories:
1. /etc - Configuration management
2. /var/log - Log analysis
3. /opt - Custom application deployment
4. /home - User data and scripts
5. /tmp - Temporary build artifacts
EOF

cat fhs-complete.txt


## Task 1.2: Explore Each Directory
# Create exploration script
cat > explore-fhs.sh << 'EOF'
#!/bin/bash

echo "=== Filesystem Hierarchy Exploration ==="
echo ""

directories=(
    "/"
    "/bin"
    "/etc"
    "/home"
    "/var"
    "/tmp"
    "/usr"
    "/opt"
    "/boot"
)

for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        echo "Directory: $dir"
        echo "Size: $(du -sh $dir 2>/dev/null | cut -f1)"
        echo "Files: $(find $dir -maxdepth 1 -type f 2>/dev/null | wc -l)"
        echo "Subdirs: $(find $dir -maxdepth 1 -type d 2>/dev/null | wc -l)"
        echo "---"
    fi
done
EOF

chmod +x explore-fhs.sh
./explore-fhs.sh


## Task 1.3: Find Files in Hierarchy
# Where is the bash executable?
which bash

# Find all bash related files
find /bin /usr/bin -name "*bash*" 2>/dev/null

# Where are configuration files for nginx?
sudo find /etc -name "*nginx*" 2>/dev/null

# Where are log files stored?
ls -lh /var/log/ | head -10

# Document findings
cat > fhs-findings.txt << EOF
=== FHS Practical Findings ===

Bash location: $(which bash)
Config files: $(ls /etc | wc -l) files in /etc
Log files: $(ls /var/log 2>/dev/null | wc -l) files in /var/log
Home directories: $(ls /home 2>/dev/null | wc -l) users

My home directory: $HOME
Current PATH: $PATH
EOF

cat fhs-findings.txt
