#!/bin/bash

# Backup script for devops-learning directory
# Author: Nikola Knezevic
# Date: 2024-11-18

# Variables
SOURCE_DIR="/home/nikola/devops-learning"
BACKUP_DIR="/home/nikola/backups"
DATE=$(date +%Y-%m-%d-%H%M%S)
BACKUP_FILE="devops-backup-$DATE.tar.gz"
LOG_FILE="/home/nikola/backup.log"
echo "$(date): Backup started" >> "$LOG_FILE"
# Create backup directory if doesn't exist
mkdir -p "$BACKUP_DIR"

# Create the backup
echo "Starting backup..."
echo "Source: $SOURCE_DIR"
echo "Destination: $BACKUP_DIR/$BACKUP_FILE"

# Check if backup was successful
if [ $? -eq 0 ]; then
	echo "Backup completed successfully!"
	echo "Backup file: $BACKUP_FILE"
	echo "Size: $(du -h $BACKUP_DIR/$BACKUP_FILE | cut -f1)"
else
	echo "Backup failed!"
	exit 1
fi

# List all backups
echo ""
echo "All backups:"
ls -lh "$BACKUP_DIR"

echo "$(date): Backup completed" >> "$LOG_FILE"
