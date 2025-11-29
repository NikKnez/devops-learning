#!/bin/bash
DATE=$(date +%Y%m%d)
tar -czf backups/backup-$DATE.tar.gz /home/nikola/devops-learning
chmod 600 backups/backup-$DATE.tar.gz  # Secure the backup
