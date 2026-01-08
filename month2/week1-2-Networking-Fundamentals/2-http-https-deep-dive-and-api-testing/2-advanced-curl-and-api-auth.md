# Advanced curl & API Authentication

## Advanced curl Options Learned

### Request Configuration
- Custom headers (-H)
- Request methods (-X)
- Form data (-d, -F)
- File uploads (-F)
- Cookies (-b, -c)
- Proxy settings (-x)

### Output Control
- Save to file (-o, -O)
- Silent mode (-s)
- Verbose mode (-v, -vv)
- Include headers (-i, -I)
- Custom output format (-w)

### Performance
- Connection timeout (--connect-timeout)
- Max time (--max-time)
- Retry logic (--retry)
- Speed limit (--limit-rate)
- Keep-alive (--keepalive-time)

### SSL/TLS
- Skip verification (-k, --insecure)
- Client certificates (--cert, --key)
- CA certificates (--cacert)
- TLS version (--tlsv1.2, --tlsv1.3)

## Authentication Methods

### 1. Basic Authentication
```bash
curl -u username:password https://api.example.com
```
- Simple but less secure
- Credentials in base64
- Sent with every request

### 2. Bearer Token (JWT)
```bash
curl -H "Authorization: Bearer token" https://api.example.com
```
- Most common for modern APIs
- Token has expiration
- Stateless authentication

### 3. API Keys
```bash
# Header
curl -H "X-API-Key: key" https://api.example.com

# Query parameter
curl "https://api.example.com?api_key=key"
```
- Simple to implement
- No expiration by default
- Less secure than tokens

### 4. OAuth 2.0
```bash
# Get token
TOKEN=$(curl -X POST https://oauth.example.com/token \
  -d "grant_type=client_credentials" \
  -d "client_id=id" \
  -d "client_secret=secret" | jq -r '.access_token')

# Use token
curl -H "Authorization: Bearer $TOKEN" https://api.example.com
```
- Industry standard
- Secure delegation
- Short-lived tokens

### 5. Session Cookies
```bash
# Save cookies
curl -c cookies.txt https://example.com/login \
  -d "username=user&password=pass"

# Use cookies
curl -b cookies.txt https://example.com/dashboard
```
- Stateful authentication
- Server manages sessions
- Common in web applications

## JSON Processing with jq
```bash
# Pretty-print
curl -s https://api.example.com | jq '.'

# Extract field
curl -s https://api.example.com | jq '.name'

# Array operations
curl -s https://api.example.com | jq '.[0]'       # First item
curl -s https://api.example.com | jq '.[].name'    # All names
curl -s https://api.example.com | jq 'length'      # Count

# Filtering
curl -s https://api.example.com | jq '.[] | select(.age > 25)'

# Custom objects
curl -s https://api.example.com | jq '{name, email}'
```

## Real DevOps Applications

### Health Monitoring
```bash
#!/bin/bash
curl -f https://api.example.com/health || alert-team
```

### Deployment Verification
```bash
for endpoint in /health /status /version; do
    curl -f "https://api.example.com$endpoint" || exit 1
done
```

### API Testing
```bash
# Test all endpoints
test_api "GET" "/users" "200"
test_api "POST" "/users" "201"
test_api "DELETE" "/users/1" "204"
```

### Performance Monitoring
```bash
response_time=$(curl -w "%{time_total}" -o /dev/null -s https://api.example.com)
if (( $(echo "$response_time > 2.0" | bc -l) )); then
    echo "Alert: Slow response time"
fi
```

## Scripts Created

1. **curl-examples.sh** - Practical curl demonstrations
2. **api-test-framework.sh** - Simple API testing framework
3. **curl-cheatsheet.md** - Quick reference guide

## Key Takeaways

1. **curl is essential for DevOps**
   - API testing
   - Health checks
   - Deployment verification
   - Troubleshooting

2. **Authentication matters**
   - Choose method based on security needs
   - Store credentials securely (env vars, secrets)
   - Never hardcode tokens in scripts

3. **Error handling is critical**
   - Always check HTTP status codes
   - Implement retry logic
   - Set appropriate timeouts
   - Log failures for debugging

4. **Combine tools for power**
   - curl + jq = JSON parsing
   - curl + bash = automation
   - curl + monitoring = alerting

## Common Patterns

### Health Check Loop
```bash
while true; do
    curl -f -s https://api.example.com/health || alert
    sleep 60
done
```

### Retry with Backoff
```bash
for i in 1 2 3; do
    curl -f https://api.example.com && break
    sleep $((2 ** i))
done
```

### API Test Suite
```bash
TESTS=(
    "GET|/users|200"
    "POST|/users|201"
    "DELETE|/users/1|204"
)
for test in "${TESTS[@]}"; do
# Parse and test
done

## Next: Practice with Real Public APIs
