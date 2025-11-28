# Learning Grasshopper section Advanced Text-Fu

1. regex (Regular Expressions)
2. Text Editors
3. Vim (Vi Improved)
4. Vim Search Patterns
5. Vim Navigation
6. Vim Inserting and Appeding Text
7. Vim Editing
8. Vim Saving and Exiting
9. Emacs
10. Emacs Manipulate Files
11. Emacs Buffer Navigation
12. Emacs Editing
13. Emacs Exiting and Help

Practice done:

## Regex
- Practiced email extraction: 'grep -E pattern'
- Learned phone number matching
- Used -o flag for exact matches

## Vim
- Learned hjkl navigation
- Insert mode: i, a, I, A, o, O
- Editing: dd, yy, p, u, x
- Search: /pattern, n, N
- Replace: :%s/old/new/g

## Vim Commands Practiced
- Vim Navigation
h - move left
j - move down
k - move up  
l - move right
w - next word
b - previous word
0 - beginning of line
$ - end of line
gg - top of file
G - bottom of file
5G - go to line 5
/practice - search for "practice"
n - next search result
:q! - quit without saving

- Vim Insert/Append
i - insert before cursor
a - append after cursor
I - insert at beginning of line
A - append at end of line
o - open new line below
O - open new line above
ESC - always returns to NORMAL mode

- Vim Editing Commands
x - delete character under cursor
dd - delete entire line
dw - delete word
d$ - delete to end of line
yy - copy (yank) line
p - paste below
P - paste above
u - undo
Ctrl+r - redo
cw - change word (delete and enter insert mode)
r - replace single character
:wq - save and quit

- Vim Search and Replace
/cat - search for "cat"
n - next occurrence
N - previous occurrence
:%s/cat/dog/g - replace all "cat" with "dog"
:%s/cat/dog/gc - replace with confirmation
:noh - remove search highlighting
:wq - save and quit

- Vim Saving and Exiting
:w - save (write)
:q - quit (only if no changes)
:wq - save and quit
:q! - quit without saving
ZZ - save and quit (shortcut)
:x - save and quit (only if changes made)


## Advanced Text Processing
- With help (need to practice more)
'sed' - (Stream Editor)
'awk' - (Pattern Scanning)
'cut' - (Column Extraction)
'sort' | 'uniq' - sort and uniq


## Mistakes Made
[Most mistakes with enter or exit NORMAL mode. For beginning to much commands, but I organized cheet sheet.]

## Time Spent
[Took me about 4-5 hours learn basics and that is only beginning. Need more practice.]
