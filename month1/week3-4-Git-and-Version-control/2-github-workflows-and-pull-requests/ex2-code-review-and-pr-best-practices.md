# Code Review & PR Best Practices

# Create ANOTHER feature branch (simulating teammate's work)
git checkout main
git checkout -b feature/add-log-rotation

cat > scripts/rotate-logs.sh << 'EOF'
#!/bin/bash
# Rotate application logs

LOG_DIR="/var/log/myapp"
ARCHIVE_DIR="/var/log/myapp/archive"
DAYS_TO_KEEP=30

# Create archive directory if it doesn't exist
mkdir -p $ARCHIVE_DIR

# Find and compress logs older than 1 day
find $LOG_DIR -maxdepth 1 -name "*.log" -mtime +1 -exec gzip {} \;

# Move compressed logs to archive
find $LOG_DIR -maxdepth 1 -name "*.log.gz" -exec mv {} $ARCHIVE_DIR/ \;

# Delete archived logs older than retention period
find $ARCHIVE_DIR -name "*.log.gz" -mtime +$DAYS_TO_KEEP -delete

echo "Log rotation complete"
EOF

chmod +x scripts/rotate-logs.sh

git add scripts/rotate-logs.sh
git commit -m "feat(logs): add log rotation script

- Compresses logs older than 1 day
- Archives compressed logs
- Deletes old archives after 30 days"

# Push and create PR
git push origin feature/add-log-rotation
```

**On GitHub:**
1. Create PR for `feature/add-log-rotation`
2. Write description
3. **Now practice review on your first PR**

**Go to first PR (`feature/add-backup-monitoring`):**
1. Click "Files changed" tab
2. Hover over line of code, click "+" to add comment
3. Add review comments:
```
Line 6: Consider making MAX_AGE_HOURS configurable via environment variable

Example:
MAX_AGE_HOURS=${BACKUP_MAX_AGE:-24}
```
```
Line 9: Good error handling. Consider adding timestamp to error message for debugging.

- Click "Review changes" → "Comment" → "Submit review"
- Go back to conversation tab
- Click "Merge pull request" → "Confirm merge"
- Delete branch (GitHub offers this option)


## Update local repo:
# Sync with remote
git checkout main
git pull origin main

# Delete local feature branch
git branch -d feature/add-backup-monitoring

# Verify
git branch -a
git log --oneline --graph


## Address review feedback (create follow-up PR):
git checkout -b improvement/configurable-backup-age

# Improve the script based on "review"
cat > scripts/backup-monitor.sh << 'EOF'
#!/bin/bash
# Monitor backup status with configurable age threshold

BACKUP_DIR="/var/backups"
MAX_AGE_HOURS=${BACKUP_MAX_AGE:-24}

latest_backup=$(find $BACKUP_DIR -type f -name "*.tar.gz" -mtime -1 | head -1)

if [ -z "$latest_backup" ]; then
    timestamp=$(date '+%Y-%m-%d %H:%M:%S')
    echo "[$timestamp] ⚠️  WARNING: No backup found in last $MAX_AGE_HOURS hours"
    exit 1
else
    echo "✓ Backup is current: $latest_backup"
    exit 0
fi
EOF

git add scripts/backup-monitor.sh
git commit -m "improvement(backup-monitor): make age threshold configurable

- MAX_AGE_HOURS now configurable via environment variable
- Added timestamp to error messages
- Defaults to 24 hours if not set

Addresses review feedback from PR #1"

git push origin improvement/configurable-backup-age

- Create PR, review it yourself, then merge.
