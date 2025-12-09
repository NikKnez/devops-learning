# Exercise 11: Inodes


## Task 11.1: Understanding Inodes
cat > inodes-guide.txt << 'EOF'
=== Linux Inodes Explained ===

What is an Inode?
- Index Node
- Data structure storing file metadata
- One inode per file/directory
- Stores everything EXCEPT filename and data

Inode Contains:
- File size
- Owner (UID/GID)
- Permissions
- Timestamps (created, modified, accessed)
- Number of hard links
- Block pointers (where data is stored)
- File type (regular, directory, symlink)

What Inode Does NOT Contain:
- Filename (stored in directory)
- File data (stored in data blocks)

Why Inodes Matter:
- Can run out of inodes even with free space
- Each file needs an inode
- Lots of small files = inode exhaustion
- Shows as "No space left on device" even with free space

Inode Number:
- Unique within filesystem
- Used internally by filesystem
- mv within same filesystem = just change directory entry
- mv across filesystems = copy data + create new inode

Common Commands:
ls -i file.txt       # Show inode number
df -i                # Show inode usage
stat file.txt        # Detailed inode info
find / -inum 12345   # Find file by inode number
EOF

cat inodes-guide.txt


## Task 11.2: Explore Inodes
# Create test files
mkdir inode-test
cd inode-test

# Create files
echo "File 1" > file1.txt
echo "File 2" > file2.txt
mkdir subdir

# Show inode numbers
ls -li

# Detailed inode information
stat file1.txt

# Show your inode numbers
MY_INODE=$(ls -i file1.txt | awk '{print $1}')
echo "file1.txt inode: $MY_INODE"

# Find all files with specific inode (should be just one normally)
find . -inum $MY_INODE

# Check inode usage on filesystem
df -i

# Create inode analysis
cat > ../inode-analysis.txt << EOF
=== Inode Analysis ===

Files in inode-test:
$(ls -li)

Detailed info for file1.txt:
$(stat file1.txt)

System inode usage:
$(df -i)

Inodes used in /:
$(df -i / | tail -1 | awk '{print $3 " used out of " $2 " (" $5 " used)"}')
EOF

cd ..
cat inode-analysis.txt
rm -rf inode-test


## Task 11.3: Inode Exhaustion Scenario
# Demonstrate inode exhaustion concept
cat > inode-exhaustion.sh << 'EOF'
#!/bin/bash

echo "=== Inode Exhaustion Demonstration ==="
echo ""
echo "Scenario: Creating many small files"
echo ""

# Create temp directory
mkdir -p /tmp/inode-test
cd /tmp/inode-test

echo "Creating 1000 empty files..."
for i in {1..1000}; do
    touch "file_$i.txt"
done

# Check inodes used
echo ""
echo "Files created: $(ls | wc -l)"
echo "Disk space used: $(du -sh . | cut -f1)"
echo "Inodes used: $(ls -1 | wc -l) inodes"

echo ""
echo "This demonstrates:"
echo "- Many small files use many inodes"
echo "- Minimal disk space used"
echo "- If inodes run out, can't create files even with free space"

# Cleanup
cd /
rm -rf /tmp/inode-test

echo ""
echo "Cleaned up demonstration files"
EOF

chmod +x inode-exhaustion.sh
./inode-exhaustion.sh
