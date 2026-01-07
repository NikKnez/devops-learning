#!/bin/bash
# Week 1 Networking Review Exercises

echo "=========================================="
echo "Week 1 Networking Review"
echo "=========================================="
echo ""

# Exercise 1: Network Information
echo "EXERCISE 1: Gather Network Information"
echo "--------------------------------------"
echo ""
echo "Your IP addresses:"
ip addr show | grep "inet " | grep -v 127.0.0.1
echo ""
echo "Your default gateway:"
ip route | grep default
echo ""
echo "Your DNS servers:"
cat /etc/resolv.conf | grep nameserver
echo ""
read -p "Press Enter to continue..."
echo ""

# Exercise 2: DNS Testing
echo "EXERCISE 2: DNS Resolution"
echo "--------------------------------------"
echo ""
domains=("google.com" "github.com" "aws.amazon.com")
for domain in "${domains[@]}"; do
    echo "Resolving $domain:"
    dig $domain +short
    echo ""
done
read -p "Press Enter to continue..."
echo ""

# Exercise 3: Port Scanning
echo "EXERCISE 3: Check Open Ports"
echo "--------------------------------------"
echo ""
echo "Listening TCP ports on your system:"
ss -tuln | grep LISTEN | head -10
echo ""
read -p "Press Enter to continue..."
echo ""

# Exercise 4: Connectivity Test
echo "EXERCISE 4: Test Connectivity"
echo "--------------------------------------"
echo ""
targets=("8.8.8.8" "1.1.1.1" "google.com")
for target in "${targets[@]}"; do
    echo "Testing $target:"
    if ping -c 2 -W 2 $target > /dev/null 2>&1; then
        echo "  [OK] Reachable"
        ping -c 2 $target | tail -1
    else
        echo "  [FAIL] Not reachable"
    fi
    echo ""
done
read -p "Press Enter to continue..."
echo ""

# Exercise 5: HTTP Testing
echo "EXERCISE 5: HTTP Requests"
echo "--------------------------------------"
echo ""
echo "Testing HTTP status codes:"
test_urls=(
    "https://httpstat.us/200:200 OK"
    "https://httpstat.us/404:404 Not Found"
    "https://httpstat.us/500:500 Server Error"
)

for url_desc in "${test_urls[@]}"; do
    url="${url_desc%%:*}"
    desc="${url_desc##*:}"
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    time=$(curl -s -o /dev/null -w "%{time_total}" "$url")
    echo "  [$status] $desc (${time}s)"
done
echo ""
read -p "Press Enter to continue..."
echo ""

# Exercise 6: Traceroute
echo "EXERCISE 6: Network Path Analysis"
echo "--------------------------------------"
echo ""
echo "Tracing route to google.com:"
traceroute -m 10 google.com 2>/dev/null | head -11
echo ""
read -p "Press Enter to continue..."
echo ""

# Exercise 7: SSH Check
echo "EXERCISE 7: SSH Configuration"
echo "--------------------------------------"
echo ""
if [ -f ~/.ssh/id_ed25519 ]; then
    echo "  [OK] SSH ed25519 key exists"
    ssh-keygen -l -f ~/.ssh/id_ed25519
elif [ -f ~/.ssh/id_rsa ]; then
    echo "  [OK] SSH RSA key exists"
    ssh-keygen -l -f ~/.ssh/id_rsa
else
    echo "  [INFO] No SSH keys found"
    echo "  Generate with: ssh-keygen -t ed25519"
fi
echo ""
if [ -f ~/.ssh/config ]; then
    echo "  [OK] SSH config file exists"
    echo "  Configured hosts:"
    grep "^Host " ~/.ssh/config | grep -v "\*"
else
    echo "  [INFO] No SSH config file"
fi
echo ""
read -p "Press Enter to continue..."
echo ""

# Exercise 8: Firewall Status
echo "EXERCISE 8: Firewall Configuration"
echo "--------------------------------------"
echo ""
if command -v ufw &> /dev/null; then
    echo "UFW Firewall Status:"
    sudo ufw status | head -10
elif command -v firewall-cmd &> /dev/null; then
    echo "firewalld Status:"
    sudo firewall-cmd --state
    sudo firewall-cmd --list-all | head -10
else
    echo "  [INFO] No common firewall tool found"
fi
echo ""

echo "=========================================="
echo "Week 1 Review Complete!"
echo "=========================================="
echo ""
echo "Key Skills Mastered:"
echo "  - IP addressing and subnetting"
echo "  - DNS resolution and troubleshooting"
echo "  - Port identification and testing"
echo "  - HTTP requests and status codes"
echo "  - Network troubleshooting tools"
echo "  - SSH configuration and security"
echo "  - Load balancing concepts"
echo "  - Firewall and security group patterns"
echo ""
