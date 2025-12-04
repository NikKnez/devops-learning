# Exercise 8: Package Management Best Practices


## Task 8.1: System Maintenance Routine
# Create maintenance script
cat > system-maintenance.sh << 'EOF'
#!/bin/bash

echo "=== System Package Maintenance ==="
echo ""

echo "[1/5] Updating package lists..."
sudo apt update

echo ""
echo "[2/5] Upgrading packages..."
sudo apt upgrade -y

echo ""
echo "[3/5] Removing orphaned packages..."
sudo apt autoremove -y

echo ""
echo "[4/5] Cleaning package cache..."
sudo apt clean

echo ""
echo "[5/5] Checking for broken dependencies..."
sudo apt-get check

echo ""
echo "=== Maintenance Complete ==="
echo "Disk space freed: $(df -h / | tail -1 | awk '{print $4}' )"
EOF

chmod +x system-maintenance.sh

# Document when to run it
cat >> system-maintenance.sh << 'EOF'

# Run this script:
# - Weekly for desktop/development systems
# - Before major software installations
# - After removing large packages
# - Monthly for servers
EOF

cat system-maintenance.sh


## Task 8.2: Document Installed Packages
# Create list of manually installed packages
apt-mark showmanual > manually-installed-packages.txt

# Count them
wc -l manually-installed-packages.txt

# Create full system package list
dpkg -l > all-installed-packages.txt

# Count all packages
wc -l all-installed-packages.txt

# This is useful for:
# - System backup/restore
# - Recreating environment on new machine
# - Audit what's installed


## Task 8.3: Package Installation Safety
cat > package-safety.txt << 'EOF'
=== Package Installation Safety ===

BEFORE installing:
1. sudo apt update           # Get latest package info
2. apt show package          # Read package description
3. apt-cache depends package # Check dependencies
4. apt-cache policy package  # Check version/source

SAFE practices:
✓ Only install from official repositories
✓ Read package descriptions
✓ Check package size (huge packages = investigate)
✓ Use apt instead of downloading random .deb files
✓ Regular updates: sudo apt update && sudo apt upgrade

AVOID:
✗ Adding untrusted PPAs
✗ Installing .deb from random websites
✗ Compiling as root
✗ Ignoring dependency warnings
✗ Never updating

TROUBLESHOOTING:
sudo apt-get install -f    # Fix broken dependencies
sudo dpkg --configure -a   # Fix interrupted installations
sudo apt clean             # Clear cache
sudo apt update            # Refresh lists
EOF

cat package-safety.txt
