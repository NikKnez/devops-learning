# Git Basics


# Configure Git (if not done)
git config --global user.name "Nikola Knezevic"
git config --global user.email "your-email@example.com"
git config --global core.editor "vim"

# Create practice repo
cd ~/devops-learning/month1/week3
mkdir git-basics
cd git-basics
git init

# Create README
cat > README.md << 'EOF'
# Git Practice Repository

Learning Git fundamentals for DevOps workflows.

## Topics Covered
- Basic commits
- Branching and merging
- Collaboration workflows
- CI/CD integration
EOF

git add README.md
git commit -m "Initial commit: Add README"

# Create .gitignore
cat > .gitignore << 'EOF'
# OS files
.DS_Store
Thumbs.db

# Editor files
*.swp
*.swo
*~

# Logs
*.log

# Credentials
.env
secrets/
EOF

git add .gitignore
git commit -m "Add .gitignore for common files"

# Push to GitHub
# First create repo on GitHub: "git-basics"
git branch -M main
git remote add origin git@github.com:NikKnez/git-basics.git
git push -u origin main


## Practice Exercise:
# Create multiple commits
echo "# Day 15 Practice" >> notes.md
git add notes.md
git commit -m "Add notes file"

echo "Git is version control for code" >> notes.md
git add notes.md
git commit -m "Add Git definition"

echo "DevOps teams use Git daily" >> notes.md
git add notes.md
git commit -m "Add DevOps context"

# View history
git log
git log --oneline
git log --oneline --graph

# View specific commit
git show HEAD
git show HEAD~1
git show HEAD~2

# View changes
git diff HEAD~2 HEAD
