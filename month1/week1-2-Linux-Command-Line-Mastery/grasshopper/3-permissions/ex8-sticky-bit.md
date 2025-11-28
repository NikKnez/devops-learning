# Exercise 8: Sticky Bit


## Task 8.1: Understanding Sticky Bit
# View sticky bit on /tmp
ls -ld /tmp
# Output: drwxrwxrwt
# Note the 't' at the end - that's sticky bit

# What it means:
# - Everyone can create files in /tmp
# - Only file owner can delete their own files
# - Prevents users from deleting each other's files


## Task 8.2: Create Directory with Sticky Bit
# Create shared directory
mkdir sticky-test
ls -ld sticky-test

# Add sticky bit
chmod +t sticky-test
ls -ld sticky-test
# Shows: drwxr-xr-t (t at the end)

# Numeric method
chmod 1755 sticky-test
ls -ld sticky-test

# Make it writable by everyone (for testing)
chmod 1777 sticky-test
ls -ld sticky-test


## Task 8.3: Test Sticky Bit Behavior
# Create test directory
mkdir sticky-demo
chmod 1777 sticky-demo

# Create file as your user
touch sticky-demo/myfile.txt
ls -l sticky-demo/

# Try to simulate another user (you can't actually test this alone,
# but understand the concept):
# 
# User A creates: file1.txt
# User B creates: file2.txt
#
# Without sticky bit:
# - User B can delete file1.txt (if directory is writable)
#
# With sticky bit:
# - User B CANNOT delete file1.txt
# - User B can only delete file2.txt (their own file)


## Task 8.4: Sticky Bit Use Cases
# Document use cases
cat > sticky-bit-uses.txt << 'EOF'
=== Sticky Bit Use Cases ===

1. /tmp directory
   - Everyone can create temp files
   - Users can't delete each other's files
   - chmod 1777 /tmp

2. Shared upload directory
   - Users upload files
   - Only uploader can delete their files
   - chmod 1777 /uploads

3. Public directories with user content
   - Forums, wikis, shared workspaces
   - Protection against accidental/malicious deletion

Notation:
Symbolic: drwxrwxrwt (t at end)
Numeric: 1777 (1 = sticky bit)

Capital T vs lowercase t:
- t = sticky + execute permission
- T = sticky but NO execute (broken)
EOF

cat sticky-bit-uses.txt
