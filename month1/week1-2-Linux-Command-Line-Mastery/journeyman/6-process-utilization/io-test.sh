#!/bin/bash

echo "=== I/O Monitoring Demo ==="
echo ""

echo "Creating I/O load..."
# Write test
dd if=/dev/zero of=/tmp/testfile bs=1M count=100 2>&1 | grep copied

# Read test
dd if=/tmp/testfile of=/dev/null bs=1M 2>&1 | grep copied

# Cleanup
rm /tmp/testfile

echo ""
echo "I/O test completed"
