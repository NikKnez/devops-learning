# curl Cheat Sheet for DevOps

## Basic Requests
```bash
# GET request
curl https://api.example.com/users

# POST with JSON
curl -X POST https://api.example.com/users \
  -H "Content-Type: application/json" \
  -d '{"name":"John"}'

# PUT (update)
curl -X PUT https://api.example.com/users/1 \
  -H "Content-Type: application/json" \
  -d '{"name":"John Updated"}'

# DELETE
curl -X DELETE https://api.example.com/users/1
```

## Headers
```bash
# Custom header
curl -H "Authorization: Bearer token" https://api.example.com

# Multiple headers
curl -H "Authorization: Bearer token" \
     -H "Content-Type: application/json" \
     https://api.example.com

# View response headers
curl -I https://api.example.com
```

## Authentication
```bash
# Basic auth
curl -u username:password https://api.example.com

# Bearer token
curl -H "Authorization: Bearer token123" https://api.example.com

# API key (query param)
curl "https://api.example.com/data?api_key=key123"

# API key (header)
curl -H "X-API-Key: key123" https://api.example.com
```

## Output Options
```bash
# Save to file
curl -o file.json https://api.example.com/data

# Use remote filename
curl -O https://example.com/file.zip

# Silent mode (no progress)
curl -s https://api.example.com

# Verbose (show details)
curl -v https://api.example.com
```

## Timing and Performance
```bash
# Measure response time
curl -w "Time: %{time_total}s\n" -o /dev/null -s https://example.com

# Detailed timing
curl -w "@curl-format.txt" -o /dev/null -s https://example.com

# Connection timeout
curl --connect-timeout 5 https://api.example.com

# Max time for entire operation
curl --max-time 10 https://api.example.com
```

## Error Handling
```bash
# Fail on HTTP errors
curl -f https://api.example.com

# Retry on failure
curl --retry 3 --retry-delay 2 https://api.example.com

# Get HTTP status code
curl -s -o /dev/null -w "%{http_code}" https://api.example.com
```

## JSON Processing
```bash
# Pretty-print JSON
curl -s https://api.example.com/users | jq '.'

# Extract field
curl -s https://api.example.com/users | jq '.[0].name'

# Filter
curl -s https://api.example.com/users | jq '.[] | select(.age > 25)'
```

## Common Patterns
```bash
# Health check
curl -f -s https://api.example.com/health || echo "Service down"

# API with pagination
curl "https://api.example.com/users?page=2&limit=10"

# Follow redirects
curl -L https://example.com

# Download file with progress
curl -# -O https://example.com/file.zip

# Upload file
curl -X POST https://api.example.com/upload -F "file=@document.pdf"
```

## DevOps Scripts
```bash
# Deployment verification
for endpoint in /health /status /version; do
    curl -f "https://api.example.com$endpoint" || exit 1
done

# API monitoring
while true; do
    curl -f -s https://api.example.com/health > /dev/null
    if [ $? -ne 0 ]; then
        echo "Alert: API down!"
    fi
    sleep 60
done

# Load testing (simple)
for i in {1..100}; do
    curl -s https://api.example.com/test &
done
wait
```
