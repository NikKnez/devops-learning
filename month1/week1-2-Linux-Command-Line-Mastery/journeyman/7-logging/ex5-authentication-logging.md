# Exercise 5: Authentication Logging


## Task 5.1: Understanding Auth Logs
cat > auth-logging.txt << 'EOF'
=== Authentication Logging ===

Purpose:
- Track login attempts (successful/failed)
- sudo command usage
- SSH connections
- User account changes
- Security auditing

Log Locations:
Ubuntu/Debian: /var/log/auth.log
RHEL/CentOS:   /var/log/secure

What's Logged:
- SSH login attempts
- sudo command execution
- su (switch user) usage
- Failed password attempts
- Account creation/deletion
- Group membership changes
- PAM authentication events

Why It Matters for DevOps:
1. Security: Detect intrusion attempts
2. Compliance: Who did what when
3. Troubleshooting: Why can't user X login?
4. Audit: Track privileged access

Common Patterns to Search:
"Failed password"     - Failed login attempts
"Accepted password"   - Successful logins
"sudo:"               - Sudo command usage
"session opened"      - User logged in
"session closed"      - User logged out
"authentication failure" - Auth failed
EOF

cat auth-logging.txt


## Task 5.2: Analyze Authentication Logs
# Check if auth.log exists (Ubuntu)
if [ -f /var/log/auth.log ]; then
    AUTH_LOG="/var/log/auth.log"
elif [ -f /var/log/secure ]; then
    AUTH_LOG="/var/log/secure"
else
    AUTH_LOG=""
fi

if [ -n "$AUTH_LOG" ]; then
    # View recent auth events
    echo "=== Recent Authentication Events ==="
    sudo tail -20 $AUTH_LOG
    
    # Failed login attempts
    echo ""
    echo "=== Failed Login Attempts ==="
    sudo grep "Failed password" $AUTH_LOG | tail -10
    
    # Successful logins
    echo ""
    echo "=== Successful Logins ==="
    sudo grep "Accepted password" $AUTH_LOG | tail -10
    
    # sudo usage
    echo ""
    echo "=== sudo Command Usage ==="
    sudo grep "sudo:" $AUTH_LOG | tail -10
    
    # Create auth analysis
    cat > auth-analysis.txt << EOF
=== Authentication Log Analysis ===

Log file: $AUTH_LOG
Log size: $(sudo du -h $AUTH_LOG | cut -f1)

Failed login attempts today:
$(sudo grep "$(date +%b' '%d)" $AUTH_LOG | grep -i "failed" | wc -l)

Successful logins today:
$(sudo grep "$(date +%b' '%d)" $AUTH_LOG | grep -i "accepted" | wc -l)

sudo commands today:
$(sudo grep "$(date +%b' '%d)" $AUTH_LOG | grep "sudo:" | wc -l)

Recent failed attempts (last 5):
$(sudo grep "Failed" $AUTH_LOG | tail -5)
EOF
    
    cat auth-analysis.txt
else
    echo "No authentication log found"
fi


## Task 5.3: Security Monitoring Script
# Create security monitoring script
cat > security-monitor.sh << 'EOF'
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
EOF

chmod +x security-monitor.sh
./security-monitor.sh
