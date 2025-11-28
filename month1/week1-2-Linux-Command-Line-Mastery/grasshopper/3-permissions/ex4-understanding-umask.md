# Exercise 4: Understanding umask


## Task 4.1: View Current umask
# Check your umask
umask

# Common output: 0002 or 0022
# This is in octal

# View in symbolic notation
umask -S


## Task 4.2: How umask Works
# Create explanation file
cat > umask-explanation.txt << 'EOF'
=== How umask Works ===

Default maximum permissions:
- Files: 666 (rw-rw-rw-)
- Directories: 777 (rwxrwxrwx)

umask SUBTRACTS from these defaults.

Example with umask 0022:
Files: 666 - 022 = 644 (rw-r--r--)
Directories: 777 - 022 = 755 (rwxr-xr-x)

Example with umask 0002:
Files: 666 - 002 = 664 (rw-rw-r--)
Directories: 777 - 002 = 775 (rwxrwxr-x)

Example with umask 0077:
Files: 666 - 077 = 600 (rw-------)
Directories: 777 - 077 = 700 (rwx------)
EOF

cat umask-explanation.txt


## Task 4.3: Test Default Permissions
# Check current umask
umask

# Create file and directory
touch umask-file.txt
mkdir umask-dir

# Check their permissions
ls -ld umask-file.txt umask-dir

# Document the results
echo "Current umask: $(umask)" > umask-results.txt
echo "File permissions: $(ls -l umask-file.txt)" >> umask-results.txt
echo "Dir permissions: $(ls -ld umask-dir)" >> umask-results.txt


## Task 4.4: Change umask Temporarily
# Save current umask
OLD_UMASK=$(umask)
echo "Old umask: $OLD_UMASK"

# Set restrictive umask (only owner access)
umask 0077

# Create files with new umask
touch restrictive-file.txt
mkdir restrictive-dir
ls -l restrictive-file.txt
ls -ld restrictive-dir
# Should be: rw------- and rwx------

# Set permissive umask (everyone access)
umask 0000

# Create files
touch permissive-file.txt
mkdir permissive-dir
ls -l permissive-file.txt
ls -ld permissive-dir
# Should be: rw-rw-rw- and rwxrwxrwx

# Restore original umask
umask $OLD_UMASK
echo "Restored umask: $(umask)"


## Task 4.5: umask in Scripts
# Create script with custom umask
cat > umask-script.sh << 'EOF'
#!/bin/bash

# Save original umask
ORIGINAL_UMASK=$(umask)

# Set restrictive umask for sensitive files
umask 0077

# Create sensitive file
touch sensitive-data.txt
echo "confidential" > sensitive-data.txt

# Restore original umask
umask $ORIGINAL_UMASK

# Create normal file
touch normal-file.txt

echo "Created files with different umasks"
ls -l sensitive-data.txt normal-file.txt
EOF

chmod +x umask-script.sh
./umask-script.sh
