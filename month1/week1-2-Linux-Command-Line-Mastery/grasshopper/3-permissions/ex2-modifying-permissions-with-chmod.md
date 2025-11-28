# Exercise 2: Modifying Permissions with chmod


## Task 2.1: Symbolic Method
# Create test file
echo "Test file for chmod practice" > chmod-test.txt
ls -l chmod-test.txt

# Add execute permission for owner
chmod u+x chmod-test.txt
ls -l chmod-test.txt

# Remove write permission for group
chmod g-w chmod-test.txt
ls -l chmod-test.txt

# Add read permission for others
chmod o+r chmod-test.txt
ls -l chmod-test.txt

# Set exact permissions (replace all)
chmod u=rwx,g=rx,o=r chmod-test.txt
ls -l chmod-test.txt

# Add execute for everyone
chmod a+x chmod-test.txt
ls -l chmod-test.txt

# Remove execute for everyone
chmod a-x chmod-test.txt
ls -l chmod-test.txt


## Task 2.2: Numeric (Octal) Method
# Create new test file
echo "Numeric chmod test" > numeric-test.txt

# Set to 644 (rw-r--r--)
chmod 644 numeric-test.txt
ls -l numeric-test.txt

# Set to 755 (rwxr-xr-x)
chmod 755 numeric-test.txt
ls -l numeric-test.txt

# Set to 700 (rwx------)
chmod 700 numeric-test.txt
ls -l numeric-test.txt

# Set to 777 (rwxrwxrwx) - dangerous!
chmod 777 numeric-test.txt
ls -l numeric-test.txt

# Set to 000 (---------)
chmod 000 numeric-test.txt
ls -l numeric-test.txt

# Try to read it (will fail)
cat numeric-test.txt
# Permission denied

# Fix it back
chmod 644 numeric-test.txt


## Task 2.3: Recursive Permissions
# Create directory structure
mkdir -p test-dir/subdir1/subdir2
touch test-dir/file1.txt
touch test-dir/subdir1/file2.txt
touch test-dir/subdir1/subdir2/file3.txt

# Check current permissions
ls -lR test-dir

# Change all files recursively to 644
find test-dir -type f -exec chmod 644 {} \;

# Change all directories recursively to 755
find test-dir -type d -exec chmod 755 {} \;

# Verify
ls -lR test-dir

# Alternative: chmod with -R (changes everything)
chmod -R 755 test-dir
ls -lR test-dir


## Task 2.4: Practice Challenge
# Create these files and set specific permissions:

# 1. secret.txt - only you can read/write
touch secret.txt
chmod 600 secret.txt
ls -l secret.txt

# 2. script.sh - owner can do everything, others can only read/execute
touch script.sh
chmod 755 script.sh
ls -l script.sh

# 3. shared.txt - everyone can read/write (dangerous but for practice)
touch shared.txt
chmod 666 shared.txt
ls -l shared.txt

# 4. readonly.txt - everyone can read, nobody can write
touch readonly.txt
chmod 444 readonly.txt
ls -l readonly.txt

# Try to modify readonly.txt (should fail)
echo "new content" > readonly.txt
# Permission denied

# Fix it to modify
chmod 644 readonly.txt
echo "now it works" > readonly.txt
