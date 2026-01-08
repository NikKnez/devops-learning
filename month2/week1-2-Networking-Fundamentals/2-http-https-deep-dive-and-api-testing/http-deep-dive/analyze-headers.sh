#!/bin/bash
# Analyze HTTP headers from a URL

URL=${1:-"https://www.google.com"}

echo "=========================================="
echo "HTTP Header Analysis"
echo "URL: $URL"
echo "=========================================="
echo ""

# Get all headers
echo "Fetching headers..."
headers=$(curl -I -s -L "$URL")

echo "$headers"
echo ""

# Analyze security headers
echo "Security Header Analysis:"
echo "------------------------"

check_header() {
    header=$1
    description=$2
    
    if echo "$headers" | grep -qi "^$header:"; then
        value=$(echo "$headers" | grep -i "^$header:" | cut -d: -f2- | tr -d '\r')
        echo "  [OK] $header:$value"
    else
        echo "  [MISSING] $header - $description"
    fi
}

check_header "Strict-Transport-Security" "Forces HTTPS"
check_header "X-Content-Type-Options" "Prevents MIME sniffing"
check_header "X-Frame-Options" "Prevents clickjacking"
check_header "Content-Security-Policy" "XSS protection"
check_header "X-XSS-Protection" "XSS filter"

echo ""

# Analyze caching headers
echo "Caching Header Analysis:"
echo "-----------------------"
check_header "Cache-Control" "Caching directives"
check_header "ETag" "Version identifier"
check_header "Last-Modified" "Last modification time"
check_header "Expires" "Expiration time"

echo ""

# Check compression
echo "Compression:"
echo "-----------"
check_header "Content-Encoding" "Response compression"

echo ""

# Response info
echo "Response Info:"
echo "-------------"
status=$(echo "$headers" | head -1)
echo "  Status: $status"

check_header "Server" "Server software"
check_header "Content-Type" "Content type"
check_header "Content-Length" "Response size"

echo ""
echo "=========================================="
