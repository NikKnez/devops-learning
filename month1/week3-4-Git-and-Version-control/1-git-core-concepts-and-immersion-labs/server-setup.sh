#!/bin/bash
# Server setup automation script

echo "Installing nginx..."
sudo apt update
sudo apt install -y nginx

echo "Startting nginx..."
sudo systemctl start nginx
sudo systemctl enable nginx

echi "Server setup complete!"
# Usage: ./server-setup.sh
