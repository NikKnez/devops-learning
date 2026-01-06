# Ports, Protocols, and HTTP


## Concepts Learned

### Ports
- Port ranges (0-1023, 1024-49151, 49152-65535)
- Common ports (22, 80, 443, 3306, 5432, etc.)
- DevOps tool ports (9090, 3000, 8080)
- Port conflicts and resolution

### Protocols
- TCP: Connection-oriented, reliable
- UDP: Connectionless, fast
- ICMP: Diagnostics (ping)

### HTTP/HTTPS
- HTTP methods (GET, POST, PUT, PATCH, DELETE)
- Status codes (2xx, 3xx, 4xx, 5xx)
- Headers (request and response)
- TLS/SSL encryption

### Commands Mastered
- ss -tuln (listening ports)
- lsof -i :PORT (process on port)
- curl (HTTP requests)
- curl -I (headers only)
- curl -v (verbose)

## DevOps Applications

### Security Groups
- Configure inbound/outbound rules
- Specify ports and protocols
- Restrict source IPs

### Service Deployment
- Map container ports to host
- Configure load balancer ports
- Internal vs external ports

### Troubleshooting
- Check port availability
- Test HTTP endpoints
- Analyze response codes
- Debug connection issues

## Practice Completed
- Port scanning scripts
- HTTP method demonstrations
- Status code testing
- Real-world scenarios
- Troubleshooting workflows

## Key Takeaways

1. Always specify both IP and port
2. Use HTTPS (443) for production
3. Keep databases on private ports
4. Document port assignments
5. Test connectivity at each layer
6. Monitor unexpected open ports

## Next: Network Troubleshooting Tools

