# Advanced Git Branching Patterns


## Cherry-picking (applying specific commits):
# Scenario: You made commits on wrong branch
git checkout -b feature/wrong-branch

echo "Feature A" > featureA.txt
git add featureA.txt
git commit -m "Add feature A"

echo "Feature B" > featureB.txt
git add featureB.txt
git commit -m "Add feature B"

echo "Bugfix" > bugfix.txt
git add bugfix.txt
git commit -m "Fix critical bug"  # This should be on main!

echo "Feature C" > featureC.txt
git add featureC.txt
git commit -m "Add feature C"

# Oops - the bugfix commit should be on main, not here
# Get the commit hash
git log --oneline

# Let's say bugfix commit is abc1234
BUGFIX_HASH=$(git log --oneline | grep "Fix critical bug" | awk '{print $1}')

# Switch to main and cherry-pick just that commit
git checkout main
git cherry-pick $BUGFIX_HASH

# Now the bugfix is on main!
git log --oneline

# Optional: Remove it from feature branch (if you want)
git checkout feature/wrong-branch
git rebase -i HEAD~4  # Interactive rebase last 4 commits
# In editor, delete the bugfix line


## Interactive rebase (reordering, editing, dropping commits):
# Create messy commit history
git checkout -b feature/messy-work

echo "Step 1" > work.txt
git add work.txt
git commit -m "Start work"

echo "Step 2" >> work.txt
git add work.txt
git commit -m "Continue work"

echo "WIP - not done" >> work.txt
git add work.txt
git commit -m "WIP commit"

echo "Step 3" >> work.txt
git add work.txt
git commit -m "Finish work"

echo "Fix typo" >> work.txt
git add work.txt
git commit -m "Fix typo from step 1"

# This history is messy - let's clean it up
git rebase -i HEAD~5

# In the editor you'll see:
# pick abc123 Start work
# pick def456 Continue work
# pick ghi789 WIP commit
# pick jkl012 Finish work
# pick mno345 Fix typo from step 1

# Change to:
# pick abc123 Start work
# squash mno345 Fix typo from step 1
# pick def456 Continue work
# drop ghi789 WIP commit
# pick jkl012 Finish work

# Save and close
# You'll get another editor for commit messages - clean them up

git log --oneline  # Beautiful, clean history!


## Practice: Git stash (save work temporarily)
git checkout main
git checkout -b feature/stash-practice

echo "Half-done work" > temp.txt
git add temp.txt

# Suddenly need to switch branches for urgent fix
# But you don't want to commit half-done work

git stash  # Saves your changes temporarily

# Your working directory is now clean
git status

# Do your urgent work
git checkout main
echo "Urgent fix" > urgent.txt
git add urgent.txt
git commit -m "Urgent production fix"

# Go back and restore your work
git checkout feature/stash-practice
git stash pop  # Restores your changes

# Continue working
echo "Completed work" >> temp.txt
git add temp.txt
git commit -m "Complete feature"


## Real DevOps scenario: Hotfix workflow
mkdir devops-git-scenarios
cd devops-git-scenarios
git init

# Setup production code
cat > app.py << 'EOF'
#!/usr/bin/env python3
# Production application

def calculate_price(amount):
    tax = 0.20
    return amount * (1 + tax)

if __name__ == "__main__":
    print(f"Price with tax: ${calculate_price(100)}")
EOF

git add app.py
git commit -m "Initial production release"
git tag v1.0.0

# Push to GitHub
git branch -M main
# Create repo "devops-git-scenarios" on GitHub first
git remote add origin git@github.com:NikKnez/devops-git-scenarios.git
git push -u origin main
git push origin v1.0.0

# Start working on new feature
git checkout -b feature/discount-code

cat > app.py << 'EOF'
#!/usr/bin/env python3
# Production application

def calculate_price(amount, discount=0):
    tax = 0.20
    discounted = amount * (1 - discount)
    return discounted * (1 + tax)

if __name__ == "__main__":
    print(f"Price with tax: ${calculate_price(100)}")
    print(f"Price with 10% discount: ${calculate_price(100, 0.10)}")
EOF

git add app.py
git commit -m "WIP: Add discount code feature"

# URGENT: Bug in production! Tax calculation is wrong!
# Need to hotfix immediately

# Save current work
git stash

# Create hotfix branch from production (main)
git checkout main
git checkout -b hotfix/fix-tax-calculation

cat > app.py << 'EOF'
#!/usr/bin/env python3
# Production application

def calculate_price(amount):
    tax = 0.21  # Fixed: Was 0.20, should be 0.21
    return amount * (1 + tax)

if __name__ == "__main__":
    print(f"Price with tax: ${calculate_price(100)}")
EOF

git add app.py
git commit -m "hotfix: correct tax rate from 20% to 21%"

# Merge to main (production)
git checkout main
git merge hotfix/fix-tax-calculation
git tag v1.0.1
git push origin main
git push origin v1.0.1

# Now update your feature branch with the fix
git checkout feature/discount-code
git merge main  # Get the hotfix into your feature

# Restore your work in progress
git stash pop

# Resolve any conflicts and continue
cat > app.py << 'EOF'
#!/usr/bin/env python3
# Production application

def calculate_price(amount, discount=0):
    tax = 0.21  # Using fixed tax rate
    discounted = amount * (1 - discount)
    return discounted * (1 + tax)

if __name__ == "__main__":
    print(f"Price with tax: ${calculate_price(100)}")
    print(f"Price with 10% discount: ${calculate_price(100, 0.10)}")
EOF

git add app.py
git commit -m "feat: add discount code feature with corrected tax"

# Feature complete - merge to main
git checkout main
git merge feature/discount-code
git tag v1.1.0
git push origin main
git push origin v1.1.0

# Cleanup
git branch -d hotfix/fix-tax-calculation
git branch -d feature/discount-code
