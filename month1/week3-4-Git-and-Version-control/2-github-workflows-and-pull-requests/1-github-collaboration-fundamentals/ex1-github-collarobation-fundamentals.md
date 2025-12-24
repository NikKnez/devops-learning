# GitHub Collaboration Fundamentals

# Create new repo for collaboration practice
mkdir github-workflow-practice
cd github-workflow-practice
git init

# Create initial structure
cat > README.md << 'EOF'
# GitHub Workflow Practice

This repository demonstrates professional GitHub workflows used in DevOps teams.

## Purpose
- Practice pull requests
- Code review simulation
- Branch protection strategies
- CI/CD integration points

## Structure
- `/scripts/` - Automation scripts
- `/docs/` - Documentation
- `/config/` - Configuration files
EOF

mkdir -p scripts docs config

cat > scripts/health-check.sh << 'EOF'
#!/bin/bash
# Basic health check script

check_service() {
    systemctl is-active --quiet $1
    if [ $? -eq 0 ]; then
        echo "✓ $1 is running"
    else
        echo "✗ $1 is NOT running"
    fi
}

check_service nginx
check_service docker
EOF

chmod +x scripts/health-check.sh

cat > docs/CONTRIBUTING.md << 'EOF'
# Contributing Guidelines

## Branch Naming Convention
- `feature/` - New features
- `bugfix/` - Bug fixes
- `hotfix/` - Urgent production fixes
- `docs/` - Documentation updates

## Commit Message Format
```
type(scope): short description

Detailed explanation if needed

Examples:
- feat(monitoring): add disk space alerts
- fix(deploy): correct docker-compose syntax
- docs(readme): update installation steps
```

## Pull Request Process
1. Create feature branch from `main`
2. Make changes and commit
3. Push branch to GitHub
4. Open Pull Request
5. Request review
6. Address feedback
7. Merge after approval
EOF

git add .
git commit -m "Initial commit: Setup project structure"

# Create GitHub repo and push
# Go to github.com/new and create "github-workflow-practice"
git branch -M main
git remote add origin git@github.com:NikKnez/github-workflow-practice.git
git push -u origin main

## Practice: Create your first Pull Request
# Create feature branch
git checkout -b feature/add-backup-monitoring

# Add new script
cat > scripts/backup-monitor.sh << 'EOF'
#!/bin/bash
# Monitor backup status

BACKUP_DIR="/var/backups"
MAX_AGE_HOURS=24

latest_backup=$(find $BACKUP_DIR -type f -name "*.tar.gz" -mtime -1 | head -1)

if [ -z "$latest_backup" ]; then
    echo "⚠️  WARNING: No backup found in last $MAX_AGE_HOURS hours"
    exit 1
else
    echo "✓ Backup is current: $latest_backup"
    exit 0
fi
EOF

chmod +x scripts/backup-monitor.sh

git add scripts/backup-monitor.sh
git commit -m "feat(monitoring): add backup monitoring script

- Checks for backups within last 24 hours
- Exits with error if backup is stale
- Can be integrated into alerting system"

# Update README
cat >> README.md << 'EOF'

## Scripts
- `health-check.sh` - Service health verification
- `backup-monitor.sh` - Backup freshness check
EOF

git add README.md
git commit -m "docs(readme): document backup-monitor script"

# Push branch
git push origin feature/add-backup-monitoring


## On GitHub (do this in browser):

1. Go to your repo: github.com/NikKnez/github-workflow-practice
2. Click "Pull requests" tab
3. Click "New pull request"
4. Select: base: main ← compare: feature/add-backup-monitoring
5. Click "Create pull request"
## Write PR description:

## Description
Adds backup monitoring script to detect stale backups.

## Changes
- New script: `backup-monitor.sh`
- Updated README with script documentation

## Testing
```bash
# Test with existing backup
./scripts/backup-monitor.sh

# Test with no recent backup
sudo rm -rf /var/backups/*.tar.gz
./scripts/backup-monitor.sh
```

## Checklist
- [x] Script is executable
- [x] Follows naming conventions
- [x] Documentation updated
- [x] Tested locally
6. Click "Create pull request"
7. Don't merge yet - practice review process
