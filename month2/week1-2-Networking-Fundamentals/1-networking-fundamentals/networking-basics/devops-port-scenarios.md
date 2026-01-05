# Port and Protocol Scenarios in DevOps

## Scenario 1: Web Application Deployment

**Stack:**
- Frontend: React (Port 3000 in dev, served by nginx:80 in prod)
- Backend API: Node.js (Port 4000)
- Database: PostgreSQL (Port 5432)
- Cache: Redis (Port 6379)

**Security Group Rules:**
```
Load Balancer (Public):
- Inbound: 80, 443 from 0.0.0.0/0
- Outbound: 4000 to app servers

App Servers (Private):
- Inbound: 4000 from load balancer
- Outbound: 5432 to database, 6379 to cache

Database (Private):
- Inbound: 5432 from app servers only
- Outbound: None needed

Cache (Private):
- Inbound: 6379 from app servers only
```

## Scenario 2: Monitoring Stack

**Services:**
- Prometheus: 9090
- Grafana: 3000
- Alertmanager: 9093
- Node Exporter: 9100

**Access:**
```
Public:
- Grafana:3000 (with authentication)

Internal only:
- Prometheus:9090
- Alertmanager:9093
- Node Exporter:9100
```

## Scenario 3: CI/CD Pipeline

**Tools:**
- Jenkins: 8080
- Docker Registry: 5000
- Kubernetes API: 6443
- ArgoCD: 8080 (UI), 8083 (gRPC)

**Port Mapping:**
```bash
# Jenkins accessible externally
jenkins.example.com:443 → Load Balancer:443 → Jenkins:8080

# Docker Registry internal only
registry.internal:5000

# Kubernetes API secured
api.k8s.example.com:6443 (TLS certificate required)
```

## Scenario 4: Microservices

**Services:**
- Auth Service: 8001
- User Service: 8002
- Order Service: 8003
- Payment Service: 8004
- API Gateway: 8000

**Communication:**
```
External → API Gateway:8000
API Gateway → Internal services (8001-8004)
Services → Message Queue (RabbitMQ:5672)
Services → Database (separate ports per service)
```

## Scenario 5: Troubleshooting

**Problem:** Application not accessible

**Debug Steps:**
```bash
# 1. Check if port is listening
ss -tuln | grep :80

# 2. Check if service is running
systemctl status nginx

# 3. Check firewall
sudo ufw status
sudo iptables -L

# 4. Test connectivity
curl -v http://localhost:80

# 5. Check security group (AWS)
aws ec2 describe-security-groups --group-ids sg-xxx

# 6. Check application logs
journalctl -u nginx -f
```

## Common Port Conflicts

**Problem:** Port already in use
```bash
# Find process using port 8080
lsof -i :8080
# or
ss -tulpn | grep :8080

# Kill process
kill -9 <PID>

# Or use different port
docker run -p 8081:80 nginx
```

## Best Practices

1. **Never expose databases directly to internet**
   - Always use private subnets
   - Connect via application layer

2. **Use non-standard ports for security by obscurity**
   - SSH on 2222 instead of 22 (reduces automated attacks)
   - But don't rely on this alone

3. **Document all port assignments**
   - Maintain port registry
   - Avoid conflicts

4. **Use environment variables for ports**
```bash
   PORT=${PORT:-8080}
```

5. **Implement health checks**
```bash
   curl -f http://localhost:8080/health || exit 1
```

6. **Use TLS for sensitive services**
   - Always encrypt: databases, APIs, admin panels

7. **Implement rate limiting**
   - Prevent abuse on public ports

8. **Monitor port usage**
   - Alert on unexpected open ports
   - Track connection counts
