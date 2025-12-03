# Exercise 2: Package Repositories


## Task 2.1: Understanding Repositories
cat > repositories-explained.txt << 'EOF'
=== Package Repositories ===

What is a repository?
- Server hosting software packages
- Contains metadata (package info, dependencies)
- Ensures software authenticity (GPG signatures)

Ubuntu repositories:
- main: Officially supported open source
- universe: Community-maintained open source
- restricted: Proprietary drivers
- multiverse: Software with copyright/legal issues

Repository sources location:
- /etc/apt/sources.list (main file)
- /etc/apt/sources.list.d/ (additional repos)

Repository format:
deb [arch=amd64] http://archive.ubuntu.com/ubuntu/ jammy main restricted
│   │            │                                  │     │
│   └─ Architecture                                 │     └─ Components
│                                                    │
└─ Package type (deb or deb-src)                    └─ Distribution
EOF

cat repositories-explained.txt


## Task 2.2: View Your Repositories
# Main repository file
cat /etc/apt/sources.list

# Additional repositories
ls -la /etc/apt/sources.list.d/

# Show enabled repositories only (no comments)
grep -v "^#" /etc/apt/sources.list | grep -v "^$"

# Save to file
grep -v "^#" /etc/apt/sources.list | grep -v "^$" > my-repositories.txt
cat my-repositories.txt


## Task 2.3: Update Package Lists
# Update package lists from repositories
sudo apt update

# What this does:
# 1. Connects to each repository
# 2. Downloads package metadata
# 3. Updates local package database

# Output shows:
# - Hit: No changes
# - Get: Downloading updates
# - Ign: Ignored

# Check when last updated
ls -l /var/lib/apt/lists/ | head


## Task 2.4: Add PPA Repository (Personal Package Archive)
# Example: Add a PPA (don't actually run unless you need it)
# This is how you would add third-party software

cat > add-repository-example.txt << 'EOF'
=== Adding Third-Party Repository ===

Method 1: add-apt-repository command
sudo add-apt-repository ppa:user/ppa-name
sudo apt update

Method 2: Manual addition
echo "deb http://ppa.launchpad.net/user/ppa-name/ubuntu jammy main" | \
  sudo tee /etc/apt/sources.list.d/ppa-name.list
sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys KEY_ID
sudo apt update

Method 3: Direct .list file
sudo nano /etc/apt/sources.list.d/custom.list
# Add repository line
sudo apt update

Security note:
- Only add trusted repositories
- PPAs can break your system
- Third-party software may have security issues
EOF

cat add-repository-example.txt
