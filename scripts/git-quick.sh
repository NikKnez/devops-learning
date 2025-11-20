#!/bin/bash

# Quick Git Commit and Push Script
# Automates: add, commit, push workflow
# Usage: ./git-quick.sh [directory] [commit-message]


# Get directory from argument or use current directory
TARGET_DIR="${1:-.}"

# Change to target directory
cd "$TARGET_DIR" || {
	echo "Error: Cannot access directory $TARGET_DIR"
	exit 1
}

echo "Working in: $(pwd)"

# Check if we're in a git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
	echo "Error: Not a git repository!"
	echo "Run 'git init' first or cd into a git repo"
	exit 1
fi

# Check if there are any changes
if [ -z "$(git status --porcelain)" ]; then
	echo "No changes to commit. Working directory is clean."
	exit 0
fi

# Show what will be committed
echo "Changes to be commited:"
git status --short
exho ""


# Get commit message from argument or ask user
if [ -n "$2" ]; then
	COMMIT_MSG="$2"
else
	read -p "Enter commit message (or press Enter for default): " COMMIT_MSSG

	if [ -z "$COMMIT_MSG" ] then
		COMMIT_MSG="Update: $(date '+%Y-%m-%d %H:%M:%S')"
	fi
fi


# Add all changes
echo "Adding all changes..."
git add .

# Commit
echo "Committing with message: $COMMIT_MSG"
git commit -m "COMMIT_MSG"


# Check if commit was successful
if [ $? -ne 0 ]; then
	echo "Commit failed!"
	exit 1
fi


# Push to remote
echo "Pushing to remote..."
git push

if [ $? -eq 0 ]; then
	echo ""
	echo "Success! Changes pushed to GitHub."
else
	echo ""
	echo "Push failed. Check your remote connection"
	exit 1
fi


# It can be used in 3 ways:

# 1. From current directory
# ./git-quick.sh

# 2. From any directory, target specific repo
# ./git-quick.sh /home/nikola/devops-learning

# 3. With custom commit message
# ./git-quick.sh /home/nikola/devops-learning [Added new feature]
