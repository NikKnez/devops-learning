# Ports and Protocols


## What are Ports?

Ports are like apartment numbers for network traffic:
- IP Address = Building address
- Port = Apartment number

Format: IP:PORT
Example: 192.168.1.100:80

## Port Ranges

### Well-Known Ports (0-1023)
System/privileged services
- Require root/admin to bind

### Registered Ports (1024-49151)
User applications
- Database servers, custom apps

### Dynamic/Private Ports (49152-65535)
Temporary/ephemeral ports
- Used by clients for outbound connections

## Common Ports (Must Know for DevOps)

### Web Traffic
- 80: HTTP (web traffic, unencrypted)
- 443: HTTPS (encrypted web traffic)
- 8080: Alternative HTTP (often used in development)
- 8443: Alternative HTTPS

### Remote Access
- 22: SSH (secure shell, remote server access)
- 3389: RDP (Remote Desktop Protocol - Windows)
- 5900: VNC (Virtual Network Computing)

### File Transfer
- 21: FTP (File Transfer Protocol)
- 22: SFTP (SSH File Transfer)
- 20: FTP Data Transfer

### Email
- 25: SMTP (sending email)
- 110: POP3 (receiving email)
- 143: IMAP (receiving email)
- 465: SMTPS (SMTP with SSL)
- 587: SMTP (with STARTTLS)
- 993: IMAPS (IMAP with SSL)

### Databases
- 3306: MySQL/MariaDB
- 5432: PostgreSQL
- 27017: MongoDB
- 6379: Redis
- 1521: Oracle

### DevOps Tools
- 9090: Prometheus
- 3000: Grafana
- 8080: Jenkins
- 5000: Flask (default)
- 3001: React dev server (often)
- 4000: Node.js apps (common)

### Container/Orchestration
- 2375: Docker (unencrypted)
- 2376: Docker (TLS)
- 6443: Kubernetes API server
- 10250: Kubelet
- 2379-2380: etcd

### DNS
- 53: DNS (both TCP and UDP)

### Other Important
- 123: NTP (Network Time Protocol)
- 161/162: SNMP (monitoring)
- 514: Syslog

## Protocols

### TCP (Transmission Control Protocol)
- Connection-oriented
- Reliable delivery
- Order guaranteed
- Used for: HTTP, SSH, FTP, databases

Characteristics:
- 3-way handshake (SYN, SYN-ACK, ACK)
- Error checking
- Slower than UDP

### UDP (User Datagram Protocol)
- Connectionless
- No delivery guarantee
- No order guarantee
- Used for: DNS, streaming, gaming, VoIP

Characteristics:
- Fast
- Low overhead
- "Fire and forget"

### ICMP (Internet Control Message Protocol)
- Network diagnostics
- Used by: ping, traceroute
- Error reporting

## HTTP Fundamentals

### HTTP Request Methods

**GET**: Retrieve data
- Used for: Loading web pages, APIs
- Safe: Yes
- Idempotent: Yes
- Example: GET /api/users

**POST**: Submit data
- Used for: Creating resources, forms
- Safe: No
- Idempotent: No
- Example: POST /api/users (create user)

**PUT**: Update/replace resource
- Used for: Full updates
- Safe: No
- Idempotent: Yes
- Example: PUT /api/users/123 (update user)

**PATCH**: Partial update
- Used for: Partial modifications
- Safe: No
- Idempotent: No
- Example: PATCH /api/users/123 (update one field)

**DELETE**: Remove resource
- Used for: Deleting data
- Safe: No
- Idempotent: Yes
- Example: DELETE /api/users/123

**HEAD**: Like GET but only headers
- Used for: Checking if resource exists
- Safe: Yes
- Idempotent: Yes

**OPTIONS**: Get allowed methods
- Used for: CORS preflight
- Safe: Yes
- Idempotent: Yes

### HTTP Status Codes

**1xx: Informational**
- 100: Continue
- 101: Switching Protocols

**2xx: Success**
- 200: OK
- 201: Created
- 202: Accepted
- 204: No Content

**3xx: Redirection**
- 301: Moved Permanently
- 302: Found (temporary redirect)
- 304: Not Modified (cached)
- 307: Temporary Redirect
- 308: Permanent Redirect

**4xx: Client Errors**
- 400: Bad Request
- 401: Unauthorized (not authenticated)
- 403: Forbidden (authenticated but no permission)
- 404: Not Found
- 405: Method Not Allowed
- 408: Request Timeout
- 409: Conflict
- 429: Too Many Requests

**5xx: Server Errors**
- 500: Internal Server Error
- 501: Not Implemented
- 502: Bad Gateway
- 503: Service Unavailable
- 504: Gateway Timeout

### HTTP Headers

**Request Headers**
- Host: example.com
- User-Agent: Browser/client info
- Accept: Content types client accepts
- Authorization: Authentication credentials
- Content-Type: Body data type
- Cookie: Session cookies

**Response Headers**
- Content-Type: Response data type
- Content-Length: Response size
- Set-Cookie: Set cookies
- Cache-Control: Caching directives
- Location: Redirect URL
- Server: Server software info

**Security Headers**
- Strict-Transport-Security: Force HTTPS
- X-Frame-Options: Prevent clickjacking
- X-Content-Type-Options: Prevent MIME sniffing
- Content-Security-Policy: XSS protection

## HTTPS (HTTP Secure)

HTTP + TLS/SSL encryption

### How HTTPS Works
1. Client connects to server on port 443
2. Server sends SSL certificate
3. Client verifies certificate
4. Encrypted connection established
5. Data transmitted securely

### TLS/SSL Certificates
- Issued by Certificate Authorities (CA)
- Contains: domain name, public key, expiration
- Let's Encrypt: Free SSL certificates

## DevOps Port Configuration Examples

### AWS Security Group
```
Inbound Rules:
- Type: HTTP, Port: 80, Source: 0.0.0.0/0
- Type: HTTPS, Port: 443, Source: 0.0.0.0/0
- Type: SSH, Port: 22, Source: My IP
- Type: Custom TCP, Port: 5432, Source: VPC CIDR

Outbound Rules:
- All traffic: 0.0.0.0/0
```

### Docker Port Mapping
```bash
docker run -p 8080:80 nginx  # Host:Container
# Access nginx on localhost:8080
```

### Kubernetes Service
```yaml
apiVersion: v1
kind: Service
metadata:
  name: web-service
spec:
  type: LoadBalancer
  ports:
    - port: 80        # External port
      targetPort: 8080 # Container port
  selector:
    app: web
```
