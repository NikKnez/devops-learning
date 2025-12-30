# Remote Repositories & Collaboration


## Practice remote workflows
mkdir remote-collaboration
cd remote-collaboration
git init

# Create initial structure
cat > README.md << 'EOF'
# Remote Collaboration Practice

Practicing Git remote workflows for team collaboration.

## Scenarios
1. Fetch vs Pull
2. Dealing with remote changes
3. Force push (and why to avoid it)
4. Tracking branches
EOF

git add README.md
git commit -m "Initial commit"

# Create GitHub repo and push
git branch -M main
# Create "remote-collaboration" repo on GitHub
git remote add origin git@github.com:NikKnez/remote-collaboration.git
git push -u origin main

# Check remote configuration
git remote -v
git remote show origin


## 
Scenario 1: Someone else pushed while you were working
# You make local changes
echo "## Local Work" >> README.md
git add README.md
git commit -m "Add local work section"

# Simulate remote change (do this on GitHub):
# Go to your repo on GitHub → Edit README.md → Add a line at the top:
# "# Updated from GitHub interface"

# Now try to push
git push origin main
# ERROR! Remote has changes you don't have

# Fetch to see what changed
git fetch origin

# See difference between your code and remote
git log --oneline --graph --all

# View the changes
git diff main origin/main

# Pull with rebase (keeps history linear)
git pull --rebase origin main

# OR pull with merge (creates merge commit)
git pull origin main

# Now push works
git push origin main


## Scenario 2: Tracking branches
# Create feature branch and push
git checkout -b feature/add-examples

mkdir examples
cat > examples/example1.sh << 'EOF'
#!/bin/bash
# Example automation script
echo "Hello from automation"
EOF

git add examples/
git commit -m "Add example script"

# Push and set upstream tracking
git push -u origin feature/add-examples

# Now you can just use "git push" and "git pull"
echo "More examples" > examples/example2.sh
git add examples/
git commit -m "Add second example"
git push  # No need to specify origin feature/add-examples

# List all branches (local and remote)
git branch -a

# List tracking info
git branch -vv


## Scenario 3: Cleaning up remote branches
# Merge feature and delete remote branch
git checkout main
git pull origin main
git merge feature/add-examples
git push origin main

# Delete remote branch
git push origin --delete feature/add-examples

# Delete local branch
git branch -d feature/add-examples

# Update your remote branch list
git fetch --prune

# See what's left
git branch -a


## Scenario 4: Force push (DANGEROUS - know when to use)
# Create new feature
git checkout -b feature/documentation

cat > CONTRIBUTING.md << 'EOF'
# Contributing

Please follow these guidelines.
EOF

git add CONTRIBUTING.md
git commit -m "Add contributing guide"
git push -u origin feature/documentation

# Oops, made 3 messy commits
echo "Guide part 1" >> CONTRIBUTING.md
git add CONTRIBUTING.md
git commit -m "Update guide"

echo "Guide part 2" >> CONTRIBUTING.md
git add CONTRIBUTING.md
git commit -m "More updates"

echo "Guide part 3" >> CONTRIBUTING.md
git add CONTRIBUTING.md
git commit -m "Final updates"

git push origin feature/documentation

# Want to clean this up with interactive rebase
git rebase -i HEAD~3
# Squash the 3 updates into one commit

# Now your local history differs from remote
git push origin feature/documentation
# ERROR! Remote has different history

# Force push (ONLY on YOUR feature branch, NEVER on shared branches)
git push --force-with-lease origin feature/documentation

# --force-with-lease is safer than --force
# It checks that nobody else pushed since your last fetch
