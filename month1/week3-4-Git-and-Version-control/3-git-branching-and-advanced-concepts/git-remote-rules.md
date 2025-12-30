# Git Remote Workflow Rules


## Golden Rules

### ALWAYS SAFE
1. `git pull` before `git push`
2. `git fetch` to check remote state
3. `git pull --rebase` for cleaner history
4. `--force-with-lease` over `--force`
5. Delete merged branches (remote and local)

### BE CAREFUL
1. `git push --force-with-lease` - Only on YOUR branches
2. `git rebase` - Only before pushing
3. Force pushing - Only to feature branches, NEVER to main/develop

### NEVER DO THIS
1. `git push --force` to shared branches (main, develop)
2. `git rebase` after pushing (rewrites history others have)
3. Commit sensitive data (passwords, API keys, secrets)
4. Push directly to main (always use PRs)


## Workflow for Team Collaboration

### Daily Workflow
```bash
# Start of day
git checkout main
git pull origin main

# Create feature
git checkout -b feature/my-work
# Do work...
git add .
git commit -m "feat: add new feature"

# Before pushing - rebase on latest main
git fetch origin
git rebase origin/main

# Push your feature
git push -u origin feature/my-work

# Create PR on GitHub
# After PR approved and merged
git checkout main
git pull origin main
git branch -d feature/my-work
```

### Dealing with Conflicts
```bash
# If rebase causes conflicts
git rebase origin/main
# CONFLICT in file.txt

# Fix conflicts in file
vim file.txt

# Mark as resolved
git add file.txt
git rebase --continue

# If it's too messy
git rebase --abort  # Start over
```

### Multiple Remotes (Fork workflow)
```bash
# Add upstream (original repo)
git remote add upstream git@github.com:original/repo.git

# Fetch upstream changes
git fetch upstream

# Merge upstream into your fork
git checkout main
git merge upstream/main
git push origin main
```


## Remote Branch Management

### List all branches
```bash
git branch -a              # All local and remote
git branch -r              # Only remote
git branch -vv             # With tracking info
```

### Sync with remote
```bash
git fetch --all --prune    # Fetch all, remove stale branches
git remote prune origin    # Remove stale remote-tracking branches
```

### Track existing remote branch
```bash
git checkout --track origin/feature-branch
```


## Emergency: Undo force push (if you messed up)
```bash
# Find the commit you want to restore
git reflog

# Reset to that commit
git reset --hard <commit-hash>

# Force push (carefully!)
git push --force-with-lease origin branch-name
```

## Key Takeaway
**Treat shared branches (main, develop) as sacred.**
**Your feature branches are your playground.**
