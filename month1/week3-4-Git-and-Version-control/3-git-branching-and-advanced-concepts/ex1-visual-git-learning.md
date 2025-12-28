# Visual Git Learning (Learn Git Branching)

mkdir git-branching-practice
cd git-branching-practice
git init

# Create some commits to practice
echo "Initial commit" > file1.txt
git add file1.txt
git commit -m "Commit 1"

echo "Second commit" > file2.txt
git add file2.txt
git commit -m "Commit 2"

echo "Third commit" > file3.txt
git add file3.txt
git commit -m "Commit 3"

# Practice: Relative refs (what you learned)
git log --oneline

# HEAD~1 means "one commit before HEAD"
git show HEAD~1

# HEAD~2 means "two commits before HEAD"
git show HEAD~2

# HEAD^ means "parent of HEAD" (same as HEAD~1)
git show HEAD^

# Checkout specific commit by relative ref
git checkout HEAD~2
# You're in "detached HEAD" state - this is OK for looking around

# Go back to branch
git checkout main

# Create branch at specific commit
git branch test-branch HEAD~1
git log --oneline --graph --all

# Force move branch pointer (careful with this!)
git branch -f main HEAD~1
git log --oneline --graph --all

# Undo that
git branch -f main HEAD~0  # Move back to where it was


## Practice: Reversing changes
# Method 1: git reset (rewrites history - use locally only)
echo "Mistake" >> file1.txt
git add file1.txt
git commit -m "Bad commit"

# Undo the commit (keep changes in working directory)
git reset HEAD~1
git status  # Changes are still there, uncommitted

# Add back properly
git add file1.txt
git commit -m "Correct commit"

# Method 2: git reset --hard (DANGEROUS - loses changes)
echo "Another mistake" >> file2.txt
git add file2.txt
git commit -m "Another bad commit"

git reset --hard HEAD~1  # Changes are GONE forever

# Method 3: git revert (safe for shared branches)
echo "Public mistake" >> file3.txt
git add file3.txt
git commit -m "Public bad commit"

# Create NEW commit that undoes the previous one
git revert HEAD
# This is safe for branches others are using

git log --oneline  # You'll see both commits
