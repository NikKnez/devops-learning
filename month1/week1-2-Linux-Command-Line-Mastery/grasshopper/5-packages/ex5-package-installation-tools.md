# Exercise 5: Package Installation Tools


## Task 5.1: apt vs apt-get vs dpkg
cat > package-tools.txt << 'EOF'
=== Package Management Tools (Ubuntu/Debian) ===

apt (High-level, user-friendly)
- Modern interface (Ubuntu 16.04+)
- Better progress bars
- Combines apt-get and apt-cache
- Use this for interactive work

Commands:
apt update              # Update package lists
apt upgrade             # Upgrade packages
apt install package     # Install package
apt remove package      # Remove package
apt search keyword      # Search for package
apt show package        # Show package info

apt-get (Traditional, script-friendly)
- Stable interface
- Use in scripts
- More options

Commands:
apt-get update
apt-get upgrade
apt-get install package
apt-get remove package
apt-get autoremove      # Remove orphaned packages
apt-get clean           # Clear cache

dpkg (Low-level, package files)
- Works with .deb files directly
- No dependency resolution
- Lower-level tool

Commands:
dpkg -i package.deb     # Install .deb file
dpkg -r package         # Remove package
dpkg -l                 # List installed packages
dpkg -L package         # List files in package
dpkg -S /path/to/file   # Find which package owns file

aptitude (Alternative TUI)
- Text-based interactive interface
- Better dependency resolver
- Not installed by default
EOF

cat package-tools.txt


## Task 5.2: Using apt Commands
# Update package lists
sudo apt update

# Search for package
apt search tree

# Show package information
apt show tree

# Install package
sudo apt install tree

# Verify installation
which tree
tree --version

# List files installed by package
dpkg -L tree

# Find which package owns a file
dpkg -S /usr/bin/tree

# Show installed package info
dpkg -l tree

# Remove package (keep config files)
# sudo apt remove tree

# Remove package (remove config files)
# sudo apt purge tree

# Remove orphaned dependencies
sudo apt autoremove


## Task 5.3: Working with .deb Files
# Download a .deb file (without installing)
apt download tree

# List downloaded .deb
ls -lh tree*.deb

# View .deb file contents
dpkg --contents tree*.deb

# View .deb package info
dpkg --info tree*.deb

# Extract .deb without installing
dpkg-deb -x tree*.deb extracted-tree/
ls -lR extracted-tree/

# Install .deb manually (if you wanted to)
# sudo dpkg -i tree*.deb

# Clean up
rm tree*.deb
rm -rf extracted-tree/


## Task 5.4: Package Cache and Cleaning
# Show cache location
ls -lh /var/cache/apt/archives/ | head

# Check disk space used by cache
du -sh /var/cache/apt/archives/

# Clear old packages from cache
sudo apt clean

# Check space again
du -sh /var/cache/apt/archives/

# Only remove packages that can't be downloaded anymore
sudo apt autoclean

