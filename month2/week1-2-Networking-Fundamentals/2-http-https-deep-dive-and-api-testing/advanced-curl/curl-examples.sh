#!/bin/bash
# Practical curl examples for DevOps

echo "=========================================="
echo "Advanced curl Examples"
echo "=========================================="
echo ""

# Example 1: GitHub API with pagination
echo "EXAMPLE 1: GitHub API - Repository Search"
echo "-----------------------------------------"
echo "Searching for 'devops' repositories..."
curl -s "https://api.github.com/search/repositories?q=devops&sort=stars&order=desc&per_page=3" | \
    jq '.items[] | {name: .name, stars: .stargazers_count, url: .html_url}'
echo ""
read -p "Press Enter to continue..."
echo ""

# Example 2: API with authentication
echo "EXAMPLE 2: JSONPlaceholder - Create Post"
echo "----------------------------------------"
response=$(curl -s -X POST https://jsonplaceholder.typicode.com/posts \
    -H "Content-Type: application/json" \
    -d '{
        "title": "DevOps Best Practices",
        "body": "Understanding curl for API testing",
        "userId": 1
    }')
echo "Created post:"
echo "$response" | jq '{id, title}'
echo ""
read -p "Press Enter to continue..."
echo ""

# Example 3: Error handling
echo "EXAMPLE 3: Error Handling"
echo "-------------------------"
echo "Testing 404 response:"
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" https://jsonplaceholder.typicode.com/posts/999)
if [ "$HTTP_CODE" -eq 404 ]; then
    echo "  Resource not found (expected)"
else
    echo "  Unexpected response: $HTTP_CODE"
fi
echo ""
read -p "Press Enter to continue..."
echo ""

# Example 4: Performance testing
echo "EXAMPLE 4: Response Time Measurement"
echo "------------------------------------"
endpoints=(
    "https://api.github.com"
    "https://jsonplaceholder.typicode.com/posts"
    "https://httpbin.org/get"
)

for endpoint in "${endpoints[@]}"; do
    time=$(curl -s -o /dev/null -w "%{time_total}" "$endpoint")
    echo "  $endpoint: ${time}s"
done
echo ""
read -p "Press Enter to continue..."
echo ""

# Example 5: Following redirects
echo "EXAMPLE 5: HTTP Redirects"
echo "-------------------------"
echo "Following redirect chain for http://github.com:"
curl -I -s -L http://github.com | grep -E "HTTP|Location" | head -6
echo ""
read -p "Press Enter to continue..."
echo ""

# Example 6: Headers analysis
echo "EXAMPLE 6: Security Headers Check"
echo "---------------------------------"
url="https://github.com"
echo "Checking security headers for $url:"
headers=$(curl -I -s "$url")

check_header() {
    header=$1
    if echo "$headers" | grep -qi "^$header:"; then
        echo "  [✓] $header present"
    else
        echo "  [✗] $header missing"
    fi
}

check_header "Strict-Transport-Security"
check_header "X-Content-Type-Options"
check_header "X-Frame-Options"
check_header "Content-Security-Policy"
echo ""

echo "=========================================="
echo "Examples Complete!"
echo "=========================================="
