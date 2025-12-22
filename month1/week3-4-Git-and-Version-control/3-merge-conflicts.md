# Merge Conflicts (Real DevOps Scenario)


# Create two conflicting branches
git checkout -b hotfix/update-readme
echo "## Quick Start Guide" >> README.md
echo "Run ./server-setup.sh to configure server" >> README.md
git add README.md
git commit -m "Add quick start guide"

git checkout main
git checkout -b feature/readme-improvement
echo "## Installation" >> README.md
echo "Follow these steps to install" >> README.md
git add README.md
git commit -m "Add installation section"

# Merge first branch
git checkout main
git merge hotfix/update-readme
# This works fine

# Try to merge second branch
git merge feature/readme-improvement
# CONFLICT! Both modified README.md

# Resolve conflict manually
vim README.md
# Or use VS Code if you prefer

# After resolving, mark as resolved
git add README.md
git commit -m "Merge feature/readme-improvement - resolved conflicts"

# Cleanup
git branch -d hotfix/update-readme
git branch -d feature/readme-improvement
git push origin main


## Practice exercise: Simulate team collaboration
# You'll practice with your study partner later
# For now, simulate it yourself

# Create "teammate's" branch
git checkout -b teammate/add-backup-script

cat > backup.sh << 'EOF'
#!/bin/bash
# Backup important files

BACKUP_DIR="/tmp/backup-$(date +%Y%m%d)"
mkdir -p $BACKUP_DIR

echo "Backing up to $BACKUP_DIR..."
cp -r ~/important-files $BACKUP_DIR/
echo "Backup complete!"
EOF

chmod +x backup.sh
git add backup.sh
git commit -m "Add backup script by teammate"

# Go back to your branch
git checkout main
git checkout -b my/add-backup-script

cat > backup.sh << 'EOF'
#!/bin/bash
# Automated backup script

TARGET="/var/backups"
DATE=$(date +%Y-%m-%d)

echo "Starting backup..."
tar -czf $TARGET/backup-$DATE.tar.gz ~/data/
echo "Backup saved to $TARGET/backup-$DATE.tar.gz"
EOF

chmod +x backup.sh
git add backup.sh
git commit -m "Add my version of backup script"

# Merge teammate's work first
git checkout main
git merge teammate/add-backup-script

# Try to merge yours
git merge my/add-backup-script
# CONFLICT!

# Resolve it (combine both approaches or choose one)
# After resolving:
git add backup.sh
git commit -m "Merge backup scripts - combined approaches"

git push origin main
