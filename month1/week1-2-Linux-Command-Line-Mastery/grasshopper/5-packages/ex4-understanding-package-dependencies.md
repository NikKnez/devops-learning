# Exercise 4: Understanding Package Dependencies


## Task 4.1: What Are Dependencies?
cat > dependencies-explained.txt << 'EOF'
=== Package Dependencies ===

What is a dependency?
- Software package that another package needs to function
- Example: nginx depends on libc6, libssl, etc.

Types of dependencies:
1. Required (hard dependencies)
   - Package won't work without them
   - Must be installed

2. Recommended
   - Strongly suggested but not required
   - Installed by default with apt

3. Suggested
   - Optional enhancements
   - Not installed by default

Dependency hell (old problem):
- Package A needs Package B v1.5
- Package C needs Package B v2.0
- Conflict!

Modern solutions:
- Package managers resolve dependencies automatically
- Containers (Docker) bundle dependencies
- Snap/Flatpak include all dependencies
EOF

cat dependencies-explained.txt


## Task 4.2: Viewing Package Dependencies
# Show dependencies of installed package
apt-cache depends nginx 2>/dev/null || echo "nginx not installed"

# Show reverse dependencies (what depends on this package)
apt-cache rdepends nginx 2>/dev/null || echo "nginx not installed"

# Show dependencies of not-yet-installed package
apt-cache depends htop

# More detailed dependency info
apt-cache show htop | grep -E "Depends|Recommends|Suggests"

# Show dependency tree
apt-cache depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances htop | head -30


## Task 4.3: Simulating Package Installation
# Simulate install (shows what would be installed)
apt-get install -s tree

# Shows:
# - Main package
# - All dependencies
# - Disk space required
# - Doesn't actually install (simulation)

# Show what would be removed if you uninstall
apt-get remove -s nginx 2>/dev/null || echo "nginx not installed"


## Task 4.4: Broken Dependencies Exercise
# Check for broken dependencies
sudo apt-get check

# Fix broken dependencies (if any)
# sudo apt-get install -f

# Clean up orphaned packages
sudo apt-get autoremove

# Document dependency info for a package
cat > package-deps-example.txt << 'EOF'
=== Example: curl Dependencies ===

Direct dependencies:
$(apt-cache depends curl)

What depends on curl:
$(apt-cache rdepends curl | head -20)
EOF
