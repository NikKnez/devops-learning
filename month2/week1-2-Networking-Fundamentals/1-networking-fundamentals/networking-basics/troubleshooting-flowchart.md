# Network Troubleshooting Decision Tree

## Problem: Cannot access service

### Step 1: Can you ping the host?

**YES** → Go to Step 2
**NO** → Check:
- Is hostname correct? (try nslookup/dig)
- Is host up? (ask administrator)
- Is ICMP blocked? (try telnet/nc to port)
- Is routing correct? (traceroute)
- Is local network working? (ping gateway)

### Step 2: Can you reach the port?
```bash
nc -zv host port
telnet host port
```

**YES** → Go to Step 3
**NO** → Check:
- Is service running? (systemctl status)
- Is service listening? (ss -tuln | grep port)
- Is firewall blocking? (ufw status / iptables -L)
- Is security group open? (AWS console)
- Is port correct?

### Step 3: Can you make request?
```bash
curl http://host:port
```

**YES** → Go to Step 4
**NO** → Check:
- Application logs
- Error response (4xx, 5xx)
- Authentication required?
- SSL/TLS issues?

### Step 4: Is response correct?

**YES** → Problem is client-side (browser, cache, etc.)
**NO** → Check:
- Application logic
- Database connectivity
- Backend services
- Configuration

## SSH-Specific Troubleshooting

### Problem: SSH connection refused
```
1. Check: nc -zv host 22
   Closed? → Firewall or SSH not running
   Open? → Go to 2

2. Try: ssh -v user@host
   Review verbose output for clues

3. Check server:
   sudo systemctl status sshd
   sudo tail /var/log/auth.log

4. Common fixes:
   - Restart SSH: sudo systemctl restart sshd
   - Check config: sudo sshd -t
   - Verify keys: cat ~/.ssh/authorized_keys
```

### Problem: Permission denied
```
1. Check key permissions:
   chmod 600 ~/.ssh/id_ed25519
   chmod 700 ~/.ssh

2. Check if key is offered:
   ssh -v user@host | grep "Offering"

3. On server, check:
   - Public key in authorized_keys
   - File permissions (700 for .ssh, 600 for authorized_keys)
   - SELinux contexts (restorecon -R ~/.ssh)
```

## Quick Reference Commands
```bash
# Test connectivity
ping -c 4 host
nc -zv host port
curl -v http://host

# Check local
ip addr
ip route
ss -tuln

# DNS
nslookup host
dig host

# Trace
traceroute host
mtr host

# SSH debug
ssh -vvv user@host
```
