# Exercise 9: Disk Usage Analysis


## Task 9.1: Disk Usage Commands
# Show disk space
df -h

# Show disk space for specific filesystem type
df -h -t ext4

# Show inodes usage (can run out even with space free!)
df -i

# Show disk usage of directory
du -sh /var/log

# Top 10 largest directories in /var
sudo du -h /var 2>/dev/null | sort -rh | head -10

# Find large files (>100MB)
sudo find / -type f -size +100M -exec ls -lh {} \; 2>/dev/null | head -10

# Disk usage by directory (current directory)
du -h --max-depth=1 | sort -rh

# Create disk usage report
cat > disk-usage-report.txt << EOF
=== Disk Usage Report ===

Filesystem usage:
$(df -h)

Inode usage:
$(df -i)

Largest directories in /:
$(sudo du -h --max-depth=1 / 2>/dev/null | sort -rh | head -10)

/var/log size:
$(sudo du -sh /var/log)
EOF

cat disk-usage-report.txt


## Task 9.2: Advanced Disk Analysis with ncdu
# Install ncdu if needed
sudo apt install -y ncdu

# Use ncdu to analyze disk usage (interactive)
cat > ncdu-guide.txt << 'EOF'
=== ncdu (NCurses Disk Usage) ===

Installation:
sudo apt install ncdu

Usage:
ncdu /var/log          # Analyze specific directory
ncdu /                 # Analyze entire system (takes time)

Navigation:
Up/Down arrows - Navigate
Right arrow - Enter directory
Left arrow - Go back
d - Delete file/directory
n - Sort by name
s - Sort by size
q - Quit

Why ncdu is better than du:
- Interactive navigation
- Visual representation
- Can delete files directly
- Faster for exploration

DevOps Use Cases:
1. Find what's filling disk
2. Quick cleanup decisions
3. Identify log bloat
4. Before/after comparison
EOF

cat ncdu-guide.txt

# Run ncdu on /var/log (if you have it installed)
# ncdu /var/log
