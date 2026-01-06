# Load Balancers, Firewalls & Security Groups


## Concepts Learned

### Load Balancers
- Traffic distribution across multiple servers
- Algorithms: Round robin, least connections, IP hash, weighted
- Layer 4 (Network) vs Layer 7 (Application)
- Health checks and server states
- Session persistence (sticky sessions)
- SSL/TLS termination
- High availability and failover

### Firewalls
- Network traffic control
- Types: Packet filtering, stateful, application (WAF), NGFW
- Linux firewalls: UFW, iptables, firewalld
- Inbound vs outbound rules
- Default deny principle
- Rule ordering and evaluation

### Security Groups (Cloud)
- Virtual firewalls for cloud instances
- Stateful operation
- Allow rules only (no deny)
- Instance-level vs subnet-level (NACLs)
- Security group chaining
- Best practices and patterns

## Tools Learned
```bash
# UFW
sudo ufw enable
sudo ufw allow 22/tcp
sudo ufw status
sudo ufw delete allow 80

# iptables
sudo iptables -L -n -v
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# firewalld
sudo firewall-cmd --list-all
sudo firewall-cmd --add-service=http --permanent
```

## Real DevOps Applications

### Architecture Patterns
1. **Three-tier:**
   - Load Balancer → Web Servers → App Servers → Database

2. **Microservices:**
   - API Gateway → Service Mesh → Individual Services

3. **High Availability:**
   - Multi-region, multi-AZ deployment
   - Health checks and automatic failover

### Security Layers
1. **Perimeter:** Internet Gateway, WAF
2. **Network:** Security Groups, NACLs
3. **Host:** UFW, iptables
4. **Application:** Input validation, authentication

## Key Takeaways

1. **Load Balancing:**
   - Essential for scalability and availability
   - Choose algorithm based on use case
   - Implement proper health checks
   - Plan for SSL termination

2. **Firewall Rules:**
   - Default deny, explicitly allow
   - Principle of least privilege
   - Document all rules
   - Test after changes

3. **Security Groups:**
   - Use descriptive names
   - Reference other security groups
   - One security group per tier
   - Never expose databases to internet

4. **Troubleshooting:**
   - Check layer by layer
   - Verify rules on both sides
   - Test with simple tools (curl, nc)
   - Review logs for blocks

## Practice Completed
- Firewall configuration scripts
- Load balancer algorithm demonstrations
- Security group templates
- Multi-tier architecture designs
- Troubleshooting scenarios

## Common Patterns

### Web Application Stack
```
Internet (0.0.0.0/0)
    ↓ 80/443
Load Balancer (public subnet)
    ↓ 8080
Web Servers (private subnet)
    ↓ 8081
App Servers (private subnet)
    ↓ 5432
Database (private subnet)
```

### Bastion Access Pattern
```
Developer (office IP)
    ↓ 22
Bastion Host (public subnet)
    ↓ 22
Internal Servers (private subnet)
```

## Next: Review and Practice
