#!/bin/bash
<<<<<<< HEAD
# Backup important files

BACKUP_DIR="/tmp/backup-$(date +%Y%m%d)"
mkdir -p $BACKUP_DIR

echo "Backing up to $BACKUP_DIR..."
cp -r ~/important-files $BACKUP_DIR/
echo "Backup complete!"
=======
# Automated backup script

TARGET="/var/backups"
DATE=$(date +%Y-%m-%d)

echo "Starting backup..."
tar -czf $TARGET/backup-$DATE.tar.gz ~/data/
echo "Backup saved to $TARGET/backup-$DATE.tar.gz"
>>>>>>> my/add-backup-script
