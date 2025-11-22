#!/bin/bash

# Restore from backup script

BACKUP_DIR="/home/nikola/backups/deployments"
WEB_ROOT="/var/www/html"

# List available backups
echo "Available backups:"
ls -lh "$BACKUP_DIR"
echo ""

# Ask which backup to restore
read -p "Enter backup filename: " BACKUP_FILE

if [ ! -f "$BACKUP_DIR/$BACKUP_FILE" ]; then
	echo "Error: Backup file not found!"
	exit 1
fi

# Restore
echo "Restoring from $BACKUP_FILE..."
sudo rm -rf "$WEB_ROOT"/*
sudo tar -xzf "$BACKUP_DIR/$BACKUP_FILE" -C "$WEB_ROOT"
sudo chown -R www-data:www-data "$WEB_ROOT"
sudo chmod -R 755 "$WEB_ROOT"
sudo systemctl restart nginx

echo "Restore complete!"
