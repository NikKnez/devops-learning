# GitHub Workflows & Pull Requests

## Key Concepts Learned

### Pull Request Workflow
1. Create feature branch
2. Make changes and commit
3. Push branch to GitHub
4. Open Pull Request
5. Code review process
6. Address feedback
7. Merge to main/develop

### Branch Strategies

**GitFlow** (what we practiced):
```
main (production)
  ↑
release/v1.0.0
  ↑
develop (integration)
  ↑
feature/* (individual features)
```

**Trunk-based Development** (alternative):
```
main
  ↑
short-lived feature branches
```

### Code Review Best Practices
- Review for logic, not style (use linters for style)
- Ask questions, don't demand changes
- Suggest improvements, explain why
- Approve quickly if changes are good
- Request changes if issues found

### Real DevOps Applications
1. **Feature branches** → Test infrastructure changes safely
2. **PRs** → Peer review before production
3. **Branch protection** → Prevent direct pushes to main
4. **CI/CD integration** → Automated tests on every PR
5. **Release branches** → Prepare production deployments

## Commands Learned
- `git push origin <branch>` - Push branch to GitHub
- `git pull origin <branch>` - Sync with remote
- `git tag -a v1.0.0 -m "message"` - Create annotated tag
- `git push origin v1.0.0` - Push tag
- `git remote add upstream <url>` - Add upstream remote
- `git fetch upstream` - Fetch from upstream

## GitHub Features Used
- Pull Requests
- Code Review
- Branch protection rules
- Releases and tags
- Forking workflow

## Projects Completed
- **github-workflow-practice** repo
  - 5+ feature branches
  - 5+ pull requests
  - Code review simulation
  - Release process (v1.0.0)
  - GitFlow workflow demonstration

## Practice with Study Partner
- [ ] Fork each other's repos
- [ ] Create PRs to each other's projects
- [ ] Practice code review feedback
- [ ] Merge and manage conflicts together

## Next Steps
- Days 22-25: Learn Git Branching visual challenges
- Days 26-30: Create 5 practice repositories
- Integrate Git with CI/CD (Month 4)

## Key Takeaways
1. **Never commit directly to main** in team projects
2. **Always use PRs** for collaboration and review
3. **Write descriptive PR descriptions** - helps reviewers
4. **Respond to feedback professionally** - it's not personal
5. **Keep branches short-lived** - merge quickly
6. **Delete merged branches** - keeps repo clean

## Real-World DevOps Workflow
```
Developer → Feature branch → Push → PR → Review → 
CI/CD tests → Approval → Merge → Deploy
```

This is how every professional DevOps team works.
