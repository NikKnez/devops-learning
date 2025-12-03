# Exercise 6: Complete Package Management Workflow


## Task 6.1: Install htop (Process Monitor)
# 1. Update package lists
sudo apt update

# 2. Search for package
apt search htop

# 3. Show package details
apt show htop

# 4. Check if already installed
dpkg -l | grep htop

# 5. Install package
sudo apt install -y htop

# 6. Verify installation
which htop
htop --version

# 7. Run it
# htop
# Press q to quit

# 8. Find all files installed
dpkg -L htop

# 9. Show package status
dpkg -s htop

# Document the process
cat > htop-install-log.txt << EOF
Package: htop
Action: Installed
Date: $(date)
Version: $(htop --version | head -1)
Files installed: $(dpkg -L htop | wc -l)
Dependencies: $(apt-cache depends htop | grep Depends | wc -l)
EOF

cat htop-install-log.txt


## Task 6.2: Upgrade Packages
# List upgradable packages
apt list --upgradable

# Upgrade specific package
# sudo apt upgrade package-name

# Upgrade all packages
# sudo apt upgrade

# Full upgrade (may remove packages)
# sudo apt full-upgrade

# Dist upgrade (for distribution upgrades)
# sudo apt dist-upgrade


## Task 6.3: Hold and Unhold Packages
# Prevent package from being upgraded
sudo apt-mark hold htop

# Show held packages
apt-mark showhold

# Unhold package
sudo apt-mark unhold htop

# Show manual vs automatic installations
apt-mark showmanual | head -20
apt-mark showauto | head -20
