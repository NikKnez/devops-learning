# Exercise 8: Creating a Custom Systemd Service


## Task 8.1: Build Simple Service
# Create a simple application
cat > /tmp/my-app.sh << 'EOF'
#!/bin/bash
while true; do
    echo "[$(date)] My App is running..." >> /tmp/my-app.log
    sleep 10
done
EOF

chmod +x /tmp/my-app.sh

# Create systemd service file
sudo bash -c 'cat > /etc/systemd/system/my-app.service' << 'EOF'
[Unit]
Description=My Custom Application
After=network.target

[Service]
Type=simple
User=nikola
ExecStart=/tmp/my-app.sh
Restart=on-failure
RestartSec=5s

[Install]
WantedBy=multi-user.target
EOF

# Reload systemd
sudo systemctl daemon-reload

# Start service
sudo systemctl start my-app

# Check status
systemctl status my-app

# Check logs
journalctl -u my-app -n 20

# Enable at boot
sudo systemctl enable my-app

# Check if file is being written
tail /tmp/my-app.log

# Stop and disable
sudo systemctl stop my-app
sudo systemctl disable my-app

# Remove service file
sudo rm /etc/systemd/system/my-app.service
sudo systemctl daemon-reload
rm /tmp/my-app.sh /tmp/my-app.log

echo "Custom service exercise completed!"
