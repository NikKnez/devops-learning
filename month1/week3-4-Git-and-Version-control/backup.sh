#!/bin/bash
# Automated backup script

TARGET="/var/backups"
DATE=$(date +%Y-%m-%d)

echo "Starting backup..."
tar -czf $TARGET/backup-$DATE.tar.gz ~/data/
echo "Backup saved to $TARGET/backup-$DATE.tar.gz"
