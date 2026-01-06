#!/bin/bash
# Firewall configuration practice

echo "=========================================="
echo "Firewall Configuration Demo"
echo "=========================================="
echo ""

# Check which firewall is available
if command -v ufw &> /dev/null; then
    FIREWALL="ufw"
    echo "Detected: UFW (Uncomplicated Firewall)"
elif command -v firewall-cmd &> /dev/null; then
    FIREWALL="firewalld"
    echo "Detected: firewalld"
elif command -v iptables &> /dev/null; then
    FIREWALL="iptables"
    echo "Detected: iptables"
else
    echo "No common firewall found"
    exit 1
fi
echo ""

# Show current status
echo "Current Firewall Status:"
case $FIREWALL in
    ufw)
        sudo ufw status verbose
        ;;
    firewalld)
        sudo firewall-cmd --list-all
        ;;
    iptables)
        sudo iptables -L -n -v
        ;;
esac
echo ""

# Show common operations
echo "Common Firewall Operations:"
echo ""

case $FIREWALL in
    ufw)
        echo "UFW Commands:"
        echo "  Enable:  sudo ufw enable"
        echo "  Disable: sudo ufw disable"
        echo "  Status:  sudo ufw status"
        echo ""
        echo "  Allow SSH:   sudo ufw allow 22/tcp"
        echo "  Allow HTTP:  sudo ufw allow 80/tcp"
        echo "  Allow HTTPS: sudo ufw allow 443/tcp"
        echo ""
        echo "  From IP:     sudo ufw allow from 192.168.1.100"
        echo "  To port:     sudo ufw allow from 10.0.0.0/8 to any port 22"
        echo ""
        echo "  Delete:      sudo ufw delete allow 80/tcp"
        echo "  Reset:       sudo ufw reset"
        ;;
    firewalld)
        echo "firewalld Commands:"
        echo "  Status:  sudo firewall-cmd --state"
        echo "  List:    sudo firewall-cmd --list-all"
        echo ""
        echo "  Add HTTP:    sudo firewall-cmd --add-service=http --permanent"
        echo "  Add port:    sudo firewall-cmd --add-port=8080/tcp --permanent"
        echo "  Reload:      sudo firewall-cmd --reload"
        ;;
    iptables)
        echo "iptables Commands:"
        echo "  List:    sudo iptables -L -n -v"
        echo "  Allow:   sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT"
        echo "  Save:    sudo iptables-save > /etc/iptables/rules.v4"
        ;;
esac

echo ""
echo "=========================================="
