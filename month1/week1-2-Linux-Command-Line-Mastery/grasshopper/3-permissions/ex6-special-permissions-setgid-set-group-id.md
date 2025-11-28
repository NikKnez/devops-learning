# Exercise 6: Special Permissions - setgid (Set Group ID)


## Task 6.1: Understanding setgid on Files
# Create test file
touch setgid-file.sh
chmod g+s setgid-file.sh
ls -l setgid-file.sh
# Shows: -rwxr-sr-x (s in group execute position)

# Numeric method
chmod 2755 setgid-file.sh
ls -l setgid-file.sh


## Task 6.2: setgid on Directories (Important!)
# Create shared directory
mkdir shared-project
ls -ld shared-project

# Add setgid to directory
chmod g+s shared-project
ls -ld shared-project
# Shows: drwxr-sr-x

# Test: Create file inside
touch shared-project/test-file.txt
ls -l shared-project/test-file.txt
# File inherits directory's group!

# This is useful for team collaboration


# Task 6.3: Practical setgid Use Case
# Scenario: Team project directory

# Create team directory
mkdir team-project

# Set group ownership
sudo chgrp nikola team-project

# Add setgid + group write permissions
chmod 2775 team-project
ls -ld team-project

# Now all files created inside will have 'nikola' group
touch team-project/member1-file.txt
touch team-project/member2-file.txt
ls -l team-project/

# Document the setup
cat > setgid-usecase.txt << 'EOF'
=== setgid Directory Use Case ===

Problem: Multiple users working in same directory
Solution: setgid on directory

Benefits:
1. All files inherit directory's group
2. Group members can modify each other's files
3. No manual chgrp needed for each file

Setup:
mkdir shared-dir
chgrp teamname shared-dir
chmod 2775 shared-dir

Result: All files created inside automatically get 'teamname' group
EOF

cat setgid-usecase.txt
