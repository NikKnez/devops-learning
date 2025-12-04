# Exercise 7: Compiling from Source


## Task 7.1: Understanding Source Compilation
cat > source-compilation.txt << 'EOF'
=== Compiling from Source ===

Why compile from source?
- Latest version (not in repositories)
- Custom configuration options
- Optimizations for your system
- Learning experience

Typical process:
1. Download source code (.tar.gz)
2. Extract archive
3. Read README/INSTALL
4. Install build dependencies
5. Configure: ./configure
6. Compile: make
7. Install: make install

Build dependencies (Ubuntu):
sudo apt install build-essential

Common configure options:
./configure --prefix=/usr/local     # Install location
./configure --help                  # Show all options

Pros:
+ Latest versions
+ Full control
+ Custom optimizations

Cons:
- No automatic updates
- Manual dependency management
- Can break system
- Hard to uninstall cleanly
- Time-consuming

Recommendation:
- Use package manager when possible
- Compile only when necessary
- Install to /usr/local or /opt
EOF

cat source-compilation.txt


## Task 7.2: Install Build Tools
# Install essential build tools
sudo apt update
sudo apt install -y build-essential

# What did we install?
dpkg -L build-essential | grep bin

# Verify tools are available
which gcc
which make
which g++

gcc --version
make --version

# These are needed to compile most software


## Task 7.3: Compile Simple C Program
# Create simple C program
cat > hello.c << 'EOF'
#include <stdio.h>

int main() {
    printf("Hello from compiled program!\n");
    printf("Compiled on: %s %s\n", __DATE__, __TIME__);
    return 0;
}
EOF

# Compile it
gcc hello.c -o hello

# Run it
./hello

# Check binary type
file hello

# Check dependencies
ldd hello

# Clean up
rm hello hello.c


## Task 7.4: Compile Real Software (Example: htop from source)
# Create directory for source builds
mkdir -p ~/source-builds
cd ~/source-builds

# Install dependencies needed for htop
sudo apt install -y libncurses-dev autotools-dev autoconf

# Download htop source (example - check for latest version)
wget https://github.com/htop-dev/htop/releases/download/3.2.1/htop-3.2.1.tar.gz

# Extract
tar -xzf htop-3.2.1.tar.gz
cd htop-3.2.1/

# Read documentation
cat README

# Configure (check what options are available)
./configure --help | head -30

# Configure with custom prefix
./configure --prefix=$HOME/local-htop

# Compile
make

# Install to our custom location (not system-wide)
make install

# Test our compiled version
$HOME/local-htop/bin/htop --version

# Our compiled version vs system version
which htop
$HOME/local-htop/bin/htop --version

# Clean up (optional)
cd ~/devops-learning/month1/week1/packages
rm -rf ~/source-builds/htop-3.2.1*


## Task 7.5: Typical Configure-Make-Install Process
cat > compile-workflow.sh << 'EOF'
#!/bin/bash

# Standard source compilation workflow
# DO NOT RUN - This is a template

# 1. Download source
wget http://example.com/software-1.0.tar.gz

# 2. Extract
tar -xzf software-1.0.tar.gz
cd software-1.0/

# 3. Read documentation
cat README
cat INSTALL

# 4. Install build dependencies
sudo apt install build-essential [other-deps]

# 5. Configure
./configure --prefix=/usr/local

# 6. Compile
make

# 7. Test (if available)
make test

# 8. Install
sudo make install

# 9. Verify
which software
software --version

# 10. Uninstall (if needed later)
# sudo make uninstall
# OR manually:
# sudo rm /usr/local/bin/software
EOF

chmod +x compile-workflow.sh
cat compile-workflow.sh
