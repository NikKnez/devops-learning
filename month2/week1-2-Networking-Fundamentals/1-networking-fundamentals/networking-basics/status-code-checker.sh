#!/bin/bash
# Check HTTP status codes for various scenarios

echo "HTTP Status Code Examples"
echo "==================================="
echo ""

urls=(
    "https://httpstat.us/200:200 OK - Success"
    "https://httpstat.us/301:301 Moved Permanently"
    "https://httpstat.us/400:400 Bad Request"
    "https://httpstat.us/401:401 Unauthorized"
    "https://httpstat.us/403:403 Forbidden"
    "https://httpstat.us/404:404 Not Found"
    "https://httpstat.us/500:500 Internal Server Error"
    "https://httpstat.us/502:502 Bad Gateway"
    "https://httpstat.us/503:503 Service Unavailable"
)

for url_info in "${urls[@]}"; do
    url="${url_info%%:*}"
    description="${url_info##*:}"
    
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    time=$(curl -s -o /dev/null -w "%{time_total}" "$url")
    
    echo "[$status] $description (${time}s)"
done

echo ""
echo "==================================="
