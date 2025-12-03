# Exercise 3: Working with Compressed Archives (tar)


## Task 3.1: Understanding tar Archives
cat > tar-explained.txt << 'EOF'
=== tar (Tape Archive) ===

Common tar operations:

CREATE:
tar -czf archive.tar.gz directory/    # Create compressed
tar -cf archive.tar directory/        # Create uncompressed

EXTRACT:
tar -xzf archive.tar.gz               # Extract compressed
tar -xf archive.tar                   # Extract uncompressed

LIST:
tar -tzf archive.tar.gz               # List contents (compressed)
tar -tf archive.tar                   # List contents (uncompressed)

Common flags:
-c = Create archive
-x = Extract archive
-t = List contents
-f = File (must be followed by filename)
-z = gzip compression (.tar.gz or .tgz)
-j = bzip2 compression (.tar.bz2)
-v = Verbose (show progress)
-C = Extract to specific directory

File extensions:
.tar = Uncompressed archive
.tar.gz or .tgz = gzip compressed
.tar.bz2 = bzip2 compressed (better compression, slower)
.tar.xz = xz compressed (best compression, slowest)
EOF

cat tar-explained.txt


## Task 3.2: Creating tar Archives
# Create test directory structure
mkdir -p test-archive/dir1/subdir
mkdir -p test-archive/dir2
echo "File 1 content" > test-archive/file1.txt
echo "File 2 content" > test-archive/dir1/file2.txt
echo "File 3 content" > test-archive/dir1/subdir/file3.txt

# Create uncompressed tar
tar -cf test-uncompressed.tar test-archive/
ls -lh test-uncompressed.tar

# Create gzip compressed tar
tar -czf test-compressed.tar.gz test-archive/
ls -lh test-compressed.tar.gz

# Create with verbose output
tar -czvf test-verbose.tar.gz test-archive/

# Compare sizes
ls -lh test-*.tar*

# Create size comparison
du -sh test-archive/
ls -lh test-uncompressed.tar
ls -lh test-compressed.tar.gz

echo "Original directory: $(du -sh test-archive/ | cut -f1)"
echo "Uncompressed tar: $(ls -lh test-uncompressed.tar | awk '{print $5}')"
echo "Compressed tar: $(ls -lh test-compressed.tar.gz | awk '{print $5}')"


## Task 3.3: Extracting tar Archives
# List contents without extracting
tar -tzf test-compressed.tar.gz

# Extract to current directory
mkdir extract-test1
cd extract-test1
tar -xzf ../test-compressed.tar.gz
ls -la
cd ..

# Extract to specific directory
mkdir extract-test2
tar -xzf test-compressed.tar.gz -C extract-test2/
ls -la extract-test2/

# Extract specific file only
mkdir extract-test3
tar -xzf test-compressed.tar.gz -C extract-test3/ test-archive/file1.txt
ls -lR extract-test3/

# Extract with verbose output
tar -xzvf test-compressed.tar.gz -C /tmp/


## Task 3.4: Advanced tar Usage
# Create archive excluding certain files
tar -czf archive-exclude.tar.gz --exclude='*.log' --exclude='*.tmp' test-archive/

# Create archive with different compression
tar -cjf test-bzip2.tar.bz2 test-archive/  # bzip2
tar -cJf test-xz.tar.xz test-archive/      # xz

# Compare compression ratios
ls -lh test-compressed.tar.gz test-bzip2.tar.bz2 test-xz.tar.xz

# Add files to existing tar (uncompressed only)
echo "new file" > newfile.txt
tar -rf test-uncompressed.tar newfile.txt
tar -tf test-uncompressed.tar | grep newfile

# Pipe tar over network (demonstration of concept)
cat > tar-over-network.txt << 'EOF'
=== Transfer tar over SSH ===

# Create and send:
tar -czf - /path/to/dir | ssh user@remote "cat > backup.tar.gz"

# Receive and extract:
ssh user@remote "cat backup.tar.gz" | tar -xzf -

# Direct extraction on remote:
tar -czf - /path/to/dir | ssh user@remote "tar -xzf - -C /destination/"
EOF

cat tar-over-network.txt
