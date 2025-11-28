# Exercise 3: Ownership and Groups (chown, chgrp)


## Task 3.1: Understanding Ownership
# Check who owns your files
ls -l

# Format: owner:group
# Example: nikola:nikola

# Check your current user and groups
id
whoami
groups


## Task 3.2: Change Group Ownership
# Create test file
touch group-test.txt
ls -l group-test.txt

# View available groups
groups nikola

# Change group (pick a group you're member of)
# Example: if you're in 'sudo' group
sudo chgrp sudo group-test.txt
ls -l group-test.txt

# Change back
sudo chgrp nikola group-test.txt
ls -l group-test.txt


## Task 3.3: Change User Ownership (Requires sudo)
# Create test file
touch owner-test.txt
ls -l owner-test.txt

# Change owner to root
sudo chown root owner-test.txt
ls -l owner-test.txt

# Try to modify it as your user (will fail)
echo "test" > owner-test.txt
# Permission denied

# Change back to your user
sudo chown nikola owner-test.txt
ls -l owner-test.txt

# Now you can modify it
echo "test" > owner-test.txt


# Task 3.4: Change Owner and Group Simultaneously
# Create test file
touch combined-test.txt

# Change owner and group in one command
sudo chown root:root combined-test.txt
ls -l combined-test.txt

# Change back
sudo chown nikola:nikola combined-test.txt
ls -l combined-test.txt


# Task 3.5: Recursive Ownership Change
# Create directory structure
mkdir -p ownership-test/subdir
touch ownership-test/file1.txt
touch ownership-test/subdir/file2.txt

# Change ownership recursively
sudo chown -R root:root ownership-test/
ls -lR ownership-test/

# Change back
sudo chown -R nikola:nikola ownership-test/
ls -lR ownership-test/
