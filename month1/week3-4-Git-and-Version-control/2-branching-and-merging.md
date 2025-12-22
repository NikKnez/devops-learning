# Branching and Merging


## Branching
# Create feature branch
git branch feature/add-server-script
git checkout feature/add-server-script
# Or shortcut: git checkout -b feature/add-server-script

# Create new file
cat > server-setup.sh << 'EOF'
#!/bin/bash
# Server setup automation script

echo "Installing nginx..."
sudo apt update
sudo apt install -y nginx

echo "Starting nginx..."
sudo systemctl start nginx
sudo systemctl enable nginx

echo "Server setup complete!"
EOF

chmod +x server-setup.sh
git add server-setup.sh
git commit -m "Add server setup script"

# Make more changes
echo "# Usage: ./server-setup.sh" >> server-setup.sh
git add server-setup.sh
git commit -m "Add usage instructions to server script"

# Switch back to main
git checkout main

# Merge feature branch
git merge feature/add-server-script

# View graph
git log --oneline --graph --all

# Delete feature branch (cleanup)
git branch -d feature/add-server-script

# Push to GitHub
git push origin main


## Practice: Simulate DevOps workflow
# Scenario: Add monitoring script on separate branch

git checkout -b feature/monitoring

cat > check-disk-space.sh << 'EOF'
#!/bin/bash
# Check disk space and alert if low

THRESHOLD=80
USAGE=$(df / | tail -1 | awk '{print $5}' | sed 's/%//')

if [ "$USAGE" -gt "$THRESHOLD" ]; then
    echo "WARNING: Disk usage is ${USAGE}%"
    exit 1
else
    echo "Disk usage OK: ${USAGE}%"
    exit 0
fi
EOF

chmod +x check-disk-space.sh
git add check-disk-space.sh
git commit -m "Add disk space monitoring script"

# Update README
echo "- check-disk-space.sh: Monitor disk usage" >> README.md
git add README.md
git commit -m "Update README with monitoring script"

# Merge to main
git checkout main
git merge feature/monitoring
git branch -d feature/monitoring
git push origin main
