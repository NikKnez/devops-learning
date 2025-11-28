# Exercise 1: Understanding File Permissions

## Task 1.1: Read Permission Notation
# Create test files
touch file1.txt
mkdir dir1
echo "test content" > file2.txt

# View permissions
ls -l

# Output explanation:
# -rw-rw-r-- 1 nikola nikola 0 Nov 21 10:00 file1.txt
# 
# Breakdown:
# - = regular file (d = directory, l = link)
# rw- = owner permissions (read, write, no execute)
# rw- = group permissions (read, write, no execute)
# r-- = others permissions (read only)


## Task 1.2: Understanding Permission Values
# Create reference chart
cat > permission-chart.txt << 'EOF'
=== Permission Values ===

Binary  Octal  Symbolic  Meaning
------  -----  --------  -------
000     0      ---       No permissions
001     1      --x       Execute only
010     2      -w-       Write only
011     3      -wx       Write + Execute
100     4      r--       Read only
101     5      r-x       Read + Execute
110     6      rw-       Read + Write
111     7      rwx       Read + Write + Execute

Common Permission Combinations:
644 = rw-r--r--  (files: owner read/write, others read)
755 = rwxr-xr-x  (executables: owner all, others read/execute)
700 = rwx------  (private: owner only)
777 = rwxrwxrwx  (dangerous: everyone can do everything)
EOF

cat permission-chart.txt


# Task 1.3: Analyze Current Permissions
# Check permissions on your files
ls -l /home/nikola

# Check permissions on system directories
ls -ld /tmp
ls -ld /var
ls -ld /etc

# Check your current user's file creation permissions
touch test-perm.txt
ls -l test-perm.txt
# Note the default permissions

# Your task: What are the default permissions?
# Write answer here:
echo "Default file permissions: " >> my-answers.txt
ls -l test-perm.txt >> my-answers.txt 
