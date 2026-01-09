# API Best Practices for DevOps

## 1. Authentication & Security

### Store Credentials Securely
```bash
# BAD: Hardcoded token
curl -H "Authorization: Bearer ghp_hardcoded123" https://api.github.com

# GOOD: Environment variable
export GITHUB_TOKEN="ghp_your_token"
curl -H "Authorization: Bearer $GITHUB_TOKEN" https://api.github.com

# BETTER: Read from secure vault
TOKEN=$(vault kv get -field=token secret/github)
curl -H "Authorization: Bearer $TOKEN" https://api.github.com
```

### Never Log Sensitive Data
```bash
# BAD: Logs full request including token
curl -v -H "Authorization: Bearer token123" https://api.example.com

# GOOD: Sanitize logs
curl -H "Authorization: Bearer $TOKEN" https://api.example.com 2>&1 | \
    sed 's/Bearer .*/Bearer [REDACTED]/'
```

## 2. Error Handling

### Always Check Status Codes
```bash
# BAD: No error checking
result=$(curl -s https://api.example.com/data)

# GOOD: Check exit code
if curl -f -s https://api.example.com/data > result.json; then
    echo "Success"
else
    echo "API call failed"
    exit 1
fi

# BETTER: Check HTTP status
HTTP_CODE=$(curl -s -o result.json -w "%{http_code}" https://api.example.com/data)
if [ "$HTTP_CODE" -eq 200 ]; then
    echo "Success"
elif [ "$HTTP_CODE" -eq 404 ]; then
    echo "Resource not found"
elif [ "$HTTP_CODE" -ge 500 ]; then
    echo "Server error"
    exit 1
fi
```

### Implement Retry Logic
```bash
retry_api_call() {
    local url=$1
    local max_attempts=3
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        if curl -f -s "$url" > result.json; then
            return 0
        fi
        
        echo "Attempt $attempt failed, retrying..."
        sleep $((2 ** attempt))  # Exponential backoff
        ((attempt++))
    done
    
    return 1
}
```

## 3. Rate Limiting

### Respect Rate Limits
```bash
# Check rate limit before making requests
check_rate_limit() {
    remaining=$(curl -s -H "Authorization: Bearer $TOKEN" \
        https://api.github.com/rate_limit | \
        jq -r '.rate.remaining')
    
    if [ "$remaining" -lt 10 ]; then
        echo "Rate limit low: $remaining requests remaining"
        return 1
    fi
    return 0
}

# Use before bulk operations
if check_rate_limit; then
    # Make API calls
else
    echo "Waiting for rate limit reset..."
    sleep 300
fi
```

### Add Delays Between Requests
```bash
# BAD: Rapid fire requests
for user in "${users[@]}"; do
    curl "https://api.example.com/users/$user"
done

# GOOD: Respectful delays
for user in "${users[@]}"; do
    curl "https://api.example.com/users/$user"
    sleep 0.5  # 500ms delay
done
```

## 4. Performance

### Use Caching
```bash
# Cache API responses
cache_file="/tmp/api_cache_$(date +%Y%m%d).json"

if [ -f "$cache_file" ]; then
    # Use cached data
    cat "$cache_file"
else
    # Fetch and cache
    curl -s https://api.example.com/data > "$cache_file"
    cat "$cache_file"
fi
```

### Request Only What You Need
```bash
# BAD: Request all fields
curl "https://api.github.com/repos/kubernetes/kubernetes"

# GOOD: Request specific fields (if API supports)
curl "https://api.example.com/users?fields=id,name,email"

# GOOD: Use pagination
curl "https://api.example.com/users?page=1&per_page=10"
```

### Parallel Requests (When Appropriate)
```bash
# Sequential (slow)
for repo in "${repos[@]}"; do
    curl "https://api.github.com/repos/$repo" > "${repo}.json"
done

# Parallel (fast)
for repo in "${repos[@]}"; do
    curl -s "https://api.github.com/repos/$repo" > "${repo}.json" &
done
wait  # Wait for all background jobs
```

## 5. Monitoring & Logging

### Log API Calls
```bash
log_api_call() {
    local method=$1
    local url=$2
    local timestamp=$(date -Iseconds)
    
    echo "$timestamp|$method|$url|START" >> api.log
    
    response=$(curl -s -w "\n%{http_code}|%{time_total}" -X "$method" "$url")
    http_code=$(echo "$response" | tail -1 | cut -d'|' -f1)
    time=$(echo "$response" | tail -1 | cut -d'|' -f2)
    
    echo "$timestamp|$method|$url|END|$http_code|${time}s" >> api.log
}
```

### Monitor Response Times
```bash
# Alert on slow responses
response_time=$(curl -s -o /dev/null -w "%{time_total}" https://api.example.com)
if (( $(echo "$response_time > 2.0" | bc -l) )); then
    send_alert "API response time slow: ${response_time}s"
fi
```

## 6. Documentation

### Document Your API Calls
```bash
#!/bin/bash
# deploy-verification.sh
#
# Verifies deployment by checking multiple API endpoints
# 
# Environment variables required:
#   - API_TOKEN: Authentication token
#   - API_URL: Base API URL
#
# Exit codes:
#   0: All checks passed
#   1: Health check failed
#   2: Version mismatch
#   3: API error

# Your code here...
```

## 7. Testing

### Test API Calls in Development
```bash
# Use different base URLs
if [ "$ENVIRONMENT" = "production" ]; then
    API_URL="https://api.example.com"
else
    API_URL="https://api-dev.example.com"
fi

# Or use mock servers
if [ "$TESTING" = "true" ]; then
    API_URL="http://localhost:3000/mock"
fi
```

### Validate Responses
```bash
# Check if response is valid JSON
if ! echo "$response" | jq '.' > /dev/null 2>&1; then
    echo "Invalid JSON response"
    exit 1
fi

# Validate required fields
name=$(echo "$response" | jq -r '.name')
if [ "$name" = "null" ] || [ -z "$name" ]; then
    echo "Missing required field: name"
    exit 1
fi
```

## Common Mistakes to Avoid

1. **Hardcoding credentials** - Use environment variables or secrets manager
2. **No error handling** - Always check status codes and handle failures
3. **Ignoring rate limits** - Respect API limits to avoid being blocked
4. **No timeouts** - Set connection and request timeouts
5. **Logging sensitive data** - Sanitize logs before writing
6. **No retry logic** - Implement retries with exponential backoff
7. **Synchronous blocking calls** - Use async/parallel when possible
8. **Not checking response validity** - Validate JSON before parsing
9. **Hardcoded URLs** - Use configuration for flexibility
10. **No monitoring** - Log and monitor API performance
