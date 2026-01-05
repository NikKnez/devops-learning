# DNS in DevOps

## Scenario 1: Setting up a web application

You deploy app to server: 54.123.45.67
You want: app.example.com → 54.123.45.67

DNS Records needed:
- A record: app.example.com → 54.123.45.67

If using load balancer:
- CNAME: app.example.com → my-lb-123.eu-central-1.elb.amazonaws.com

## Scenario 2: Blue-Green Deployment

Current: app.example.com → blue-servers (10.0.1.50)
Deploy green-servers (10.0.1.100)

Process:
1. Deploy to green-servers
2. Test: green.example.com → 10.0.1.100
3. Switch DNS: app.example.com → 10.0.1.100
4. Wait for TTL to expire
5. Remove blue-servers

## Scenario 3: Multi-Region Setup

Users should go to nearest server:
- Europe: eu.example.com → 52.1.2.3
- US: us.example.com → 54.5.6.7
- Asia: asia.example.com → 13.8.9.10

Main domain routes based on location:
- example.com uses Route53 geolocation routing

## Scenario 4: Microservices

Internal service discovery:
- api.internal → 10.0.2.10
- db.internal → 10.0.3.20
- cache.internal → 10.0.4.30

Use: Internal DNS (Route53 private zones, CoreDNS)

## Common DNS Issues in DevOps

### Issue 1: DNS Caching
Problem: Updated A record, but old IP still resolving
Solution: Check TTL, wait or flush DNS cache

### Issue 2: Split-Horizon DNS
Problem: Internal and external users need different IPs
Solution: Separate internal/external DNS zones

### Issue 3: DNS Propagation
Problem: DNS changes take too long
Solution: Lower TTL before changes, use health checks

## DNS Best Practices

1. Use low TTL (60-300s) for records that change
2. Use high TTL (3600s+) for stable records
3. Implement health checks with DNS
4. Use CNAME for flexibility
5. Document all DNS records
6. Monitor DNS query performance
7. Have DNS backup/disaster recovery plan
