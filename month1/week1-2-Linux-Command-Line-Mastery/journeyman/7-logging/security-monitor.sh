#!/bin/bash

# Detect auth log location
if [ -f /var/log/auth.log ]; then
    AUTH_LOG="/var/log/auth.log"
elif [ -f /var/log/secure ]; then
    AUTH_LOG="/var/log/secure"
else
    echo "No auth log found"
    exit 1
fi

echo "=== Security Monitoring Report ==="
echo "Generated: $(date)"
echo "Log: $AUTH_LOG"
echo ""

# Failed login attempts
echo "Failed Login Attempts (Last 24h):"
sudo grep "$(date +%b' '%d)" $AUTH_LOG 2>/dev/null | grep -i "failed" | wc -l

# Failed attempts by IP (if SSH)
echo ""
echo "Top Failed SSH Attempts by IP:"
sudo grep "Failed password" $AUTH_LOG 2>/dev/null | \
    grep -oP "from \K[0-9.]+" | sort | uniq -c | sort -rn | head -5

# Successful root logins
echo ""
echo "Root Login Attempts:"
sudo grep "root" $AUTH_LOG 2>/dev/null | grep -i "session opened" | wc -l

# New user sessions
echo ""
echo "User Sessions Today:"
sudo grep "$(date +%b' '%d)" $AUTH_LOG 2>/dev/null | grep "session opened" | \
    awk '{print $9}' | sort | uniq -c

# sudo usage by user
echo ""
echo "sudo Usage Today:"
sudo grep "$(date +%b' '%d)" $AUTH_LOG 2>/dev/null | grep "sudo:" | \
    grep "COMMAND" | awk '{print $5}' | sort | uniq -c

echo ""
echo "=== End Report ==="
