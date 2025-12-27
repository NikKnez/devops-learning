# Fork and Pull Request Workflow

## Steps to contribute to external projects

### 1. Fork repository
- Go to target repo on GitHub
- Click "Fork" button
- Now you have your own copy

### 2. Clone your fork
```bash
git clone git@github.com:YourUsername/their-project.git
cd their-project
```

### 3. Add upstream remote
```bash
git remote add upstream git@github.com:TheirUsername/their-project.git
git remote -v
```

### 4. Create feature branch
```bash
git checkout -b fix/typo-in-readme
```

### 5. Make changes and commit
```bash
# Fix the typo
git add README.md
git commit -m "docs: fix typo in installation instructions"
```

### 6. Push to YOUR fork
```bash
git push origin fix/typo-in-readme
```

### 7. Create Pull Request
- Go to YOUR fork on GitHub
- Click "Compare & pull request"
- Base repository: their-project (upstream)
- Base branch: main
- Head repository: your-fork
- Compare branch: fix/typo-in-readme

### 8. Keep fork synchronized
```bash
git checkout main
git fetch upstream
git merge upstream/main
git push origin main
```

## Best Practices for External PRs
- Read CONTRIBUTING.md first
- Keep changes focused and small
- Follow their code style
- Write clear commit messages
- Be responsive to feedback
- Be patient and polite
