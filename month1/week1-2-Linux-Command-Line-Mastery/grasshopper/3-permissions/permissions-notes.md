# Permissions Practice

## What I Learned

### Basic Permissions (rwx)
- r (4) = read
- w (2) = write
- x (1) = execute

### Commands Mastered
- `chmod 755 file` - numeric method
- `chmod u+x file` - symbolic method
- `chown user:group file` - change ownership
- `umask` - default permissions for new files

### Special Permissions
- setuid (4000) - runs as file owner
- setgid (2000) - runs as group or inherits group
- sticky (1000) - only owner can delete

## Practical Examples
[Scenario 1: Web Server Directory]
[Scenario 2: Backup Directory]
[Scenario 3: Shared Team Directory]

## Permission Patterns I'll Use
- 644 for regular files
- 755 for executables and directories
- 600 for sensitive files
- 700 for private directories

## Time Spent
[It took me two days about three to four hours a day to complete.]
