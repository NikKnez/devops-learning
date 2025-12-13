# Exercise 6: Kernel Modules


## Task 6.1: Understanding Kernel Modules
cat > kernel-modules-guide.txt << 'EOF'
=== Linux Kernel Modules ===

What are Kernel Modules?
- Pieces of kernel code
- Loaded/unloaded dynamically
- Extend kernel functionality
- No need to recompile kernel
- Also called: LKMs (Loadable Kernel Modules)

Why Modules?

Advantages:
- Smaller kernel image
- Load only needed drivers
- Easy updates
- No reboot for driver changes

vs Built-in:
- Built-in: Compiled into kernel
- Modules: Loaded on demand
- Built-in: Always in memory
- Modules: Can be unloaded

Types of Modules:
- Device drivers (USB, graphics, network)
- Filesystem drivers (ext4, ntfs, nfs)
- Network protocols
- Cryptographic functions

Module Files:
- Extension: .ko (Kernel Object)
- Location: /lib/modules/$(uname -r)/
- Config: /etc/modprobe.d/

Module Commands:

lsmod
- List loaded modules
- Shows: name, size, usage count

modinfo <module>
- Show module information
- Version, author, description, parameters

modprobe <module>
- Load module (smart way)
- Handles dependencies automatically
- Preferred method

insmod <path/to/module.ko>
- Load module (manual way)
- No dependency handling
- Need full path

rmmod <module>
- Unload module
- Fails if in use

modprobe -r <module>
- Unload module (smart way)
- Handles dependencies

Automatic Loading:
- udev detects hardware
- Loads appropriate modules
- /etc/modules - modules to load at boot
- /etc/modprobe.d/ - module configurations

Module Parameters:
- Modules can accept parameters
- Set at load time
- Example: modprobe module param=value

Blacklisting Modules:
- Prevent auto-loading
- Add to /etc/modprobe.d/blacklist.conf
- Format: blacklist module_name

Common Modules:
e1000e      - Intel ethernet
iwlwifi     - Intel WiFi
nouveau     - Nvidia open driver
nvidia      - Nvidia proprietary
snd-hda     - HD audio
usb-storage - USB storage
ext4        - ext4 filesystem
nfs         - Network filesystem
EOF

cat kernel-modules-guide.txt


## Task 6.2: Exploring Loaded Modules
# List all loaded modules
lsmod

# Count loaded modules
lsmod | wc -l

# Show modules using most memory
lsmod | sort -k2 -rn | head -10

# Find specific module
lsmod | grep -i usb

# Module information
modinfo usbcore

# Show module dependencies
modinfo usbcore | grep depends

# Find module file
modprobe --show-depends usbcore

# Create modules analysis
cat > modules-analysis.txt << EOF
=== Loaded Kernel Modules Analysis ===

Total modules loaded: $(lsmod | tail -n +2 | wc -l)

Top 10 largest modules:
$(lsmod | tail -n +2 | sort -k2 -rn | head -10)

USB-related modules:
$(lsmod | grep -i usb | awk '{print $1}')

Network modules:
$(lsmod | grep -E "net|eth|wlan" | awk '{print $1}')

Filesystem modules:
$(lsmod | grep -E "ext4|xfs|btrfs|nfs" | awk '{print $1}')
EOF

cat modules-analysis.txt


## Task 6.3: Module Information
# Create module info script
cat > module-info.sh << 'EOF'
#!/bin/bash

echo "=== Kernel Module Information ==="
echo ""

# Pick a common module
MODULE="e1000e"  # Intel ethernet driver

echo "Module: $MODULE"
echo ""

# Check if loaded
if lsmod | grep -q "^$MODULE"; then
    echo "Status: LOADED"
    echo ""
    lsmod | grep "^$MODULE"
else
    echo "Status: Not loaded"
fi

echo ""
echo "Module Information:"
modinfo $MODULE 2>/dev/null | head -15

echo ""
echo "Module Location:"
find /lib/modules/$(uname -r) -name "$MODULE.ko*" 2>/dev/null

echo ""
echo "=== Common Useful Modules ==="
echo ""

modules=("usbcore" "ext4" "nf_conntrack" "ip_tables")

for mod in "${modules[@]}"; do
    if lsmod | grep -q "^$mod"; then
        echo "✓ $mod - LOADED"
    else
        echo "✗ $mod - not loaded"
    fi
done
EOF

chmod +x module-info.sh
./module-info.sh


## Task 6.4: Module Management Practice
# Create module management guide
cat > module-management-practice.txt << 'EOF'
=== Module Management Commands ===

VIEWING:
lsmod                          # List loaded modules
lsmod | grep module_name       # Find specific module
modinfo module_name            # Module details
modprobe --show-depends mod    # Show dependencies

LOADING (as root):
sudo modprobe module_name      # Load module (smart)
sudo insmod /path/to/mod.ko    # Load module (manual)

UNLOADING (as root):
sudo modprobe -r module_name   # Unload (smart)
sudo rmmod module_name         # Unload (manual)

CONFIGURATION:
/etc/modules                   # Load at boot
/etc/modprobe.d/*.conf         # Module options

BLACKLISTING:
File: /etc/modprobe.d/blacklist.conf
Content: blacklist module_name

Example: Blacklist nouveau (Nvidia open driver)
echo "blacklist nouveau" | sudo tee /etc/modprobe.d/blacklist-nouveau.conf

PARAMETERS:
modprobe module param=value    # Load with parameter
cat /sys/module/mod/parameters/* # View current parameters

DEBUGGING:
dmesg | grep module_name       # Kernel messages about module
journalctl | grep module_name  # System logs

Real-world Examples:

1. Load USB storage support:
   sudo modprobe usb-storage

2. Check ethernet driver:
   lsmod | grep e1000
   modinfo e1000e

3. Reload network module:
   sudo modprobe -r module_name
   sudo modprobe module_name

4. View module parameters:
   ls /sys/module/*/parameters/

WARNING:
- Don't unload critical modules (filesystem, etc.)
- System may crash if module in use
- Always check usage count before unloading
- Use modprobe over insmod/rmmod
EOF

cat module-management-practice.txt
