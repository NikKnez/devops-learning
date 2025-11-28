# Exercise 2: Text Editors - Vim Basics

#Task 2.1: Create and Edit File with Vim

# Open vim
vim practice.txt

# Once inside vim:
# Press 'i' to enter INSERT mode
# Type: "Learning Vim is essential for DevOps engineers."
# Press ESC to exit INSERT mode
# Type: :wq and press ENTER to save and quit


# Task 2.2: Vim Navigation Practice
# Create a file with content
cat > vim_nav.txt << 'EOF'
Line 1: Navigation practice
Line 2: Move around using keys
Line 3: h = left, j = down, k = up, l = right
Line 4: w = next word, b = previous word
Line 5: 0 = start of line, $ = end of line
Line 6: gg = top of file, G = bottom of file
Line 7: Practice these movements
Line 8: Speed comes with practice
Line 9: Don't use arrow keys
Line 10: Use hjkl instead
EOF

# Open in vim
vim vim_nav.txt

# Practice these (in NORMAL mode):
# h - move left
# j - move down
# k - move up  
# l - move right
# w - next word
# b - previous word
# 0 - beginning of line
# $ - end of line
# gg - top of file
# G - bottom of file
# 5G - go to line 5
# /practice - search for "practice"
# n - next search result
# :q! - quit without saving


# Task 2.3: Vim Insert/Append
vim insert_practice.txt

# Try these commands (start in NORMAL mode):
# i - insert before cursor
# a - append after cursor
# I - insert at beginning of line
# A - append at end of line
# o - open new line below
# O - open new line above
# ESC - always returns to NORMAL mode

# Practice:
# 1. Type 'i', write "First word", press ESC
# 2. Type 'a', write " second word", press ESC
# 3. Type 'A', write " end of line", press ESC
# 4. Type 'o', write "New line below", press ESC
# 5. Type ':wq' to save and quit


# Task 2.4: Vim Editing Commands
cat > edit_practice.txt << 'EOF'
This is a test file for editing practice.
Delete this entire line.
Change this word to something else.
Copy this line and paste it below.
This needs correction: wrng speling here.
EOF

vim edit_practice.txt

# Practice these (NORMAL mode):
# x - delete character under cursor
# dd - delete entire line
# dw - delete word
# d$ - delete to end of line
# yy - copy (yank) line
# p - paste below
# P - paste above
# u - undo
# Ctrl+r - redo
# cw - change word (delete and enter insert mode)
# r - replace single character
# :wq - save and quit


#Task 2.5: Vim Search and Replace
cat > search_replace.txt << 'EOF'
The cat sat on the mat.
The cat was a big cat.
Every cat loves fish.
My cat is orange.
EOF

vim search_replace.txt

# Practice:
# /cat - search for "cat"
# n - next occurrence
# N - previous occurrence
# :%s/cat/dog/g - replace all "cat" with "dog"
# :%s/cat/dog/gc - replace with confirmation
# :noh - remove search highlighting
# :wq - save and quit


# Task 2.6: Vim Saving and Exiting
vim save_exit.txt

# Type something, then try these:
# :w - save (write)
# :q - quit (only if no changes)
# :wq - save and quit
# :q! - quit without saving
# ZZ - save and quit (shortcut)
# :x - save and quit (only if changes made)





















