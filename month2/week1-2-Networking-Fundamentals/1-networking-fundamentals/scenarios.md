# Practical Scenarios

## Scenario 1: New Web Application Deployment

**Situation:**
You need to deploy a web application with these requirements:
- Frontend: React app
- Backend: Node.js API
- Database: PostgreSQL
- Expected traffic: 10,000 users/day

**Tasks:**

1. **IP Planning:**
   - VPC CIDR: 10.0.0.0/16
   - Public subnet for load balancer: ?
   - Private subnet for app servers: ?
   - Private subnet for database: ?

**Answer:**
- Public: 10.0.1.0/24 (254 hosts)
- App servers: 10.0.2.0/24 (254 hosts)
- Database: 10.0.3.0/24 (254 hosts)

2. **DNS Setup:**
   - Domain: myapp.com
   - What DNS records needed?

**Answer:**
- A record: myapp.com → Load Balancer IP
- CNAME: www.myapp.com → myapp.com
- (Optional) CNAME: api.myapp.com → Load Balancer

3. **Port Configuration:**
   - What ports should be open on load balancer?
   - What ports on app servers?
   - What ports on database?

**Answer:**
- Load balancer: 80 (HTTP), 443 (HTTPS) from 0.0.0.0/0
- App servers: 3000 (Node.js) from LB security group
- Database: 5432 (PostgreSQL) from app security group only

4. **Security Groups:**
   Design security groups for each tier.

**Answer:**
```
LB-SG:
  Inbound: 80, 443 from 0.0.0.0/0
  Outbound: 3000 to App-SG

App-SG:
  Inbound: 3000 from LB-SG, 22 from Bastion-SG
  Outbound: 5432 to DB-SG, 443 to 0.0.0.0/0

DB-SG:
  Inbound: 5432 from App-SG only
  Outbound: None
```

---

## Scenario 2: Troubleshooting Connection Issues

**Situation:**
Users report they can't access your application at app.example.com

**Troubleshooting Steps:**
```bash
# 1. Check DNS resolution
dig app.example.com
# Does it resolve? To what IP?

# 2. Check basic connectivity
ping app.example.com
# Is host reachable?

# 3. Check if service is listening
nc -zv app.example.com 80
nc -zv app.example.com 443
# Are ports open?

# 4. Test HTTP request
curl -I http://app.example.com
# What status code?

# 5. Check from different location
# Use online tools or VPN

# 6. Check load balancer
# AWS Console: Target health

# 7. Check application servers
ssh user@app-server
sudo systemctl status myapp
curl localhost:3000

# 8. Check security groups
# AWS Console: Verify rules

# 9. Check application logs
sudo journalctl -u myapp -f

# 10. Check network path
traceroute app.example.com
```

---

## Scenario 3: SSH Access Configuration

**Situation:**
Set up secure SSH access to production servers via bastion host.

**Requirements:**
- Developers should not have direct access to production
- All access must go through bastion
- Use key-based authentication only
- Different keys for production vs development

**Implementation:**
```bash
# 1. Generate production key
ssh-keygen -t ed25519 -f ~/.ssh/prod_key -C "production"

# 2. Configure SSH config
cat >> ~/.ssh/config << 'CONFIG'
Host bastion-prod
    HostName bastion.example.com
    User admin
    Port 22
    IdentityFile ~/.ssh/prod_key

Host prod-app-1
    HostName 10.0.2.10
    User deployer
    ProxyJump bastion-prod
    IdentityFile ~/.ssh/prod_key

Host prod-app-2
    HostName 10.0.2.11
    User deployer
    ProxyJump bastion-prod
    IdentityFile ~/.ssh/prod_key
CONFIG

# 3. Copy public key to bastion
ssh-copy-id -i ~/.ssh/prod_key.pub admin@bastion.example.com

# 4. On bastion, copy key to production servers
ssh bastion-prod
ssh-copy-id -i ~/.ssh/prod_key.pub deployer@10.0.2.10
ssh-copy-id -i ~/.ssh/prod_key.pub deployer@10.0.2.11

# 5. Now connect directly (automatic jump)
ssh prod-app-1
ssh prod-app-2
```

**Security checklist:**
- [ ] Password authentication disabled on all servers
- [ ] Root login disabled
- [ ] Bastion accessible only from office IP
- [ ] Production servers in private subnet
- [ ] Keys have passphrases
- [ ] Keys rotated every 90 days

---

## Scenario 4: Load Balancer Configuration

**Situation:**
Configure load balancer for high-traffic e-commerce site.

**Requirements:**
- Handle 50,000 requests/minute
- SSL termination at load balancer
- Session persistence for shopping cart
- Health checks every 10 seconds

**Configuration:**
```
Load Balancer Type: Application Load Balancer (Layer 7)

Listeners:
  - Port 80 (HTTP) → Redirect to 443
  - Port 443 (HTTPS) → Forward to target group

Target Group:
  - Protocol: HTTP
  - Port: 8080
  - Health check path: /health
  - Health check interval: 10 seconds
  - Healthy threshold: 2
  - Unhealthy threshold: 3
  - Timeout: 5 seconds

Targets:
  - app-server-1 (10.0.2.10:8080)
  - app-server-2 (10.0.2.11:8080)
  - app-server-3 (10.0.2.12:8080)

Stickiness:
  - Enabled: Yes
  - Type: Application cookie
  - Cookie name: SESSIONID
  - Duration: 3600 seconds (1 hour)

SSL Certificate:
  - Type: ACM certificate
  - Domain: shop.example.com

Algorithm:
  - Round robin (default)
  - Consider: Least outstanding requests for better performance
```

---

## Scenario 5: Multi-Region Disaster Recovery

**Situation:**
Design disaster recovery for critical application.

**Requirements:**
- Primary: eu-central-1 (Frankfurt)
- Secondary: us-east-1 (Virginia)
- Automatic failover
- RPO: 1 hour
- RTO: 30 minutes

**Architecture:**
```
Route53 (DNS)
    |
    +---> Health Check Primary
    |         |
    |         v
    |     ALB eu-central-1
    |         |
    |         v
    |     App Servers EU
    |         |
    |         v
    |     RDS Primary (Multi-AZ)
    |
    +---> Health Check Secondary
              |
              v
          ALB us-east-1
              |
              v
          App Servers US
              |
              v
          RDS Read Replica
```

**Route53 Configuration:**
```
Record: app.example.com
Type: A
Routing Policy: Failover

Primary:
  - Target: ALB-EU
  - Health check: HTTPS to ALB-EU/health
  - Evaluate target health: Yes

Secondary:
  - Target: ALB-US
  - Health check: HTTPS to ALB-US/health
  - Evaluate target health: Yes
```

**Failover Process:**
1. Route53 health check fails (3 consecutive failures)
2. Route53 automatically routes to secondary
3. Application continues running in US region
4. Data sync from RDS replica (max 1 hour delay)
5. Team investigates EU region issue
6. After fix, Route53 automatically fails back

---

## Your Turn: Create Your Own Scenario

Design a network architecture for:
- A microservices application with 5 services
- Each service needs its own database
- Inter-service communication required
- Must be highly available
- Must be secure

Include:
- IP addressing plan
- Security group design
- Load balancer configuration
- DNS setup
- Firewall rules
