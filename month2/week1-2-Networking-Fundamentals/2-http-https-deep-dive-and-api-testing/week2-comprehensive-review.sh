#!/bin/bash
# Week 2 Comprehensive Review

echo "=========================================="
echo "Week 2 Review - HTTP/HTTPS & APIs"
echo "=========================================="
echo ""

# Exercise 1: HTTP Methods
echo "EXERCISE 1: HTTP Methods Review"
echo "-------------------------------"
API="https://jsonplaceholder.typicode.com"

echo "Testing CRUD operations..."
echo ""

echo "1. CREATE (POST):"
create_response=$(curl -s -X POST "$API/posts" \
    -H "Content-Type: application/json" \
    -d '{"title":"Week 2 Review","body":"Testing POST","userId":1}')
echo "$create_response" | jq '{id, title}'
echo ""

echo "2. READ (GET):"
curl -s "$API/posts/1" | jq '{id, title, userId}'
echo ""

echo "3. UPDATE (PUT):"
curl -s -X PUT "$API/posts/1" \
    -H "Content-Type: application/json" \
    -d '{"id":1,"title":"Updated","body":"Updated body","userId":1}' | jq '{id, title}'
echo ""

echo "4. DELETE:"
delete_code=$(curl -s -o /dev/null -w "%{http_code}" -X DELETE "$API/posts/1")
echo "Delete response code: $delete_code"
echo ""

read -p "Press Enter to continue..."
echo ""

# Exercise 2: Status Codes
echo "EXERCISE 2: Status Code Handling"
echo "--------------------------------"
test_codes=(
    "200:OK"
    "404:Not Found"
    "500:Server Error"
)

for test in "${test_codes[@]}"; do
    code="${test%%:*}"
    desc="${test##*:}"
    
    actual=$(curl -s -o /dev/null -w "%{http_code}" "https://httpstat.us/$code")
    echo "  Expected: $code ($desc), Got: $actual"
done
echo ""

read -p "Press Enter to continue..."
echo ""

# Exercise 3: Authentication
echo "EXERCISE 3: Authentication Methods"
echo "----------------------------------"

echo "1. No Authentication (Public API):"
curl -s "https://catfact.ninja/fact" | jq -r '.fact' | head -c 70
echo "..."
echo ""

echo "2. API Key in Query Parameter:"
echo "   Example: curl 'https://api.example.com?api_key=KEY'"
echo ""

echo "3. Bearer Token in Header:"
echo "   Example: curl -H 'Authorization: Bearer TOKEN' URL"
echo ""

read -p "Press Enter to continue..."
echo ""

# Exercise 4: Error Handling
echo "EXERCISE 4: Error Handling"
echo "-------------------------"

test_error_handling() {
    local url=$1
    local expected=$2
    
    if curl -f -s "$url" > /dev/null 2>&1; then
        echo "  ✓ Success (expected: $expected)"
        return 0
    else
        code=$(curl -s -o /dev/null -w "%{http_code}" "$url")
        echo "  ✗ Failed with HTTP $code (expected: $expected)"
        return 1
    fi
}

echo "Testing error scenarios:"
test_error_handling "https://jsonplaceholder.typicode.com/posts/1" "200"
test_error_handling "https://jsonplaceholder.typicode.com/posts/999" "404"
echo ""

read -p "Press Enter to continue..."
echo ""

# Exercise 5: Response Time
echo "EXERCISE 5: Response Time Measurement"
echo "-------------------------------------"
endpoints=(
    "https://api.github.com"
    "https://jsonplaceholder.typicode.com/posts"
    "https://catfact.ninja/fact"
)

echo "Measuring response times:"
for endpoint in "${endpoints[@]}"; do
    time=$(curl -s -o /dev/null -w "%{time_total}" "$endpoint")
    printf "  %-50s %6.3fs\n" "$endpoint" "$time"
done
echo ""

read -p "Press Enter to continue..."
echo ""

# Exercise 6: JSON Processing
echo "EXERCISE 6: JSON Processing with jq"
echo "-----------------------------------"
echo "Fetching and processing JSON data..."

data=$(curl -s "https://jsonplaceholder.typicode.com/users")

echo "1. Count users:"
echo "$data" | jq 'length'
echo ""

echo "2. Extract names only:"
echo "$data" | jq -r '.[0:3][].name'
echo ""

echo "3. Filter by condition:"
echo "$data" | jq '[.[] | select(.id <= 3) | {id, name, email}]'
echo ""

read -p "Press Enter to continue..."
echo ""

# Exercise 7: Headers
echo "EXERCISE 7: HTTP Headers Analysis"
echo "---------------------------------"
echo "Analyzing headers from api.github.com..."

headers=$(curl -I -s https://api.github.com)

echo "Security headers present:"
for header in "Strict-Transport-Security" "X-Content-Type-Options" "X-Frame-Options"; do
    if echo "$headers" | grep -qi "^$header:"; then
        echo "  ✓ $header"
    else
        echo "  ✗ $header (missing)"
    fi
done
echo ""

echo "Rate limit headers:"
echo "$headers" | grep -i "x-ratelimit" | head -3
echo ""

echo "=========================================="
echo "Week 2 Review Complete!"
echo "=========================================="
echo ""
echo "Skills Mastered:"
echo "  - HTTP protocol fundamentals"
echo "  - curl advanced usage"
echo "  - API authentication methods"
echo "  - Error handling patterns"
echo "  - JSON data processing"
echo "  - Response time measurement"
echo "=========================================="
