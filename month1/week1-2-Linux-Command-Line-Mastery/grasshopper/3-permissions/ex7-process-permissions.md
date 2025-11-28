# Exercise 7: Process Permissions


## Task 7.1: View Process Ownership
# List processes with owner
ps aux | head -20

# Format: USER PID ...
# Shows which user owns each process

# Your processes
ps -u nikola

# Root processes
ps -u root | head -10


## Task 7.2: Process Real vs Effective UID
# Create demo script
cat > process-perm.sh << 'EOF'
#!/bin/bash
echo "=== Process Permission Info ==="
echo "Real User: $(whoami)"
echo "Real UID: $(id -ru)"
echo "Effective UID: $(id -u)"
echo "Real GID: $(id -rg)"
echo "Effective GID: $(id -g)"
echo "All groups: $(id -G)"
EOF

chmod +x process-perm.sh
./process-perm.sh


## Task 7.3: Understanding Process Permissions
# Create explanation
cat > process-permissions.txt << 'EOF'
=== Process Permissions ===

Every process runs with:
1. Real UID/GID - actual user who started process
2. Effective UID/GID - permissions used for access checks

Normal case: Real UID = Effective UID

Special case (setuid): Real UID = you, Effective UID = file owner

Example: passwd command
- You run it (Real UID = nikola)
- Runs as root (Effective UID = 0)
- Can modify /etc/shadow (root-only file)

Security: Process can only access files that Effective UID can access
EOF

cat process-permissions.txt
