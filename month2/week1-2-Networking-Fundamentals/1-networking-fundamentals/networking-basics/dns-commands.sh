#!/bin/bash
# DNS investigation commands

TARGET=${1:-google.com}

echo "==================================="
echo "DNS Lookup for: $TARGET"
echo "==================================="
echo ""

echo "1. Simple DNS lookup (nslookup):"
nslookup $TARGET
echo ""

echo "2. Detailed DNS info (dig):"
dig $TARGET
echo ""

echo "3. Short answer only:"
dig $TARGET +short
echo ""

echo "4. Query specific record type:"
echo "A record:"
dig $TARGET A +short
echo "MX record:"
dig $TARGET MX +short
echo "NS record:"
dig $TARGET NS +short
echo ""

echo "5. Reverse DNS lookup:"
IP=$(dig $TARGET +short | head -1)
if [ ! -z "$IP" ]; then
    echo "IP: $IP"
    dig -x $IP +short
fi
echo ""

echo "6. Trace DNS path:"
dig $TARGET +trace | head -20
echo ""

echo "==================================="
