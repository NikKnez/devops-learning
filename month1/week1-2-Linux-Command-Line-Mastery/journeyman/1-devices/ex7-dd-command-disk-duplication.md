# Exercise 7: dd Command (Disk Duplication)


## Task 7.1: Understanding dd
cat > dd-explained.txt << 'EOF'
=== dd Command ===

What is dd?
- "Data Definition" or "Disk Duplicator"
- Low-level data copying
- Works with bytes/blocks
- Can copy disks, partitions, files
- Creates exact bit-for-bit copies

WARNING: dd is DANGEROUS!
- Can destroy data instantly
- No undo
- Wrong command = destroyed disk
- Always double-check syntax
- Nicknamed "Disk Destroyer"

Syntax:
dd if=INPUT_FILE of=OUTPUT_FILE [options]

Common options:
bs=SIZE     - Block size (1K, 1M, 1G)
count=N     - Copy only N blocks
skip=N      - Skip N blocks at start of input
seek=N      - Skip N blocks at start of output
conv=sync   - Pad blocks to block size
status=progress - Show progress

Common uses:
1. Backup disk: dd if=/dev/sda of=backup.img
2. Restore disk: dd if=backup.img of=/dev/sda
3. Create ISO: dd if=/dev/cdrom of=disk.iso
4. Wipe disk: dd if=/dev/zero of=/dev/sda
5. Create test file: dd if=/dev/zero of=testfile bs=1M count=100
6. USB bootable: dd if=linux.iso of=/dev/sdX

NEVER run dd on production systems without testing command first!
EOF

cat dd-explained.txt


## Task 7.2: Safe dd Practice (Files Only)
# Create test file with dd
dd if=/dev/zero of=zeros.dat bs=1M count=10
ls -lh zeros.dat

# Create file with random data
dd if=/dev/urandom of=random.dat bs=1M count=5
ls -lh random.dat

# Check the files
file zeros.dat
file random.dat

# Verify zeros file contains only zeros
od -An -tx1 zeros.dat | head -3

# Copy file with dd
dd if=zeros.dat of=zeros-copy.dat
ls -lh zeros*

# Copy with specific block size
dd if=zeros.dat of=zeros-copy2.dat bs=4K

# Show progress while copying
dd if=random.dat of=random-copy.dat bs=1M status=progress

# Copy only first 2MB
dd if=zeros.dat of=partial.dat bs=1M count=2
ls -lh partial.dat


## Task 7.3: dd Performance Testing
# Test write speed (BE CAREFUL - only use temp files)
dd if=/dev/zero of=write-test.dat bs=1M count=100 oflag=direct

# Test read speed
dd if=write-test.dat of=/dev/null bs=1M iflag=direct

# Compare different block sizes
echo "=== Testing dd Performance ===" > dd-performance.txt

echo "" >> dd-performance.txt
echo "Block size 1K:" >> dd-performance.txt
dd if=/dev/zero of=test-1k.dat bs=1K count=10000 2>&1 | grep -E "copied|MB" >> dd-performance.txt

echo "" >> dd-performance.txt
echo "Block size 1M:" >> dd-performance.txt
dd if=/dev/zero of=test-1m.dat bs=1M count=10 2>&1 | grep -E "copied|MB" >> dd-performance.txt

echo "" >> dd-performance.txt
echo "Block size 10M:" >> dd-performance.txt
dd if=/dev/zero of=test-10m.dat bs=10M count=1 2>&1 | grep -E "copied|MB" >> dd-performance.txt

cat dd-performance.txt

# Clean up test files
rm -f write-test.dat test-*.dat


## Task 7.4: Practical dd Use Cases (Documentation)
cat > dd-use-cases.txt << 'EOF'
=== Common dd Use Cases ===

1. Backup entire disk:
   dd if=/dev/sda of=/backup/disk.img bs=4M status=progress
   
2. Restore disk from backup:
   dd if=/backup/disk.img of=/dev/sda bs=4M status=progress

3. Clone disk to another disk:
   dd if=/dev/sda of=/dev/sdb bs=4M status=progress

4. Create ISO from CD/DVD:
   dd if=/dev/cdrom of=disc.iso bs=2048

5. Write ISO to USB (make bootable):
   dd if=ubuntu.iso of=/dev/sdX bs=4M status=progress

6. Securely wipe disk:
   dd if=/dev/zero of=/dev/sdX bs=4M status=progress
   # Or with random data:
   dd if=/dev/urandom of=/dev/sdX bs=4M status=progress

7. Create sparse file:
   dd if=/dev/zero of=sparse.img bs=1 count=0 seek=1G

8. Backup partition:
   dd if=/dev/sda1 of=partition-backup.img bs=4M

9. Create swap file:
   dd if=/dev/zero of=/swapfile bs=1M count=2048

10. Test disk speed:
    dd if=/dev/zero of=testfile bs=1G count=1 oflag=direct

CRITICAL SAFETY RULES:
- ALWAYS verify if= and of= before pressing Enter
- One typo can destroy your data
- Test on non-critical systems first
- Keep backups
- if=/dev/sda of=/dev/sdb is VERY different from of=/dev/sda if=/dev/sdb
EOF

cat dd-use-cases.txt


## Task 7.5: dd vs Other Tools
cat > dd-alternatives.txt << 'EOF'
=== dd vs Alternative Tools ===

When to use dd:
✓ Low-level disk operations
✓ Exact bit-for-bit copies
✓ Working with raw devices
✓ Creating disk images
✓ Forensics work

When NOT to use dd (use alternatives):

Instead of dd for file backup → rsync, cp, tar
- Faster
- Progress indicators
- Preserve metadata better

Instead of dd for disk cloning → clonezilla, partclone
- Understands filesystems
- Only copies used space
- Faster for large disks

Instead of dd for USB creation → balenaEtcher, Rufus
- User-friendly
- Harder to make mistakes
- Verification built-in

Instead of dd for secure wiping → shred, wipe, hdparm
- Multiple passes
- Forensically secure
- DOD-compliant patterns

dd advantages:
+ Universally available
+ Simple and reliable
+ Scriptable
+ Fast for sequential operations

dd disadvantages:
- No progress by default (use status=progress)
- Dangerous if misused
- Copies empty space too
- No error recovery
EOF

cat dd-alternatives.txt
