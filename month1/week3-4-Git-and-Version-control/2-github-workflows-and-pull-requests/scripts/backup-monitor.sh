#!/bin/bash
# Monitor backup status

BACKUP_DIR="/var/backups"
MAX_AGE_HOURS=24

latest_backup=$(find $BACKUP_DIR -type f -name "*.tar.gz" -mtime -1 | head -1)

if [ -z "$latest_backup" ]; then
    echo "⚠️  WARNING: No backup found in last $MAX_AGE_HOURS hours"
    exit 1
else
    echo "✓ Backup is current: $latest_backup"
    exit 0
fi
