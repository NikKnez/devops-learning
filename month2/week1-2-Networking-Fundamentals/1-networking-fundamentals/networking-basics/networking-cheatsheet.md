# Networking Commands Cheat Sheet

## Check Network Configuration
```bash
# Show IP addresses
ip addr show
ip a

# Show specific interface
ip addr show eth0

# Show routing table
ip route show

# Show default gateway
ip route | grep default

# Show DNS servers
cat /etc/resolv.conf
systemd-resolve --status  # On systems with systemd-resolved
```

## Port and Connection Management
```bash
# Show listening ports
ss -tuln
netstat -tuln  # Older alternative

# Show established connections
ss -tun | grep ESTAB

# Show processes using ports
ss -tulpn
lsof -i :8080  # Specific port

# Show all sockets
ss -a
```

## DNS Commands
```bash
# Simple lookup
nslookup google.com

# Detailed lookup
dig google.com

# Short answer
dig google.com +short

# Specific record type
dig google.com A
dig google.com MX
dig google.com NS

# Reverse lookup
dig -x 8.8.8.8

# Query specific DNS server
dig @8.8.8.8 google.com

# Trace DNS path
dig google.com +trace
```

## HTTP Testing
```bash
# Simple GET request
curl https://example.com

# Show headers
curl -I https://example.com

# Verbose output (see request/response)
curl -v https://example.com

# Follow redirects
curl -L https://example.com

# Custom headers
curl -H "Authorization: Bearer TOKEN" https://api.example.com

# POST request
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John"}'

# Save response
curl -o output.html https://example.com

# Measure time
curl -w "Time: %{time_total}s\n" -s -o /dev/null https://example.com
```

## Network Diagnostics
```bash
# Ping (test connectivity)
ping google.com
ping -c 4 google.com  # Send 4 packets

# Traceroute (show path)
traceroute google.com
traceroute -n google.com  # Don't resolve hostnames

# Test port connectivity
nc -zv example.com 80
telnet example.com 80

# Check route to destination
ip route get 8.8.8.8

# Show ARP cache
ip neigh show
arp -a
```

## Firewall Commands
```bash
# UFW (Ubuntu)
sudo ufw status
sudo ufw allow 80/tcp
sudo ufw deny 22/tcp
sudo ufw delete allow 80/tcp

# iptables
sudo iptables -L
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# firewalld (CentOS/RHEL)
sudo firewall-cmd --list-all
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --reload
```

## Quick Troubleshooting Flow
```bash
# 1. Check if service is running
systemctl status service-name

# 2. Check if port is listening
ss -tuln | grep :PORT

# 3. Test local connectivity
curl http://localhost:PORT

# 4. Test remote connectivity
curl http://SERVER_IP:PORT

# 5. Check firewall
sudo ufw status
sudo iptables -L

# 6. Check DNS
dig domain.com

# 7. Check routing
ip route get DESTINATION_IP

# 8. Check logs
journalctl -u service-name -f
tail -f /var/log/service.log
```
