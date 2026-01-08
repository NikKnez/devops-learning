#!/bin/bash
# Comprehensive HTTP testing suite

API="https://jsonplaceholder.typicode.com"

echo "=========================================="
echo "HTTP Protocol Testing Suite"
echo "=========================================="
echo ""

# Test 1: GET Request
echo "TEST 1: GET Request"
echo "-------------------"
echo "Fetching user data..."
curl -s "$API/users/1" | head -20
echo ""
read -p "Press Enter to continue..."
echo ""

# Test 2: POST Request
echo "TEST 2: POST Request"
echo "-------------------"
echo "Creating new post..."
response=$(curl -s -X POST "$API/posts" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "DevOps Learning",
    "body": "Understanding HTTP methods",
    "userId": 1
  }')
echo "$response" | head -10
echo ""
read -p "Press Enter to continue..."
echo ""

# Test 3: View Headers
echo "TEST 3: Response Headers"
echo "------------------------"
echo "Viewing response headers..."
curl -I -s "$API/users/1"
echo ""
read -p "Press Enter to continue..."
echo ""

# Test 4: Custom Headers
echo "TEST 4: Custom Request Headers"
echo "------------------------------"
echo "Sending custom headers..."
curl -s "$API/users/1" \
  -H "User-Agent: DevOps-Testing-Bot/1.0" \
  -H "X-Custom-Header: TestValue" \
  -v 2>&1 | grep -E "User-Agent|X-Custom-Header"
echo ""
read -p "Press Enter to continue..."
echo ""

# Test 5: Query Parameters
echo "TEST 5: Query Parameters"
echo "------------------------"
echo "Filtering with query params..."
curl -s "$API/posts?userId=1&_limit=3" | head -30
echo ""
read -p "Press Enter to continue..."
echo ""

# Test 6: Status Codes
echo "TEST 6: HTTP Status Codes"
echo "------------------------"
urls=(
    "$API/users/1:200 OK"
    "$API/users/999:404 Not Found"
    "https://httpstat.us/500:500 Server Error"
)

for url_desc in "${urls[@]}"; do
    url="${url_desc%%:*}"
    desc="${url_desc##*:}"
    status=$(curl -s -o /dev/null -w "%{http_code}" "$url")
    echo "  [$status] $desc"
done
echo ""
read -p "Press Enter to continue..."
echo ""

# Test 7: Response Time
echo "TEST 7: Response Time Measurement"
echo "---------------------------------"
targets=("$API/users" "$API/posts" "$API/comments")
for target in "${targets[@]}"; do
    time=$(curl -s -o /dev/null -w "%{time_total}" "$target")
    echo "  $target: ${time}s"
done
echo ""
read -p "Press Enter to continue..."
echo ""

# Test 8: Following Redirects
echo "TEST 8: HTTP Redirects"
echo "---------------------"
echo "Testing redirect handling..."
curl -I -s -L http://github.com | grep -E "HTTP|Location" | head -10
echo ""

echo "=========================================="
echo "HTTP Testing Complete!"
echo "=========================================="
