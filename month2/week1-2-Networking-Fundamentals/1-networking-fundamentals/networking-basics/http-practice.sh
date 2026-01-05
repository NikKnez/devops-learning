#!/bin/bash
# HTTP request practice with curl

TARGET=${1:-https://api.github.com}

echo "==================================="
echo "HTTP Request Analysis: $TARGET"
echo "==================================="
echo ""

echo "1. Simple GET request:"
curl -s $TARGET | head -20
echo ""

echo "2. Show only HTTP headers (-I):"
curl -I $TARGET
echo ""

echo "3. Verbose output (-v):"
curl -v $TARGET 2>&1 | head -30
echo ""

echo "4. Save response headers:"
curl -D headers.txt -s -o response.txt $TARGET
echo "Headers saved to: headers.txt"
echo "Response saved to: response.txt"
cat headers.txt
echo ""

echo "5. Follow redirects (-L):"
curl -sI -L http://github.com | grep -E "HTTP|Location"
echo ""

echo "6. Custom headers:"
curl -H "User-Agent: DevOps-Learning-Bot" \
     -H "Accept: application/json" \
     -s $TARGET | head -10
echo ""

echo "7. Measure response time:"
curl -w "\nTime: %{time_total}s\nHTTP Code: %{http_code}\n" \
     -s -o /dev/null $TARGET
echo ""

echo "==================================="
