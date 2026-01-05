#!/bin/bash
# Check DNS configuration and performance

echo "Current DNS Servers:"
cat /etc/resolv.conf | grep nameserver
echo ""

echo "Testing DNS resolution speed:"
domains=("google.com" "github.com" "aws.amazon.com" "stackoverflow.com")

for domain in "${domains[@]}"; do
    echo -n "$domain: "
    time dig $domain +short > /dev/null 2>&1
done
echo ""

echo "Testing different DNS servers:"
echo "Your DNS:"
dig google.com @$(cat /etc/resolv.conf | grep nameserver | head -1 | awk '{print $2}') +short

echo "Google DNS (8.8.8.8):"
dig google.com @8.8.8.8 +short

echo "Cloudflare DNS (1.1.1.1):"
dig google.com @1.1.1.1 +short
