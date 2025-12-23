# Rebase and Clean History

# Create messy feature branch
git checkout -b feature/deploy-script

echo "#!/bin/bash" > deploy.sh
git add deploy.sh
git commit -m "Start deploy script"

echo "echo 'Deploying...'" >> deploy.sh
git add deploy.sh
git commit -m "Add deploy message"

echo "# TODO: Add actual deployment" >> deploy.sh
git add deploy.sh
git commit -m "Add TODO"

echo "docker-compose up -d" >> deploy.sh
git add deploy.sh
git commit -m "Add docker command"

# Oops, forgot to add shebang executable
chmod +x deploy.sh
git add deploy.sh
git commit -m "Make executable"

# Now we have 5 messy commits
# Let's clean them up with interactive rebase

git checkout main
# Make sure main is up to date
git pull origin main

git checkout feature/deploy-script
git rebase -i main

# In the editor, you'll see:
# pick abc1234 Start deploy script
# pick def5678 Add deploy message
# pick ghi9012 Add TODO
# pick jkl3456 Add docker command
# pick mno7890 Make executable

# Change to:
# pick abc1234 Start deploy script
# squash def5678 Add deploy message
# squash ghi9012 Add TODO
# squash jkl3456 Add docker command
# squash mno7890 Make executable

# This combines all commits into one clean commit

# After rebase, merge into main
git checkout main
git merge feature/deploy-script
git push origin main
