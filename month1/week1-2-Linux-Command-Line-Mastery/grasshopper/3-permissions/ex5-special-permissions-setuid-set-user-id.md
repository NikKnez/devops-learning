# Exercise 5: Special Permissions - setuid (Set User ID)


## Task 5.1: Understanding setuid
# View setuid in action on system
ls -l /usr/bin/passwd

# Output shows 's' in owner execute position:
# -rwsr-xr-x ... /usr/bin/passwd
# This is setuid - runs as owner (root), not as you

# Find other setuid programs
find /usr/bin -perm -4000 -ls 2>/dev/null | head -10


## Task 5.2: Create setuid File (Demonstration)
# Create test script
cat > setuid-test.sh << 'EOF'
#!/bin/bash
echo "Running as user: $(whoami)"
echo "Real UID: $(id -u)"
echo "Effective UID: $(id -u)"
EOF

chmod +x setuid-test.sh

# Run normally
./setuid-test.sh

# Add setuid bit
chmod u+s setuid-test.sh
ls -l setuid-test.sh
# Shows: -rwsr-xr-x (note the 's' instead of 'x')

# Numeric method: add 4000
chmod 4755 setuid-test.sh
ls -l setuid-test.sh


## Task 5.3: setuid Security Implications
# Create security notes
cat > setuid-security.txt << 'EOF'
=== setuid Security ===

What it does:
- File executes with permissions of FILE OWNER, not user who runs it
- Example: /usr/bin/passwd owned by root, runs as root

Why it's dangerous:
- If misconfigured, users could run commands as root
- Security vulnerabilities in setuid programs are critical
- Never create setuid scripts in production

Notation:
Symbolic: -rwsr-xr-x (s in owner execute)
Numeric: 4755 (4 = setuid bit)

Capital S vs lowercase s:
- s = setuid + execute permission
- S = setuid but NO execute (broken/useless)
EOF

cat setuid-security.txt
