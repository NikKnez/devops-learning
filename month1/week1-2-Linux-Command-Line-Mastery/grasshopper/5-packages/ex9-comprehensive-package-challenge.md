# Exercise 9: Comprehensive Package Challenge


## Task 9.1: Complete Package Management Scenario
# Scenario: Set up development environment

# 1. Update system
sudo apt update

# 2. Install git
sudo apt install -y git
git --version

# 3. Install curl
sudo apt install -y curl
curl --version

# 4. Install tree
sudo apt install -y tree
tree --version

# 5. Install ncdu (disk usage analyzer)
sudo apt install -y ncdu
ncdu --version

# 6. Document what was installed
cat > dev-environment-setup.txt << EOF
=== Development Environment Setup ===
Date: $(date)

Packages installed:
- git: $(git --version)
- curl: $(curl --version)
- tree: $(tree --version)
- ncdu: $(ncdu --version)

Dependencies automatically installed:
$(apt-cache depends git curl tree ncdu | grep Depends | wc -l) total

Disk space used:
$(dpkg -L git curl tree ncdu 2>/dev/null | wc -l) files installed
EOF

cat dev-environment-setup.txt

# 7. Test each tool
git --version
curl -I https://google.com | head -5
tree -L 1 /etc | head -10
# ncdu --help
