#!/bin/bash

echo "=== Filesystem Hierarchy Exploration ==="
echo ""

directories=(
    "/"
    "/bin"
    "/etc"
    "/home"
    "/var"
    "/tmp"
    "/usr"
    "/opt"
    "/boot"
)

for dir in "${directories[@]}"; do
    if [ -d "$dir" ]; then
        echo "Directory: $dir"
        echo "Size: $(du -sh $dir 2>/dev/null | cut -f1)"
        echo "Files: $(find $dir -maxdepth 1 -type f 2>/dev/null | wc -l)"
        echo "Subdirs: $(find $dir -maxdepth 1 -type d 2>/dev/null | wc -l)"
        echo "---"
    fi
done
