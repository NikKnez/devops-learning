# Git for DevOps - Complete Reference

## Daily DevOps Workflow

### Morning Routine
```bash
git checkout main
git pull origin main
git checkout develop
git pull origin develop
```

### Starting New Work
```bash
git checkout develop
git checkout -b feature/descriptive-name
# Work...
git add .
git commit -m "feat(module): descriptive message"
```

### Before Pushing
```bash
# Check what you're about to push
git log origin/develop..HEAD

# Rebase on latest develop
git fetch origin
git rebase origin/develop

# If conflicts, resolve and continue
git add resolved-file.txt
git rebase --continue

# Push
git push -u origin feature/descriptive-name
```

### After PR Merged
```bash
git checkout develop
git pull origin develop
git branch -d feature/descriptive-name
git push origin --delete feature/descriptive-name
```

## Infrastructure as Code Workflows

### Terraform Changes
```bash
# Always in feature branch
git checkout -b infra/add-monitoring

# Make Terraform changes
vim terraform/main.tf

# Test locally
terraform plan

# Commit with clear message
git add terraform/
git commit -m "infra(terraform): add CloudWatch alarms for EC2

- CPU utilization alarm at 80%
- Memory utilization alarm at 85%
- SNS notifications to ops team"

git push -u origin infra/add-monitoring
# Create PR for review
```

### CI/CD Pipeline Changes
```bash
git checkout -b ci/improve-pipeline

# Update pipeline
vim .github/workflows/deploy.yml

git add .github/workflows/
git commit -m "ci(github-actions): add automated testing stage

- Run unit tests before deployment
- Add lint checks for Terraform
- Fail pipeline if tests fail"
```

## Commit Message Conventions

### Format
```
<type>(<scope>): <subject>

<body>

<footer>
```

### Types for DevOps
- **feat**: New feature or infrastructure
- **fix**: Bug fix or infrastructure issue
- **infra**: Infrastructure changes (Terraform, CloudFormation)
- **ci**: CI/CD pipeline changes
- **config**: Configuration changes
- **docs**: Documentation
- **refactor**: Code/infrastructure refactoring
- **perf**: Performance improvements
- **test**: Adding tests
- **chore**: Maintenance, dependencies

### Examples
```bash
feat(k8s): add horizontal pod autoscaler

Implements HPA for web application:
- Min replicas: 2
- Max replicas: 10
- Target CPU: 70%

### Closes
```
```bash
fix(docker): resolve container restart loop

Issue: Container was crashing due to missing
environment variable.

Solution: Added default value in Dockerfile and updated deployment docs.

### Fixes
```bash
infra(terraform): migrate to module structure

Refactored monolithic Terraform config into
reusable modules:
- networking module
- compute module
- database module

No infrastructure changes, structural only.
```

## Branch Protection Rules (Set on GitHub)

### For `main` (Production)
- Require pull request before merging
- Require approvals (at least 1)
- Require status checks to pass (CI/CD)
- Require branches to be up to date
- Include administrators
- Restrict who can push
- Allow force pushes (NEVER)

### For `develop`
- Require pull request before merging
- Require status checks to pass
- Optional: Require approvals (good for teams)

### For `feature/*`
- No restrictions (your playground)

## Git Workflow for Incidents

### Production Hotfix
```bash
# Critical bug in production
git checkout main
git pull origin main
git checkout -b hotfix/fix-critical-bug

# Make minimal fix
vim app.py

# Test thoroughly
python -m pytest tests/

git add app.py
git commit -m "hotfix(app): fix division by zero error

Critical production bug causing 500 errors.
Added validation for zero values.

Incident: INC-2025-001"

# Emergency deployment
git push -u origin hotfix/fix-critical-bug

# Create PR, get quick review, merge
git checkout main
git pull origin main
git tag v1.2.1
git push origin v1.2.1

# Apply to develop too
git checkout develop
git merge main
git push origin develop
```

### Rollback Deployment
```bash
# Find last good version
git tag

# Rollback to previous release
git checkout v1.2.0

# Deploy this version (trigger CI/CD manually)
# Or create rollback tag
git tag v1.2.2-rollback
git push origin v1.2.2-rollback
```

## Git Commands Cheat Sheet

### Essential Daily Commands
```bash
git status                  # What's changed
git log --oneline --graph   # History
git diff                    # Unstaged changes
git diff --cached           # Staged changes
git add -p                  # Stage parts of files
git commit --amend          # Fix last commit
git push --force-with-lease # Safe force push
git fetch --prune           # Update remote refs
```

### Debugging
```bash
git blame file.txt          # Who changed what
git log -S "search term"    # Find commits with text
git bisect start            # Find bug introduction
git reflog                  # Find lost commits
```

### Advanced
```bash
git cherry-pick abc123      # Apply specific commit
git rebase -i HEAD~5        # Clean up last 5 commits
git stash save "WIP"        # Save work temporarily
git worktree add ../hotfix  # Work on multiple branches
```

## Git Aliases (Add to ~/.gitconfig)
```ini
[alias]
    st = status -sb
    co = checkout
    br = branch
    ci = commit
    unstage = reset HEAD --
    last = log -1 HEAD
    visual = log --oneline --graph --decorate --all
    amend = commit --amend --no-edit
    pushf = push --force-with-lease
    sync = !git fetch --prune && git pull --rebase
```

## Emergency Recovery

### Undo last commit (not pushed)
```bash
git reset --soft HEAD~1     # Keep changes staged
git reset --mixed HEAD~1    # Keep changes unstaged
git reset --hard HEAD~1     # DELETE changes
```

### Undo after push
```bash
git revert HEAD             # Create new commit that undoes
git push origin main
```

### Recover deleted branch
```bash
git reflog
git checkout -b recovered-branch abc123
```

### Recover deleted file
```bash
git checkout HEAD~1 -- deleted-file.txt
```

## Best Practices Summary

1. **Commit often** - Small, focused commits
2. **Pull before push** - Always sync first
3. **Write clear messages** - Future you will thank you
4. **Use feature branches** - Never commit directly to main
5. **Rebase before PR** - Clean linear history
6. **Review before merge** - Two pairs of eyes minimum
7. **Tag releases** - Semantic versioning (v1.2.3)
8. **Delete merged branches** - Keep repo clean
9. **Never commit secrets** - Use environment variables
10. **Backup important work** - Push frequently

## Key Takeaway
**Git is not just version control - it's the backbone of your entire DevOps workflow.**

Every deployment, every infrastructure change, every configuration update flows through Git.
Master it, and you master DevOps collaboration.
