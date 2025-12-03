# Exercise 1: Understanding Software Distribution


## Task 1.1: Different Software Distribution Methods
cat > software-distribution.txt << 'EOF'
=== Software Distribution Methods ===

1. Package Managers (Recommended)
   - apt (Debian/Ubuntu)
   - yum/dnf (RedHat/CentOS)
   - pacman (Arch)
   - Advantages: Dependency management, updates, easy removal
   - Example: apt install nginx

2. Pre-compiled Binaries
   - Download .deb, .rpm, .tar.gz files
   - Install manually
   - Example: dpkg -i package.deb

3. Source Code Compilation
   - Download source (.tar.gz)
   - Compile with make
   - Most control, but complex
   - Example: ./configure && make && make install

4. Snap/Flatpak/AppImage (Universal)
   - Work across distributions
   - Self-contained with dependencies
   - Larger file sizes

5. Language-specific Managers
   - Python: pip
   - Node.js: npm
   - Ruby: gem
   - Not system-wide package managers
EOF

cat software-distribution.txt


## Task 1.2: Check Your Distribution
# What Linux distribution are you on?
cat /etc/os-release

# Ubuntu/Debian version
lsb_release -a

# Which package manager?
which apt
which dpkg

# Document your system
cat > my-system-info.txt << EOF
Distribution: $(lsb_release -d | cut -f2)
Version: $(lsb_release -r | cut -f2)
Package Manager: apt/dpkg
EOF

cat my-system-info.txt
