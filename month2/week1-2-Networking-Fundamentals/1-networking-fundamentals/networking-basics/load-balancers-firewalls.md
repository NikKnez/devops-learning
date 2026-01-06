# Load Balancers, Firewalls & Security Groups


## Load Balancers

### What is a Load Balancer?

A load balancer distributes incoming traffic across multiple servers to:
- **Prevent overload**: No single server handles all traffic
- **Increase availability**: If one server fails, others continue
- **Enable scaling**: Add/remove servers based on demand
- **Improve performance**: Route traffic to nearest/fastest server

### Load Balancer Architecture
```
Internet
    |
    v
Load Balancer (Public IP)
    |
    +---> Server 1 (Private IP)
    |
    +---> Server 2 (Private IP)
    |
    +---> Server 3 (Private IP)
```

### Load Balancing Algorithms

**Round Robin** (Most common)
- Distributes requests evenly in order
- Server 1 → Server 2 → Server 3 → Server 1...
- Simple and fair
- Good for servers with equal capacity

**Least Connections**
- Routes to server with fewest active connections
- Good when request processing time varies
- Better for long-lived connections

**IP Hash**
- Uses client IP to determine server
- Same client always goes to same server
- Good for session persistence (sticky sessions)

**Weighted Round Robin**
- Servers assigned weights based on capacity
- Powerful server gets more requests
- Server 1 (weight 3), Server 2 (weight 1)

**Least Response Time**
- Routes to server with fastest response
- Requires health checks and monitoring
- Optimal performance

**Geographic/Geolocation**
- Routes based on user location
- Europe users → EU servers
- US users → US servers

### Load Balancer Types

**Layer 4 (Transport Layer) - Network Load Balancer**
- Works with TCP/UDP
- Fast (low latency)
- No inspection of application data
- Routes based on IP and port
- Use case: High performance, simple routing

**Layer 7 (Application Layer) - Application Load Balancer**
- Works with HTTP/HTTPS
- Can inspect request content (URL, headers, cookies)
- Advanced routing (path-based, host-based)
- SSL termination
- Use case: Web applications, microservices

**Example AWS ALB routing:**
```
mydomain.com/api/*     → API servers
mydomain.com/images/*  → Image servers
mydomain.com/*         → Web servers
```

### Health Checks

Load balancers perform health checks to detect failed servers:
```
Health Check Configuration:
- Protocol: HTTP
- Path: /health
- Port: 80
- Interval: 30 seconds
- Timeout: 5 seconds
- Healthy threshold: 2 consecutive successes
- Unhealthy threshold: 3 consecutive failures
```

**Health check endpoint example:**
```python
@app.route('/health')
def health():
    # Check database
    if database.is_connected():
        return {'status': 'healthy'}, 200
    else:
        return {'status': 'unhealthy'}, 503
```

**States:**
- **Healthy**: Server passes health checks, receives traffic
- **Unhealthy**: Server fails health checks, no traffic
- **Draining**: Server being removed, no new traffic, existing connections finish

### Session Persistence (Sticky Sessions)

Problem: User logs in → Load balancer routes to Server 1
Next request → Routes to Server 2 (user not logged in!)

**Solution 1: Cookie-based stickiness**
- Load balancer sets cookie with server ID
- Future requests go to same server
- Duration: 1 hour, 1 day, etc.

**Solution 2: IP-based stickiness**
- Use client IP to determine server
- Simple but less reliable (NAT, proxies)

**Solution 3: Shared session storage (Best for cloud)**
- Store sessions in Redis/database
- Any server can handle any request
- Most scalable

### SSL/TLS Termination

**Without SSL termination:**
```
Client --HTTPS--> Load Balancer --HTTPS--> Server
- Server handles SSL encryption
- More CPU usage on servers
- Each server needs SSL certificate
```

**With SSL termination:**
```
Client --HTTPS--> Load Balancer --HTTP--> Server
- Load balancer handles SSL
- Servers receive plain HTTP
- One certificate on load balancer
- Faster servers (no encryption overhead)
```

**Security consideration:** Use internal network or VPN between LB and servers.

## Firewalls

### What is a Firewall?

A firewall controls network traffic based on rules:
- **Allow** specific traffic
- **Deny** unwanted traffic
- Protect against attacks
- Enforce security policies

### Firewall Types

**Packet Filtering Firewall**
- Examines each packet (source IP, dest IP, port, protocol)
- Simple and fast
- No state tracking

**Stateful Firewall**
- Tracks connection state
- Allows responses to outbound connections
- More intelligent
- Modern firewalls use this

**Application Firewall (WAF)**
- Layer 7 protection
- Inspects HTTP/HTTPS traffic
- Protects against: SQL injection, XSS, CSRF
- Examples: AWS WAF, Cloudflare

**Next-Generation Firewall (NGFW)**
- Deep packet inspection
- Intrusion prevention (IPS)
- Application awareness
- Advanced threat detection

### Linux Firewall Tools

#### UFW (Uncomplicated Firewall) - Ubuntu
```bash
# Enable firewall
sudo ufw enable

# Default policies
sudo ufw default deny incoming
sudo ufw default allow outgoing

# Allow SSH (before enabling!)
sudo ufw allow 22/tcp
sudo ufw allow ssh

# Allow HTTP/HTTPS
sudo ufw allow 80/tcp
sudo ufw allow 443/tcp
sudo ufw allow http
sudo ufw allow https

# Allow specific IP
sudo ufw allow from 192.168.1.100

# Allow specific IP to specific port
sudo ufw allow from 192.168.1.100 to any port 22

# Allow subnet
sudo ufw allow from 10.0.0.0/8

# Deny specific port
sudo ufw deny 3306/tcp

# Delete rule
sudo ufw delete allow 80/tcp
sudo ufw delete 2  # By rule number

# Show rules
sudo ufw status
sudo ufw status numbered
sudo ufw status verbose

# Disable firewall
sudo ufw disable

# Reset all rules
sudo ufw reset
```

#### iptables - Advanced (All Linux)
```bash
# View rules
sudo iptables -L -n -v

# Allow SSH
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow HTTP/HTTPS
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow established connections
sudo iptables -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT

# Allow loopback
sudo iptables -A INPUT -i lo -j ACCEPT

# Drop everything else
sudo iptables -A INPUT -j DROP

# Save rules (Ubuntu/Debian)
sudo iptables-save > /etc/iptables/rules.v4

# Save rules (CentOS/RHEL)
sudo service iptables save
```

#### firewalld - CentOS/RHEL
```bash
# Check status
sudo firewall-cmd --state

# List all
sudo firewall-cmd --list-all

# Add service
sudo firewall-cmd --add-service=http --permanent
sudo firewall-cmd --add-service=https --permanent

# Add port
sudo firewall-cmd --add-port=8080/tcp --permanent

# Add source
sudo firewall-cmd --add-source=192.168.1.0/24 --permanent

# Reload
sudo firewall-cmd --reload

# Remove rule
sudo firewall-cmd --remove-service=http --permanent
```

## Cloud Security Groups (AWS Example)

### What are Security Groups?

Virtual firewalls for cloud instances:
- **Stateful**: Return traffic automatically allowed
- **Allow rules only**: Cannot create deny rules (use NACLs)
- **Applied to instances**: Not to subnets
- **Multiple per instance**: Can attach several security groups

### Security Group Structure

**Inbound Rules** (Traffic TO your instance)
```
Type        Protocol    Port Range    Source
SSH         TCP         22            My IP (123.45.67.89/32)
HTTP        TCP         80            0.0.0.0/0 (anywhere)
HTTPS       TCP         443           0.0.0.0/0
MySQL       TCP         3306          sg-app-servers
Custom      TCP         8080          10.0.0.0/16 (VPC CIDR)
```

**Outbound Rules** (Traffic FROM your instance)
```
Type        Protocol    Port Range    Destination
All traffic All         All           0.0.0.0/0 (default)
```

### Security Group Best Practices

**1. Principle of Least Privilege**
```
BAD:
- SSH from 0.0.0.0/0 (whole internet)
- All ports open

GOOD:
- SSH from office IP only (203.0.113.10/32)
- Only required ports (80, 443)
```

**2. Reference Other Security Groups**
```
Web Server Security Group:
- Allow 80/443 from 0.0.0.0/0
- Allow 8080 from Load Balancer SG

App Server Security Group:
- Allow 8080 from Web Server SG only
- Allow 3306 to Database SG only

Database Security Group:
- Allow 3306 from App Server SG only
```

**3. Use Descriptive Names**
```
Good names:
- web-servers-sg
- app-servers-sg
- database-sg
- bastion-sg

Bad names:
- sg-123
- default
- testing
```

**4. Document Rules**
```
Add description to each rule:
- "SSH access from office VPN"
- "HTTP traffic from internet"
- "Database access from app servers"
```

### Network ACLs vs Security Groups

**Network ACLs (NACLs)**
- Subnet level
- Stateless (must allow both inbound and outbound)
- Allow and deny rules
- Numbered rules (processed in order)
- Default: Allow all

**Security Groups**
- Instance level
- Stateful (return traffic automatic)
- Allow rules only
- All rules evaluated
- Default: Deny all inbound

**Use both:**
- NACLs: Broad subnet protection
- Security Groups: Fine-grained instance control

## Real DevOps Scenarios

### Scenario 1: Web Application Architecture
```
Internet
    |
    v
Internet Gateway
    |
    v
Application Load Balancer (Public subnet)
    |
    +---> Web Server 1 (Private subnet)
    +---> Web Server 2 (Private subnet)
         |
         v
    Database (Private subnet)

Security Groups:
1. ALB-SG:
   - Inbound: 80, 443 from 0.0.0.0/0
   - Outbound: 8080 to Web-SG

2. Web-SG:
   - Inbound: 8080 from ALB-SG
   - Inbound: 22 from Bastion-SG
   - Outbound: 3306 to DB-SG

3. DB-SG:
   - Inbound: 3306 from Web-SG only
   - Outbound: None needed
```

### Scenario 2: Multi-Tier with Caching
```
Load Balancer
    |
    v
App Servers
    |
    +---> Redis Cache (6379)
    +---> PostgreSQL DB (5432)

Firewall Rules:
- App servers can reach Redis:6379
- App servers can reach DB:5432
- Redis and DB cannot reach internet
- Only app servers can initiate connections
```

### Scenario 3: Blue-Green Deployment
```
Load Balancer
    |
    +---> Blue Environment (current production)
    +---> Green Environment (new version)

Process:
1. Deploy to green (no traffic)
2. Test green environment
3. Update LB to route to green
4. Monitor for issues
5. Keep blue for rollback
6. After 24h, decommission blue
```

### Scenario 4: High Availability
```
Region 1
    ALB-1 --> Servers in AZ-1a, AZ-1b
    
Region 2
    ALB-2 --> Servers in AZ-2a, AZ-2b

Route53 (DNS)
    |
    +---> ALB-1 (latency routing)
    +---> ALB-2 (latency routing)

If Region 1 fails:
- Route53 detects via health checks
- Routes all traffic to Region 2
- Automatic failover
```

## Troubleshooting

### Load Balancer Issues

**Problem: 502 Bad Gateway**
```
Causes:
1. Backend servers down
2. Health checks failing
3. Security group blocking LB → servers
4. Application returning errors

Debug:
1. Check target health
2. Test backend directly: curl http://server-ip
3. Review application logs
4. Verify security groups
```

**Problem: Uneven traffic distribution**
```
Causes:
1. Long-lived connections (websockets)
2. Sticky sessions enabled
3. Different server performance

Solutions:
1. Use least connections algorithm
2. Check server capacity
3. Review connection draining settings
```

### Firewall Issues

**Problem: Can't SSH to server**
```
Debug:
1. Check if port 22 allowed
   sudo ufw status | grep 22
   
2. Check from which IPs
   sudo ufw status numbered
   
3. Temporarily allow your IP
   sudo ufw allow from YOUR_IP to any port 22
   
4. Check logs
   sudo tail -f /var/log/ufw.log
```

**Problem: Application timeout**
```
Debug:
1. Check if application port is allowed
2. Test locally: curl localhost:8080
3. Check outbound rules
4. Verify security group egress rules
5. Check NACLs if in AWS
```

### Security Group Issues

**Problem: Can't connect to database**
```
Checklist:
1. Is DB security group allowing app server SG?
2. Is DB in private subnet?
3. Is route table correct?
4. Can you ping DB from app server?
5. Is DB service running?
6. Check DB logs
```

**Problem: Website not loading**
```
Layer by layer:
1. DNS resolving? (dig domain.com)
2. LB health checks passing?
3. Security group allows 80/443?
4. Servers responding? (ssh and curl localhost)
5. Application logs showing errors?
```
