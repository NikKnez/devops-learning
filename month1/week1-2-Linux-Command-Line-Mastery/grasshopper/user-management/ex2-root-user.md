# Exercise 2: Root User (Superuser)

## Task 2.1: Understanding Root
# Check if you're root
whoami
# Should show: nikola (not root)

# Check root's user ID
id root
# UID should be 0 (root always has UID 0)

# Try command without sudo (will fail)
apt update
# You'll get: Permission denied

# Try with sudo (will work)
sudo apt update
# Enter your password


## Task 2.2: sudo vs su
# Run single command as root
sudo whoami
# Shows: root

# Check who can use sudo
sudo cat /etc/sudoers | grep -v "^#" | grep -v "^$"

# Check if you're in sudo group
groups nikola | grep sudo

# WARNING: Don't actually run this, just understand it
# su - root     # Switch to root user (not recommended)
# exit          # Would exit back to your user


## Task 2.3: Root Permissions Practice
# Create file as regular user
touch user-file.txt
ls -l user-file.txt
# Owner: nikola

# Try to create file in /root (will fail)
touch /root/test.txt
# Permission denied

# Create file in /root with sudo
sudo touch /root/test-sudo.txt
sudo ls -l /root/test-sudo.txt
# Owner: root

# Clean up
sudo rm /root/test-sudo.txt

