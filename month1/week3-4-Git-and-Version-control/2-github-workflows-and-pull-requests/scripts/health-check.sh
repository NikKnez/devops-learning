#!/bin/bash
# Basic health check script

check_service() {
    systemctl is-active --quiet $1
    if [ $? -eq 0 ]; then
        echo "✓ $1 is running"
    else
        echo "✗ $1 is NOT running"
    fi
}

check_service nginx
check_service docker
