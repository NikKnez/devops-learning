# Exercise 1: Understanding Users and Groups

## Task 1.1: Check Your Current User Info
# Who am I?
whoami

# My user ID
id

# Detailed user information
id -u    # User ID number
id -g    # Group ID number
id -un   # Username
id -gn   # Group name

# All groups I belong to
groups

# Complete user info
finger nikola  # If installed, if not: sudo apt install finger


## Document output:
echo "=== My User Info ===" > user-info.txt
whoami >> user-info.txt
id >> user-info.txt
groups >> user-info.txt


## Task 1.2: List All Users on System
# View all users (simple)
cat /etc/passwd | cut -d: -f1

# Count total users
cat /etc/passwd | wc -l

# View only human users (UID >= 1000)
awk -F: '$3 >= 1000 {print $1}' /etc/passwd

# Your task: How many users are on your system?


## Task 1.3: List All Groups
# View all groups
cat /etc/group | cut -d: -f1

# Count total groups
cat /etc/group | wc -l

# Find which groups user 'nikola' belongs to
groups nikola

# Find all members of 'sudo' group
grep '^sudo:' /etc/group 

























