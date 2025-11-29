# Exercise 10: Real-World Permission Scenarios


## Scenario 1: Web Server Directory
# Setup web directory structure
mkdir -p webserver/{public,private,logs}

# Public files (HTML, CSS, JS) - readable by webserver
touch webserver/public/index.html
chmod 644 webserver/public/index.html

# Private scripts - only owner can read/write
touch webserver/private/config.php
chmod 600 webserver/private/config.php

# Logs directory - writable by webserver
chmod 755 webserver/logs

# Document the setup
ls -lR webserver/


## Scenario 2: Backup Directory
# Create backup directory
mkdir backups
chmod 700 backups  # Only owner can access

# Create backup script
cat > backup-script.sh << 'EOF'
#!/bin/bash
DATE=$(date +%Y%m%d)
tar -czf backups/backup-$DATE.tar.gz /home/nikola/devops-learning
chmod 600 backups/backup-$DATE.tar.gz  # Secure the backup
EOF

chmod 700 backup-script.sh  # Only owner can execute


## Scenario 3: Shared Team Directory
# Create team project directory
mkdir team-workspace
chmod 2775 team-workspace  # setgid + group write
chmod g+s team-workspace   # Ensure setgid

# Files created inside inherit group
cd team-workspace
touch project-file.txt
ls -l project-file.txt
