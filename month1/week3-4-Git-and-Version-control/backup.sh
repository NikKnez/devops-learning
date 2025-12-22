#!/bin/bash
# Backup important files

BACKUP_DIR="/tmp/backup-$(date +%Y%m%d)"
mkdir -p $BACKUP_DIR

echo "Backing up to $BACKUP_DIR..."
cp -r ~/important-files $BACKUP_DIR/
echo "Backup complete!"
