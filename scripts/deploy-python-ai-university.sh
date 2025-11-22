#!/bin/bash

# Automated Deployment Script for Python_AI_University
# Author: Nikola Knezevic
# Date: 2025-11-22
# Description: Clones and Deploys static website to nginx

set -e # Exit one any error

# Variables
REPO_URL="https://github.com/NikKnez/Python_AI_University.git"
PROJECT_NAME="Python_AI_University"
TEMP_DIR="/tmp/$PROJECT_NAME"
WEB_ROOT="/var/www/html"
BACKUP_DIR="/home/nikola/backups/deployments"

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "========================================="
echo "Python_AI_University Deployment Script"
echo "========================================="
echo ""

# Step 1: Create backup of current state
echo -e "${YELLOW}[1/6] Creating backup f current site...${NC}"
BACKUP_FILE="backup-$(date +%Y%m%d-%H%M%S).tar.gz"
sudo tar -czf "$BACKUP_DIR/$BACKUP_FILE" -C "$WEB_ROOT" . 2>/dev/null || true
echo -e "${GREEN}Backup created: $BACKUP_FILE${NC}"
echo ""

# Step 2: Clean temp directory
echo -e "${YELLOW}[2/6] Cleaning temporary directory...${NC}"
if [ -d "$TEMP_DIR" ]; then
	rm -rf "$TEMP_DIR"
fi
echo -e "${GREEN}Temp directory cleaned${NC}"
echo ""

# Step 3: Clone repository
echo -e "${YELLOW}[3/6] Cloning repository...$[NC]"
git clone "$REPO_URL" "$TEMP_DIR"
if [ $? -eq 0 ]; then
	echo -e "${GREEN}Repository cloned successfully${NC}"
else
	echo -e "$[RED]Failed to clone repository${NC}"
	exit 1
fi
echo ""

# Step 4: Clear web root (except backup)
echo -e "${YELLOW}[4/6] Clearing web root...${NC}"
sudo rm -rf "WEB_ROOT"/*
echo -e "${GREEN}Web root cleared${NC}"
echo ""

# Step 5: Copy files to web root
echo -e "${YELLOW}[5/6] Copying files to web root...${NC}"
sudo cp -r "$TEMP_DIR"/* "$WEB_ROOT"/
echo -e "${GREEN}Files copied${NC}"
echo ""

# Step 6: Set permissions
echo -e "${YELLOW}[6/6] Setting permissions...${NC}"
sudo chown -R www-data:www-data "$WEB_ROOT"
sudo chmod -R 755 "$WEB_ROOT"
echo -e "${GREEN}Permissions set${NC}"

# Step 7: Restart nginx
echo -e "${YELLOW}Restarting nginx...${NC}"
sudo systemctl restart nginx
if [ $? -eq 0 ]; then
	echo -e "${GREEN}Nginx restarted successfully${NC}"
else
	echo -e "${RED}Failed to restart nginx${NC}"
	exit 1
fi
echo ""

# Step 8: Cleanup
echo -e "${YELLOW}Cleaning up temporary files${NC}"
rm -rf "$TEMP_DIR"
echo -e "${GREEN}Cleanup complete${NC}"
echo ""

# Success message
echo "========================================"
echo -e "${GREEN}DEPLOYMENT SUCCESSFUL!${NC}"
echo "========================================"
echo "Site deployed to: http://localhost"
echo "Backup saved to: $BACKUP_DIR/$BACKUP_FILE"
echo ""

# Show deployed files
echo "Deployed files:"
ls -lh "$WEB_ROOT"



