# SSH Practice Exercises

## Exercise 1: Generate and Configure SSH Keys
```bash
# Generate new key
ssh-keygen -t ed25519 -f ~/.ssh/practice_key -C "practice"

# View public key
cat ~/.ssh/practice_key.pub

# Set correct permissions
chmod 600 ~/.ssh/practice_key
chmod 644 ~/.ssh/practice_key.pub
```

## Exercise 2: Create SSH Config
```bash
# Add to ~/.ssh/config
cat >> ~/.ssh/config << 'CONFIG'
Host practice
    HostName localhost
    User $(whoami)
    Port 22
    IdentityFile ~/.ssh/practice_key
CONFIG

# Now connect with: ssh practice
```

## Exercise 3: SSH Tunneling
```bash
# Start a local web server
python3 -m http.server 8000 &

# Create SSH tunnel (to localhost for practice)
ssh -L 9000:localhost:8000 localhost

# Access in browser: http://localhost:9000
# Traffic: Browser → localhost:9000 → SSH → localhost:8000
```

## Exercise 4: Execute Remote Commands
```bash
# Single command
ssh localhost "hostname"

# Multiple commands
ssh localhost "uptime; df -h; free -h"

# Save output
ssh localhost "ps aux" > processes.txt
```

## Exercise 5: File Transfer
```bash
# Create test file
echo "Test content" > test.txt

# Copy to remote (in this case localhost)
scp test.txt localhost:/tmp/

# Verify
ssh localhost "cat /tmp/test.txt"

# Copy back
scp localhost:/tmp/test.txt ./test_copy.txt
```
