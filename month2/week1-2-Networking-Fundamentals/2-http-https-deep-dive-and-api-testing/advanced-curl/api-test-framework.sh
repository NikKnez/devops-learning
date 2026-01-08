#!/bin/bash
# Simple API testing framework

API_BASE="https://jsonplaceholder.typicode.com"
PASSED=0
FAILED=0

# Test function
test_api() {
    local name=$1
    local method=$2
    local endpoint=$3
    local expected_code=$4
    local data=$5
    
    echo -n "Testing: $name... "
    
    if [ -z "$data" ]; then
        actual_code=$(curl -s -o /dev/null -w "%{http_code}" -X "$method" "$API_BASE$endpoint")
    else
        actual_code=$(curl -s -o /dev/null -w "%{http_code}" \
            -X "$method" "$API_BASE$endpoint" \
            -H "Content-Type: application/json" \
            -d "$data")
    fi
    
    if [ "$actual_code" -eq "$expected_code" ]; then
        echo "✓ PASS (HTTP $actual_code)"
        ((PASSED++))
    else
        echo "✗ FAIL (Expected: $expected_code, Got: $actual_code)"
        ((FAILED++))
    fi
}

echo "=========================================="
echo "API Test Suite"
echo "=========================================="
echo ""

# Run tests
test_api "Get all posts" "GET" "/posts" "200"
test_api "Get single post" "GET" "/posts/1" "200"
test_api "Post not found" "GET" "/posts/999" "404"
test_api "Create post" "POST" "/posts" "201" '{"title":"Test","body":"Test body","userId":1}'
test_api "Update post" "PUT" "/posts/1" "200" '{"id":1,"title":"Updated","body":"Updated body","userId":1}'
test_api "Delete post" "DELETE" "/posts/1" "200"

echo ""
echo "=========================================="
echo "Results: $PASSED passed, $FAILED failed"
echo "=========================================="

if [ $FAILED -eq 0 ]; then
    exit 0
else
    exit 1
fi
