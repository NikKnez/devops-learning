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
