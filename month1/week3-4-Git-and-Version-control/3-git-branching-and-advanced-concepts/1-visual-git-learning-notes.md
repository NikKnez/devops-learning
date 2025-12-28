# Visual Git Learning

## Learn Git Branching - Completed Levels
- Introduction Sequence (1-4): ✅
- Ramping Up (1-4): ✅

## Key Concepts

### Relative References
- `HEAD` - Currently checked out commit
- `HEAD~1` - One commit before HEAD
- `HEAD~2` - Two commits before HEAD
- `HEAD^` - Parent of HEAD (same as HEAD~1)
- `HEAD^^` - Grandparent (same as HEAD~2)

### Detached HEAD
When you `git checkout <commit-hash>`, you're in "detached HEAD" state:
- You're not on any branch
- You can look around and make experimental commits
- Commits made here will be lost unless you create a branch
- Use: Inspecting old code, testing something

### Undoing Changes

**Local only (not pushed):**
```bash
git reset HEAD~1        # Undo commit, keep changes
git reset --hard HEAD~1 # Undo commit, DELETE changes
```

**Already pushed (shared branch):**
```bash
git revert HEAD         # Create new commit that undoes
```

### Force Moving Branches
```bash
git branch -f main HEAD~2  # Move main branch back 2 commits
```
⚠️ **DANGEROUS** - only use locally, never on shared branches

## DevOps Applications
1. **Detached HEAD**: Inspect production code from specific release
2. **Relative refs**: Quick navigation without commit hashes
3. **git revert**: Undo bad production deployment safely
4. **git reset**: Clean up local commits before pushing

## Practice Summary
- Created test repo with multiple commits
- Practiced navigating with HEAD~N syntax
- Tested all three methods of undoing changes
- Understood when to use each method

## Key Rule
**NEVER use `git reset` on pushed commits - use `git revert` instead**
