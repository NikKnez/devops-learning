#!/bin/bash
echo "=== Process Permission Info ==="
echo "Real User: $(whoami)"
echo "Real UID: $(id -ru)"
echo "Effective UID: $(id -u)"
echo "Real GID: $(id -rg)"
echo "Effective GID: $(id -g)"
echo "All groups: $(id -G)"
