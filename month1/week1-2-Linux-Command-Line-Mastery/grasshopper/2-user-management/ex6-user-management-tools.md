# Exercise 6: User Management Tools


## Task 6.1: Create Test Users
# Create a test user
sudo useradd testuser1

# Verify user was created
grep "^testuser1:" /etc/passwd
sudo grep "^testuser1:" /etc/shadow

# Check home directory (might not exist yet)
ls -la /home/testuser1
# May show: No such file or directory

# Create user WITH home directory
sudo useradd -m testuser2
ls -la /home/testuser2
# Should show home directory contents

# Create user with specific shell and comment
sudo useradd -m -s /bin/bash -c "Test User Three" testuser3

# Verify
grep "^testuser3:" /etc/passwd


## Task 6.2: Set and Change Passwords
# Set password for testuser1
sudo passwd testuser1
# Enter new password twice

# Check password status
sudo passwd -S testuser1

# Lock user account
sudo passwd -l testuser1
sudo passwd -S testuser1
# Shows: L (locked)

# Unlock user account
sudo passwd -u testuser1
sudo passwd -S testuser1
# Shows: P (password set)


## Task 6.3: Modify Users (usermod)
# Add testuser1 to sudo group
sudo usermod -aG sudo testuser1

# Verify
groups testuser1

# Change user's shell
sudo usermod -s /bin/zsh testuser1
grep "^testuser1:" /etc/passwd

# Change back to bash
sudo usermod -s /bin/bash testuser1

# Change user's home directory
sudo usermod -d /home/newlocation testuser1
grep "^testuser1:" /etc/passwd

# Change back
sudo usermod -d /home/testuser1 testuser1

# Change username
sudo usermod -l testuser1_renamed testuser1
grep "testuser1" /etc/passwd

# Change back
sudo usermod -l testuser1 testuser1_renamed


## Task 6.4: Group Management
# Create a new group
sudo groupadd developers

# Verify
grep "^developers:" /etc/group

# Add user to group
sudo usermod -aG developers testuser1

# Verify
groups testuser1

# Create another group with specific GID
sudo groupadd -g 5000 testers

# Verify
grep "^testers:" /etc/group

# Rename group
sudo groupmod -n devteam developers

# Verify
grep "devteam" /etc/group

# Delete group
sudo groupdel testers


## Task 6.5: Delete Users
# Delete user (keep home directory)
sudo userdel testuser2
ls -la /home/testuser2
# Home directory still exists

# Delete user and home directory
sudo userdel -r testuser3
ls -la /home/testuser3
# No such file or directory

# Clean up remaining test user
sudo userdel -r testuser1

# Verify all deleted
grep "testuser" /etc/passwd
