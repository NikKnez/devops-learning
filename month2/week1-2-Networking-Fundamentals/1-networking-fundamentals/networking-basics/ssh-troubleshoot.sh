#!/bin/bash
# SSH connection troubleshooting

HOST=$1
USER=${2:-$(whoami)}

if [ -z "$HOST" ]; then
    echo "Usage: $0 <host> [user]"
    exit 1
fi

echo "=========================================="
echo "SSH Troubleshooting: $USER@$HOST"
echo "=========================================="
echo ""

# Check DNS resolution
echo "1. DNS Resolution:"
if host $HOST > /dev/null 2>&1; then
    IP=$(host $HOST | grep "has address" | awk '{print $4}' | head -1)
    echo "   [OK] $HOST resolves to: $IP"
else
    echo "   [FAIL] Cannot resolve $HOST"
    exit 1
fi
echo ""

# Check basic connectivity
echo "2. ICMP Connectivity:"
if ping -c 2 -W 2 $HOST > /dev/null 2>&1; then
    echo "   [OK] Host is reachable"
else
    echo "   [WARN] ICMP blocked or host down"
fi
echo ""

# Check SSH port
echo "3. SSH Port (22):"
if nc -zv -w 3 $HOST 22 2>&1 | grep -q succeeded; then
    echo "   [OK] Port 22 is open"
else
    echo "   [FAIL] Port 22 is closed"
    echo "   Trying port 2222..."
    if nc -zv -w 3 $HOST 2222 2>&1 | grep -q succeeded; then
        echo "   [OK] Port 2222 is open (non-standard SSH port)"
        echo "   Use: ssh -p 2222 $USER@$HOST"
    fi
fi
echo ""

# Check SSH keys
echo "4. SSH Key Status:"
if [ -f ~/.ssh/id_ed25519 ]; then
    echo "   [OK] ed25519 key exists"
    ssh-keygen -l -f ~/.ssh/id_ed25519
elif [ -f ~/.ssh/id_rsa ]; then
    echo "   [OK] RSA key exists"
    ssh-keygen -l -f ~/.ssh/id_rsa
else
    echo "   [WARN] No SSH keys found"
    echo "   Generate with: ssh-keygen -t ed25519"
fi
echo ""

# Attempt verbose connection
echo "5. SSH Connection Test:"
echo "   Attempting verbose connection..."
ssh -v -o ConnectTimeout=5 -o StrictHostKeyChecking=no $USER@$HOST "echo 'Connection successful'" 2>&1 | grep -E "debug1:|Connection"
echo ""

echo "=========================================="
echo "Troubleshooting Tips:"
echo "=========================================="
echo ""
echo "If connection fails:"
echo "1. Verify credentials: ssh -v $USER@$HOST"
echo "2. Check public key on server: cat ~/.ssh/authorized_keys"
echo "3. Check server logs: sudo tail -f /var/log/auth.log"
echo "4. Check SSH config: cat /etc/ssh/sshd_config"
echo "5. Restart SSH service: sudo systemctl restart sshd"
echo ""
