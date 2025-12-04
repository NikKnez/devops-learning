#!/bin/bash

echo "=== System Package Maintenance ==="
echo ""

echo "[1/5] Updating package lists..."
sudo apt update

echo ""
echo "[2/5] Upgrading packages..."
sudo apt upgrade -y

echo ""
echo "[3/5] Removing orphaned packages..."
sudo apt autoremove -y

echo ""
echo "[4/5] Cleaning package cache..."
sudo apt clean

echo ""
echo "[5/5] Checking for broken dependencies..."
sudo apt-get check

echo ""
echo "=== Maintenance Complete ==="
echo "Disk space freed: $(df -h / | tail -1 | awk '{print $4}' )"

# Run this script:
# - Weekly for desktop/development systems
# - Before major software installations
# - After removing large packages
# - Monthly for servers
