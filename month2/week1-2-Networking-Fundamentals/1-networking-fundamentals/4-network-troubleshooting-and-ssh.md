# Network Troubleshooting & SSH


## Network Troubleshooting Methodology

### The OSI Model (Simplified for DevOps)

**Layer 7: Application** (HTTP, SSH, DNS)
- Problem: Application not responding
- Check: Application logs, service status

**Layer 4: Transport** (TCP/UDP, Ports)
- Problem: Port blocked, service not listening
- Check: Firewall, port availability

**Layer 3: Network** (IP, Routing)
- Problem: Can't reach destination
- Check: Routing, IP configuration

**Layer 2: Data Link** (MAC addresses, switches)
- Problem: Local network issues
- Check: Network interface, cables

**Layer 1: Physical** (Cables, hardware)
- Problem: No connection at all
- Check: Physical connections, hardware

### Troubleshooting Process

1. **Define the problem**
   - What is not working?
   - When did it start?
   - What changed?

2. **Gather information**
   - Error messages
   - Log files
   - Network configuration

3. **Test hypotheses**
   - Start at one OSI layer
   - Move up or down as needed

4. **Fix and verify**
   - Apply fix
   - Test thoroughly
   - Document solution

## Network Troubleshooting Tools

### ping - Test Connectivity
```bash
# Basic ping
ping google.com

# Specific count
ping -c 4 google.com

# Specific interval (0.2 seconds)
ping -i 0.2 google.com

# Flood ping (requires root, use carefully)
sudo ping -f google.com

# Ping with timestamp
ping google.com | while read line; do echo "$(date): $line"; done
```

**What ping tells you:**
- Host is reachable (or not)
- Round-trip time (latency)
- Packet loss percentage
- DNS resolution working

**Common ping results:**
- 0% packet loss: Good connection
- <5% packet loss: Acceptable
- >5% packet loss: Network issues
- 100% packet loss: No connection or host down

### traceroute - Show Network Path
```bash
# Trace route to destination
traceroute google.com

# Don't resolve hostnames (faster)
traceroute -n google.com

# Use ICMP instead of UDP
traceroute -I google.com

# Max hops
traceroute -m 15 google.com
```

**Reading traceroute output:**
```
1  192.168.1.1 (router)         1.234 ms
2  10.0.0.1 (ISP gateway)       5.678 ms
3  * * * (timeout - firewall?)
4  8.8.8.8 (destination)        15.234 ms
```

### netcat (nc) - Swiss Army Knife
```bash
# Test port connectivity
nc -zv example.com 80

# Test multiple ports
nc -zv example.com 80 443 22

# Listen on port (simple server)
nc -l 8080

# Connect to port (simple client)
nc localhost 8080

# Transfer file
# On receiver:
nc -l 9999 > received_file.txt
# On sender:
nc receiver_ip 9999 < file.txt

# Port scanning (be careful, only on your own systems)
nc -zv target.com 20-100
```

### tcpdump - Packet Analysis
```bash
# Capture packets on interface
sudo tcpdump -i eth0

# Capture specific port
sudo tcpdump -i eth0 port 80

# Capture and save to file
sudo tcpdump -i eth0 -w capture.pcap

# Read from file
tcpdump -r capture.pcap

# Show only TCP SYN packets
sudo tcpdump -i eth0 'tcp[tcpflags] & tcp-syn != 0'

# Capture HTTP traffic
sudo tcpdump -i eth0 -A port 80

# Limit packet capture
sudo tcpdump -i eth0 -c 100  # Capture 100 packets
```

### mtr - Combined ping and traceroute
```bash
# Interactive mode
mtr google.com

# Report mode (10 packets)
mtr --report --report-cycles 10 google.com

# No DNS resolution
mtr -n google.com
```

**mtr advantages:**
- Combines ping and traceroute
- Shows packet loss per hop
- Continuous monitoring
- Better for intermittent issues

## SSH (Secure Shell)

### SSH Basics

SSH provides:
- Secure remote access
- Encrypted communication
- File transfer (SCP, SFTP)
- Tunneling capabilities

### SSH Key Authentication

**Generate SSH key pair:**
```bash
# Generate key (recommended: ed25519)
ssh-keygen -t ed25519 -C "your_email@example.com"

# Or RSA (if ed25519 not supported)
ssh-keygen -t rsa -b 4096 -C "your_email@example.com"

# Keys saved to:
# Private key: ~/.ssh/id_ed25519
# Public key: ~/.ssh/id_ed25519.pub
```

**Key structure:**
- Private key: Keep secret, never share
- Public key: Copy to servers you want to access

**Copy public key to server:**
```bash
# Method 1: ssh-copy-id (easiest)
ssh-copy-id user@server

# Method 2: Manual
cat ~/.ssh/id_ed25519.pub | ssh user@server "mkdir -p ~/.ssh && cat >> ~/.ssh/authorized_keys"

# Method 3: Direct copy
scp ~/.ssh/id_ed25519.pub user@server:~/.ssh/authorized_keys
```

### SSH Configuration

**Client config (~/.ssh/config):**
```bash
# Create SSH config
cat > ~/.ssh/config << 'SSHEOF'
# Default settings for all hosts
Host *
    ServerAliveInterval 60
    ServerAliveCountMax 3
    
# Production server
Host prod
    HostName 54.123.45.67
    User ubuntu
    Port 22
    IdentityFile ~/.ssh/id_ed25519
    
# Development server
Host dev
    HostName dev.example.com
    User developer
    Port 2222
    IdentityFile ~/.ssh/dev_key
    
# Jump host (bastion)
Host internal-server
    HostName 10.0.1.50
    User admin
    ProxyJump bastion
    
Host bastion
    HostName bastion.example.com
    User admin
SSHEOF

chmod 600 ~/.ssh/config
```

**Now connect simply:**
```bash
ssh prod  # Instead of: ssh ubuntu@54.123.45.67
ssh dev
ssh internal-server  # Automatically jumps through bastion
```

### SSH Commands
```bash
# Basic connection
ssh user@host

# Specific port
ssh -p 2222 user@host

# Execute remote command
ssh user@host "uptime"

# Execute multiple commands
ssh user@host "cd /var/log && tail -10 syslog"

# Copy file to remote (SCP)
scp file.txt user@host:/path/to/destination/

# Copy file from remote
scp user@host:/path/to/file.txt ./local/

# Copy directory recursively
scp -r directory/ user@host:/path/

# SFTP (interactive file transfer)
sftp user@host
# Then use: get, put, ls, cd, etc.
```

### SSH Tunneling (Port Forwarding)

**Local port forwarding:**
```bash
# Forward local port 8080 to remote port 80
ssh -L 8080:localhost:80 user@host

# Now access: http://localhost:8080
# Traffic goes through SSH tunnel to remote:80
```

**Use case:** Access remote database securely
```bash
# Forward local 5432 to remote PostgreSQL
ssh -L 5432:localhost:5432 user@database-server

# Connect to database
psql -h localhost -p 5432 -U dbuser
```

**Remote port forwarding:**
```bash
# Forward remote port 8080 to local port 3000
ssh -R 8080:localhost:3000 user@host

# Remote users access host:8080 → your localhost:3000
```

**Use case:** Demo local development to team
```bash
# Your local React app on port 3000
ssh -R 8080:localhost:3000 user@demo-server

# Team accesses: demo-server:8080
```

**Dynamic port forwarding (SOCKS proxy):**
```bash
# Create SOCKS proxy on port 9999
ssh -D 9999 user@host

# Configure browser to use SOCKS5 proxy: localhost:9999
# All traffic routes through SSH tunnel
```

### SSH Security Best Practices

**Server-side (/etc/ssh/sshd_config):**
```bash
# Disable root login
PermitRootLogin no

# Disable password authentication
PasswordAuthentication no

# Only allow specific users
AllowUsers user1 user2

# Change default port (security through obscurity)
Port 2222

# Disable empty passwords
PermitEmptyPasswords no

# Limit authentication attempts
MaxAuthTries 3

# Use Protocol 2 only
Protocol 2
```

**Client-side best practices:**
```bash
# Use SSH keys, not passwords
# Generate strong keys (ed25519 or RSA 4096)

# Protect private key
chmod 600 ~/.ssh/id_ed25519

# Use different keys for different purposes
ssh-keygen -t ed25519 -f ~/.ssh/work_key
ssh-keygen -t ed25519 -f ~/.ssh/personal_key

# Use SSH agent to avoid repeated passphrase entry
eval $(ssh-agent)
ssh-add ~/.ssh/id_ed25519

# Add timeout to SSH agent
ssh-add -t 3600 ~/.ssh/id_ed25519  # 1 hour
```

## Troubleshooting Common Issues

### Issue 1: Can't reach server
```bash
# Step 1: Ping the server
ping server.example.com

# If ping fails, check DNS
nslookup server.example.com
dig server.example.com

# If DNS works but ping fails, check routing
traceroute server.example.com

# Check if host is up (port scan)
nc -zv server.example.com 22
```

### Issue 2: SSH connection refused
```bash
# Check if SSH port is open
nc -zv server.example.com 22

# If closed, check firewall on server
# On server:
sudo ufw status
sudo iptables -L | grep 22

# Check if SSH service is running
# On server:
sudo systemctl status sshd
sudo systemctl status ssh
```

### Issue 3: SSH timeout
```bash
# Test with verbose output
ssh -vvv user@host

# Common causes:
# - Firewall blocking
# - Wrong port
# - Network issue between you and server
# - Server overloaded

# Try different port if changed
ssh -p 2222 user@host
```

### Issue 4: Permission denied (publickey)
```bash
# Check if key is being offered
ssh -v user@host 2>&1 | grep "Offering public key"

# Ensure key has correct permissions
chmod 600 ~/.ssh/id_ed25519
chmod 644 ~/.ssh/id_ed25519.pub
chmod 700 ~/.ssh

# Ensure public key is on server
ssh user@host "cat ~/.ssh/authorized_keys"

# Check server logs for clues
# On server:
sudo tail -f /var/log/auth.log
```

### Issue 5: Slow SSH connection
```bash
# Disable DNS lookup on server
# Add to /etc/ssh/sshd_config:
UseDNS no

# Disable GSSAPI authentication
# In ~/.ssh/config or command line:
ssh -o GSSAPIAuthentication=no user@host

# Use compression for slow links
ssh -C user@host
```
