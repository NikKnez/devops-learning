#!/bin/bash
# Demonstrate different HTTP methods

API="https://jsonplaceholder.typicode.com"

echo "HTTP Methods Demo"
echo "==================================="
echo ""

echo "1. GET - Retrieve data:"
curl -s "$API/posts/1" | head -10
echo ""

echo "2. POST - Create data:"
curl -s -X POST "$API/posts" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "DevOps Learning",
    "body": "Understanding HTTP methods",
    "userId": 1
  }' | head -10
echo ""

echo "3. PUT - Update data (full replace):"
curl -s -X PUT "$API/posts/1" \
  -H "Content-Type: application/json" \
  -d '{
    "id": 1,
    "title": "Updated Title",
    "body": "Updated content",
    "userId": 1
  }' | head -10
echo ""

echo "4. PATCH - Partial update:"
curl -s -X PATCH "$API/posts/1" \
  -H "Content-Type: application/json" \
  -d '{
    "title": "Only title updated"
  }' | head -10
echo ""

echo "5. DELETE - Remove data:"
curl -s -X DELETE "$API/posts/1"
echo "Status: $?"
echo ""

echo "6. HEAD - Only headers:"
curl -I "$API/posts/1" | head -15
echo ""

echo "==================================="
