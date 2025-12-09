# Exercise 12: Symbolic Links (Symlinks)


## Task 12.1: Understanding Links
cat > links-guide.txt << 'EOF'
=== Hard Links vs Symbolic Links ===

HARD LINK:
- Additional name for existing file
- Points to same inode
- Same data, multiple names
- Cannot cross filesystems
- Cannot link to directories
- Deleting original doesn't break link

Create: ln original.txt hardlink.txt

SYMBOLIC LINK (Symlink):
- Pointer to another file/directory
- Has its own inode
- Points to path, not data
- Can cross filesystems
- Can link to directories
- Breaks if original is deleted

Create: ln -s original.txt symlink.txt

Key Differences:

Property          Hard Link        Symbolic Link
---------         ---------        -------------
Inode             Same             Different
Cross filesystem  No               Yes
Link to directory No               Yes
Survives deletion Yes              No (broken link)
File type         Regular file     Link file

When to Use Hard Links:
- Backup without duplicating data
- Multiple names for same file
- Within same filesystem

When to Use Symlinks:
- Shortcuts to files/directories
- Cross-filesystem references
- Dynamic paths (config files)
- Directory links

Common Symlink Uses in DevOps:
/usr/bin/python → /usr/bin/python3
/etc/nginx/sites-enabled → /etc/nginx/sites-available/mysite
/var/www/current → /var/www/releases/v1.2.3
EOF

cat links-guide.txt


## Task 12.2: Practice with Links
# Create test directory
mkdir link-practice
cd link-practice

# Create original file
echo "Original content" > original.txt

# Create hard link
ln original.txt hardlink.txt

# Create symbolic link
ln -s original.txt symlink.txt

# List with details
ls -li

# Notice:
# - hardlink.txt has SAME inode as original.txt
# - symlink.txt has DIFFERENT inode and shows -> arrow

# Show file contents
echo "=== Original ===" && cat original.txt
echo "=== Hard Link ===" && cat hardlink.txt
echo "=== Sym Link ===" && cat symlink.txt

# Modify via hard link
echo "Modified via hardlink" >> hardlink.txt

# Check original (also modified!)
cat original.txt

# Check link counts
stat original.txt | grep Links

# Delete original
rm original.txt

# Hard link still works
cat hardlink.txt

# Symlink is broken
cat symlink.txt 2>&1
# Shows error: No such file or directory

# List shows broken symlink in red (if colors enabled)
ls -l

# Cleanup
cd ..
rm -rf link-practice


## Task 12.3: Practical Symlink Scenarios
# Scenario 1: Version management
mkdir -p app-deploy
cd app-deploy

# Create version directories
mkdir v1.0 v1.1 v1.2
echo "Version 1.0" > v1.0/index.html
echo "Version 1.1" > v1.1/index.html
echo "Version 1.2" > v1.2/index.html

# Create 'current' symlink
ln -s v1.2 current

# Application reads from 'current'
ls -l
cat current/index.html

# Roll back to v1.1 (zero downtime!)
rm current
ln -s v1.1 current
cat current/index.html

cd ..

# Scenario 2: Config file management
mkdir config-example
cd config-example

# Different environments
echo "DB=localhost" > config.dev
echo "DB=prod-server" > config.prod

# Symlink to active config
ln -s config.dev config

# Application reads 'config'
cat config

# Switch to production
rm config
ln -s config.prod config
cat config

cd ..

# Document symlink patterns
cat > symlink-patterns.txt << 'EOF'
=== Common Symlink Patterns in DevOps ===

1. Application Versioning:
   /var/www/current → /var/www/releases/20231201-v1.2.3
   
   Benefits:
   - Zero-downtime deploys
   - Easy rollback
   - Just change symlink

2. Config Management:
   /etc/app/config → /etc/app/config.production
   
   Benefits:
   - Switch environments quickly
   - Keep all configs in version control
   - Single source of truth

3. Log Rotation:
   /var/log/app/current.log → /var/log/app/2023-12-01.log
   
   Benefits:
   - Application always writes to same path
   - Easy to rotate logs
   - Archive old logs

4. Tool Versions:
   /usr/local/bin/node → /usr/local/node-v18/bin/node
   
   Benefits:
   - Multiple versions installed
   - Switch versions easily
   - No path changes

5. Shared Resources:
   ~/projects/lib → /shared/company-lib
   
   Benefits:
   - Share code across projects
   - Central updates
   - Save disk space
EOF

cat symlink-patterns.txt

# Cleanup
rm -rf app-deploy config-example
