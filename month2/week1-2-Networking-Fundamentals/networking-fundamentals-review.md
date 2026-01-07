# Networking Fundamentals Review

## Summary


### Day 31: IP Addressing & Subnetting
**Key Concepts:**
- IPv4 address format (192.168.1.1)
- IP classes (A, B, C)
- CIDR notation (/24, /16, /8)
- Subnet masks (255.255.255.0)
- Private vs public IP ranges
- Calculating usable hosts

**Commands:**
- ip addr show
- ip route
- hostname -I

**Real DevOps Use:**
- AWS VPC CIDR planning
- Kubernetes pod networks
- Docker network configuration
- Security group CIDR blocks

### Day 32: DNS
**Key Concepts:**
- Domain name to IP translation
- DNS hierarchy (root, TLD, domain, subdomain)
- Record types (A, AAAA, CNAME, MX, TXT, NS)
- DNS resolution process
- TTL and caching

**Commands:**
- nslookup domain.com
- dig domain.com
- dig domain.com +short
- dig domain.com +trace
- dig @8.8.8.8 domain.com

**Real DevOps Use:**
- Blue-green deployments
- Service discovery
- Multi-region routing
- Internal vs external DNS

### Day 33: Ports, Protocols & HTTP
**Key Concepts:**
- Port ranges (0-1023, 1024-49151, 49152-65535)
- Common ports (22, 80, 443, 3306, 5432, 9090)
- TCP vs UDP protocols
- HTTP methods (GET, POST, PUT, PATCH, DELETE)
- HTTP status codes (2xx, 3xx, 4xx, 5xx)
- Request/response headers

**Commands:**
- ss -tuln
- lsof -i :PORT
- nc -zv host port
- curl http://example.com
- curl -I http://example.com
- curl -v http://example.com

**Real DevOps Use:**
- API testing
- Service health checks
- Container port mapping
- Security group configuration

### Day 34: Network Troubleshooting & SSH
**Key Concepts:**
- OSI model troubleshooting
- Systematic debugging approach
- SSH key authentication
- Port forwarding (local, remote, dynamic)
- SSH config file
- Security best practices

**Commands:**
- ping -c 4 host
- traceroute host
- mtr host
- ssh user@host
- ssh -L local_port:remote:port user@host
- ssh-keygen -t ed25519
- ssh-copy-id user@host

**Real DevOps Use:**
- Remote server access
- Bastion/jump hosts
- Database tunneling
- CI/CD automation
- Ansible/Terraform execution

### Day 35: Load Balancers, Firewalls & Security Groups
**Key Concepts:**
- Load balancing algorithms
- Layer 4 vs Layer 7 load balancers
- Health checks
- Session persistence
- Firewall types and rules
- Security group patterns
- Defense in depth

**Commands:**
- sudo ufw status
- sudo ufw allow 22/tcp
- sudo iptables -L -n -v
- sudo firewall-cmd --list-all

**Real DevOps Use:**
- High availability architectures
- Traffic distribution
- Network security layers
- Cloud infrastructure security
- Multi-tier application design

## Knowledge Check

Answer these questions to test your understanding:

### IP Addressing
1. What is the CIDR notation for 255.255.255.0?
2. How many usable hosts in a /26 network?
3. What are the three private IP ranges?
4. What is the difference between 10.0.0.0/8 and 10.0.0.0/24?

### DNS
5. What DNS record type maps a domain to an IP address?
6. What is the purpose of a CNAME record?
7. How does DNS caching improve performance?
8. What command shows the DNS resolution path?

### Ports & Protocols
9. What port does HTTPS use by default?
10. What is the difference between TCP and UDP?
11. What HTTP status code indicates "Not Found"?
12. What HTTP method is idempotent for updates?

### SSH
13. What is the recommended SSH key type today?
14. What does ssh -L 8080:localhost:80 user@host do?
15. Where is the SSH config file located?
16. What command copies your public key to a server?

### Load Balancers & Firewalls
17. What is the difference between Layer 4 and Layer 7 load balancers?
18. What is a health check in load balancing?
19. What is the difference between stateful and stateless firewalls?
20. What is the principle of least privilege?

## Answers

1. /24
2. 62 hosts (64 - 2 for network and broadcast)
3. 10.0.0.0/8, 172.16.0.0/12, 192.168.0.0/16
4. /8 = 16 million hosts, /24 = 254 hosts
5. A record (or AAAA for IPv6)
6. Alias/pointer to another domain name
7. Reduces query time by storing previous lookups
8. dig domain.com +trace
9. Port 443
10. TCP is reliable/connection-oriented, UDP is fast/connectionless
11. 404
12. PUT
13. ed25519 (or RSA 4096 if ed25519 not supported)
14. Local port forwarding - forwards local 8080 to remote 80
15. ~/.ssh/config
16. ssh-copy-id user@host
17. L4 works with TCP/UDP (fast), L7 works with HTTP/HTTPS (intelligent routing)
18. Periodic check to verify server is healthy and can receive traffic
19. Stateful tracks connection state, stateless examines each packet independently
20. Grant only minimum required permissions/access

## Hands-on Review Exercises

Practice what is learned this week.
