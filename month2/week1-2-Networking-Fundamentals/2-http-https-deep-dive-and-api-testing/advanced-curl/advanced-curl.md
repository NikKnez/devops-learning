# Advanced curl Techniques & API Authentication

## curl Basics Review
```bash
# Simple GET
curl https://api.example.com/users

# Save output to file
curl -o users.json https://api.example.com/users
curl -O https://example.com/file.zip  # Use remote filename

# Silent mode (no progress bar)
curl -s https://api.example.com/users

# Show only HTTP status code
curl -s -o /dev/null -w "%{http_code}" https://example.com

# Follow redirects
curl -L https://example.com

# Set max redirects
curl -L --max-redirs 3 https://example.com
```

## Advanced curl Options

### Custom Headers
```bash
# Single header
curl -H "Authorization: Bearer token123" https://api.example.com

# Multiple headers
curl -H "Authorization: Bearer token123" \
     -H "Content-Type: application/json" \
     -H "Accept: application/json" \
     -H "User-Agent: MyApp/1.0" \
     https://api.example.com

# Remove default headers
curl -H "User-Agent:" https://example.com  # Empty User-Agent
```

### Request Methods
```bash
# GET (default)
curl https://api.example.com/users

# POST with data
curl -X POST https://api.example.com/users \
     -H "Content-Type: application/json" \
     -d '{"name":"John","email":"john@example.com"}'

# POST with data from file
curl -X POST https://api.example.com/users \
     -H "Content-Type: application/json" \
     -d @user.json

# PUT (update)
curl -X PUT https://api.example.com/users/123 \
     -H "Content-Type: application/json" \
     -d '{"name":"John Updated"}'

# PATCH (partial update)
curl -X PATCH https://api.example.com/users/123 \
     -H "Content-Type: application/json" \
     -d '{"email":"newemail@example.com"}'

# DELETE
curl -X DELETE https://api.example.com/users/123
```

### Form Data
```bash
# URL-encoded form (default)
curl -X POST https://api.example.com/form \
     -d "name=John" \
     -d "email=john@example.com" \
     -d "age=30"

# Or all at once
curl -X POST https://api.example.com/form \
     -d "name=John&email=john@example.com&age=30"

# Multipart form (file upload)
curl -X POST https://api.example.com/upload \
     -F "file=@document.pdf" \
     -F "description=My document"

# Multiple files
curl -X POST https://api.example.com/upload \
     -F "file1=@image1.jpg" \
     -F "file2=@image2.jpg" \
     -F "album=vacation"
```

### Verbose and Debug Options
```bash
# Verbose (show request and response headers)
curl -v https://api.example.com

# Very verbose (show SSL handshake)
curl -vv https://api.example.com

# Show only response headers
curl -I https://api.example.com
curl --head https://api.example.com

# Include response headers in output
curl -i https://api.example.com

# Dump headers to file
curl -D headers.txt https://api.example.com
```

### Timing and Performance
```bash
# Measure total time
curl -w "Time: %{time_total}s\n" -o /dev/null -s https://example.com

# Detailed timing breakdown
curl -w "DNS: %{time_namelookup}s\nConnect: %{time_connect}s\nTransfer: %{time_starttransfer}s\nTotal: %{time_total}s\n" \
     -o /dev/null -s https://example.com

# All timing info
curl -w "@curl-format.txt" -o /dev/null -s https://example.com
```

**Create curl-format.txt:**
```bash
cat > curl-format.txt << 'FORMAT'
    time_namelookup:  %{time_namelookup}s\n
       time_connect:  %{time_connect}s\n
    time_appconnect:  %{time_appconnect}s\n
   time_pretransfer:  %{time_pretransfer}s\n
      time_redirect:  %{time_redirect}s\n
 time_starttransfer:  %{time_starttransfer}s\n
                    ----------\n
         time_total:  %{time_total}s\n
       size_download:  %{size_download} bytes\n
         size_upload:  %{size_upload} bytes\n
      speed_download:  %{speed_download} bytes/sec\n
        speed_upload:  %{speed_upload} bytes/sec\n
         http_code:  %{http_code}\n
FORMAT
```

### Connection Options
```bash
# Timeout (connection)
curl --connect-timeout 5 https://example.com

# Timeout (total operation)
curl --max-time 10 https://example.com

# Retry on failure
curl --retry 3 https://example.com

# Retry delay
curl --retry 3 --retry-delay 2 https://example.com

# Keep-alive (reuse connection)
curl --keepalive-time 60 https://example.com

# HTTP version
curl --http1.1 https://example.com
curl --http2 https://example.com
```

## Authentication Methods

### 1. Basic Authentication

**Format:** username:password encoded in base64
```bash
# Method 1: Using -u flag (recommended)
curl -u username:password https://api.example.com

# Method 2: Manual Authorization header
curl -H "Authorization: Basic $(echo -n 'username:password' | base64)" \
     https://api.example.com

# With username only (prompt for password)
curl -u username https://api.example.com
```

**Example:**
```bash
# GitHub API with basic auth (deprecated, use token)
curl -u yourusername:yourtoken https://api.github.com/user
```

### 2. Bearer Token (Most Common)

**Format:** Token in Authorization header
```bash
# Standard bearer token
curl -H "Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9..." \
     https://api.example.com/protected

# Store token in variable
TOKEN="your-token-here"
curl -H "Authorization: Bearer $TOKEN" \
     https://api.example.com/protected
```

**Example with GitHub:**
```bash
# GitHub Personal Access Token
GITHUB_TOKEN="ghp_xxxxxxxxxxxx"
curl -H "Authorization: Bearer $GITHUB_TOKEN" \
     https://api.github.com/user
```

### 3. API Keys

**Common patterns:**
```bash
# Query parameter
curl "https://api.example.com/data?api_key=your-key-here"

# Custom header
curl -H "X-API-Key: your-key-here" https://api.example.com/data

# Different header names
curl -H "X-Auth-Token: your-key-here" https://api.example.com/data
curl -H "apikey: your-key-here" https://api.example.com/data
```

**Example with OpenWeatherMap:**
```bash
API_KEY="your-api-key"
curl "https://api.openweathermap.org/data/2.5/weather?q=Belgrade&appid=$API_KEY"
```

### 4. OAuth 2.0

**Two-step process:**
```bash
# Step 1: Get access token
response=$(curl -X POST https://oauth.example.com/token \
     -H "Content-Type: application/x-www-form-urlencoded" \
     -d "grant_type=client_credentials" \
     -d "client_id=your-client-id" \
     -d "client_secret=your-client-secret")

# Extract token (using jq)
TOKEN=$(echo $response | jq -r '.access_token')

# Step 2: Use access token
curl -H "Authorization: Bearer $TOKEN" \
     https://api.example.com/protected
```

### 5. Session Cookies

**Automatic cookie handling:**
```bash
# Save cookies
curl -c cookies.txt https://example.com/login \
     -d "username=user&password=pass"

# Use saved cookies
curl -b cookies.txt https://example.com/dashboard

# Both save and send cookies
curl -b cookies.txt -c cookies.txt https://example.com/page
```

**Manual cookie:**
```bash
curl -H "Cookie: session=abc123; user_id=456" https://example.com
```

### 6. AWS Signature V4 (Advanced)

AWS requires signed requests:
```bash
# Use aws-cli for AWS API calls
aws s3 ls s3://bucket-name

# Or use curl with pre-signed URLs
curl "https://s3.amazonaws.com/bucket/file?X-Amz-Algorithm=..."
```

## Working with JSON

### Sending JSON Data
```bash
# Inline JSON
curl -X POST https://api.example.com/users \
     -H "Content-Type: application/json" \
     -d '{"name":"John","email":"john@example.com","age":30}'

# JSON from file
curl -X POST https://api.example.com/users \
     -H "Content-Type: application/json" \
     -d @user.json

# Pretty-print with jq
curl -s https://api.example.com/users | jq '.'

# Extract specific field
curl -s https://api.example.com/users | jq '.[0].name'

# Filter results
curl -s https://api.example.com/users | jq '.[] | select(.age > 25)'
```

### Common jq Operations
```bash
# Get first element
curl -s https://api.example.com/users | jq '.[0]'

# Get specific field from all items
curl -s https://api.example.com/users | jq '.[].name'

# Count items
curl -s https://api.example.com/users | jq 'length'

# Create custom object
curl -s https://api.example.com/users | jq '{name: .[0].name, email: .[0].email}'

# Array of specific fields
curl -s https://api.example.com/users | jq '[.[] | {name, email}]'
```

## Error Handling
```bash
# Fail on HTTP errors (4xx, 5xx)
curl -f https://api.example.com || echo "Request failed"

# Show error message for HTTP errors
curl -f -s https://api.example.com/notfound || echo "Error: Resource not found"

# Capture HTTP status code
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://api.example.com)
if [ "$HTTP_CODE" -eq 200 ]; then
    echo "Success"
else
    echo "Error: HTTP $HTTP_CODE"
fi

# Retry with exponential backoff
for i in 1 2 3; do
    if curl -f -s https://api.example.com; then
        break
    else
        echo "Attempt $i failed, retrying..."
        sleep $((2 ** i))
    fi
done
```

## Proxy and Tunneling
```bash
# Use HTTP proxy
curl -x http://proxy.example.com:8080 https://api.example.com

# Proxy with authentication
curl -x http://proxy.example.com:8080 \
     -U proxyuser:proxypass \
     https://api.example.com

# Use SOCKS proxy
curl -x socks5://127.0.0.1:1080 https://api.example.com

# Skip proxy for specific host
curl --noproxy "localhost,127.0.0.1" https://api.example.com
```

## SSL/TLS Options
```bash
# Ignore SSL certificate verification (INSECURE - only for testing!)
curl -k https://self-signed.example.com
curl --insecure https://self-signed.example.com

# Use specific SSL/TLS version
curl --tlsv1.2 https://example.com
curl --tlsv1.3 https://example.com

# Show SSL certificate info
curl -v https://example.com 2>&1 | grep -A 10 "SSL certificate"

# Use client certificate
curl --cert client.crt --key client.key https://api.example.com

# Specify CA certificate
curl --cacert ca.crt https://api.example.com
```

## Downloading Files
```bash
# Download and save with remote filename
curl -O https://example.com/file.zip

# Download with custom filename
curl -o myfile.zip https://example.com/file.zip

# Resume interrupted download
curl -C - -O https://example.com/largefile.zip

# Download multiple files
curl -O https://example.com/file1.zip \
     -O https://example.com/file2.zip

# Download with progress bar
curl -# -O https://example.com/file.zip

# Parallel downloads (with xargs)
cat urls.txt | xargs -n 1 -P 4 curl -O
```

## Rate Limiting and Throttling
```bash
# Limit download speed (100KB/s)
curl --limit-rate 100K https://example.com/file.zip

# Add delay between requests (in script)
for url in "${urls[@]}"; do
    curl "$url"
    sleep 1
done
```

## DevOps Use Cases

### Health Check Script
```bash
#!/bin/bash
# health-check.sh

ENDPOINT="https://api.example.com/health"
MAX_RESPONSE_TIME=2

response_time=$(curl -s -o /dev/null -w "%{time_total}" "$ENDPOINT")
http_code=$(curl -s -o /dev/null -w "%{http_code}" "$ENDPOINT")

if [ "$http_code" -eq 200 ] && [ $(echo "$response_time < $MAX_RESPONSE_TIME" | bc) -eq 1 ]; then
    echo "✓ Health check passed (${response_time}s)"
    exit 0
else
    echo "✗ Health check failed (HTTP: $http_code, Time: ${response_time}s)"
    exit 1
fi
```

### API Monitoring Script
```bash
#!/bin/bash
# api-monitor.sh

ENDPOINTS=(
    "https://api.example.com/health"
    "https://api.example.com/status"
    "https://api.example.com/version"
)

for endpoint in "${ENDPOINTS[@]}"; do
    response=$(curl -s -o /dev/null -w "%{http_code}|%{time_total}" "$endpoint")
    http_code=$(echo $response | cut -d'|' -f1)
    time=$(echo $response | cut -d'|' -f2)
    
    if [ "$http_code" -eq 200 ]; then
        echo "[OK] $endpoint - ${time}s"
    else
        echo "[FAIL] $endpoint - HTTP $http_code"
        # Send alert here
    fi
done
```

### Deployment Verification
```bash
#!/bin/bash
# verify-deployment.sh

API="https://api.example.com"
TOKEN="your-token"

# Check version
version=$(curl -s -H "Authorization: Bearer $TOKEN" "$API/version" | jq -r '.version')
echo "Deployed version: $version"

# Run smoke tests
tests=(
    "GET|/health|200"
    "GET|/users|200"
    "POST|/auth/login|401"  # Should fail without credentials
)

for test in "${tests[@]}"; do
    method=$(echo $test | cut -d'|' -f1)
    path=$(echo $test | cut -d'|' -f2)
    expected=$(echo $test | cut -d'|' -f3)
    
    actual=$(curl -s -o /dev/null -w "%{http_code}" -X "$method" "$API$path")
    
    if [ "$actual" -eq "$expected" ]; then
        echo "✓ $method $path: $actual"
    else
        echo "✗ $method $path: expected $expected, got $actual"
        exit 1
    fi
done

echo "Deployment verification complete!"
```
