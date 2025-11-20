#!/bin/bash

# Log File Cleaner
# Finds and deletes old log files to free up disk space
# Usage: ./clean-logs.sh [directory] [days] [pattern]

# Get arguments or use defaults
LOG_DIR="${1:-home/nikola/devops-learning}" # Directory to search
DAYS_OLD="${2:-7}" # Delete logs older this many days
LOG_PATTERN="${3:-*.log}" # File pattern to match


echo "============================================"
echo "Log File Cleaner"
echo "============================================"
echo "Searching in: $LOG_DIR"
echo "Pattern: $LOG_PATTERN"
echo "Older than: $DAYS_OLD days"
echo ""


# Check if directory exists
if [ ! -d "$LOG_DIR" ]; then
	echo "Error: Directory $LOG_DIR does not exist!"
	exit 1
fi


# Find old log files
OLD_FILES=$(find "$LOG_DIR" -type f -name "$LOG_PATTERN" -mtime +$DAYS_OLD 2>/dev/null)

# Check if any files found
if [ -z "$OLD_FILES" ]; then
	echo "No old log files found. Nothing to clean."
	exit 0
fi

# Count files and calculate total size
FILE_COUNT=$(echo "$OLD_FILES" | wc -l)
TOTAL_SIZE=$(echo "$OLD_FILES" | xargs du -ch 2>/dev/null | tail -1 | cut -f1)

echo "Found $FILE_COUNT old log file(s)"
echo "Total size: $TOTAL_SIZE"
echo ""
echo "Files to be deleted:"
echo "$OLD_FILES"
echo ""

# Ask for confirmation
read -p "Delete these file(s)? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
	echo "Cancelled. No files deleted."
	exit 0
fi

# Delete files
echo ""
echo "Deleting file(s)..."
echo "$OLD_FILES" | xargs rm -f

if [ $? -eq 0 ]; then
	echo "Success! Deleted $FILE_COUNT file(s), freed up $TOTAL_SIZE"
else
	echo "Error: Some file(s) could not be deleted."
	exit 1
fi


# Can be used flexibly

# 1. Use all defaults (current dir, 7 days, *.log)
# ./clean-logs.sh

# 2. Different directory
# ./clean-logs.sh /var/log

# 3. Different directory and days
# ./clean-logs.sh /var/log 30

# 4. All custom parameters
# ./clean-logs.sh /home/nikola/devops-learning 14 [*.txt]
