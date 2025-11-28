#!/bin/bash

# Save original umask
ORIGINAL_UMASK=$(umask)

# Set restrictive umask for sensitive files
umask 0077

# Create sensitive file
touch sensitive-data.txt
echo "confidential" > sensitive-data.txt

# Restore original umask
umask $ORIGINAL_UMASK

# Create normal file
touch normal-file.txt

echo "Created files with different umasks"
ls -l sensitive-data.txt normal-file.txt
